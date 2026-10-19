using System;
using System.Text.RegularExpressions;
using ACT.LocalLoader;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Initialize.Flow;

public class InitShaderVariant : RuntimeLoadFlow
{
	private readonly ShaderVariantCollection _collection;

	private readonly bool _skipWarmup;

	private int _totalVariantCount;

	private int _initialWarmedUpCount;

	private int _totalNeedWarmupCount;

	private MonoHotUpdate _monoHotUpdate;

	private const string ProgressText = "着色器预热中...";

	private const int variantsPerFrame = 2;

	private const int maxNoProgressFrames = 60;

	private const string ShaderVariantCollectionIndexAddress = "PlatformShaderVariantCollectionIndex";

	public override int Weight => _totalNeedWarmupCount;

	public InitShaderVariant()
		: base("InitShaderVariant")
	{
		_skipWarmup = ShouldSkipWarmupForCurrentGpu();
		if (!_skipWarmup && TryLoadPlatformShaderVariantCollection(out var collection))
		{
			_collection = collection;
			_totalVariantCount = _collection.variantCount;
			_initialWarmedUpCount = _collection.warmedUpVariantCount;
			_totalNeedWarmupCount = Mathf.Max(0, _totalVariantCount - _initialWarmedUpCount);
			WaitInitializer.Start(_totalNeedWarmupCount + 1);
		}
		else
		{
			_totalVariantCount = 0;
			_initialWarmedUpCount = 0;
			_totalNeedWarmupCount = 0;
			WaitInitializer.Start(1L);
		}
	}

	protected override void OnStart()
	{
		base.OnStart();
		if (_totalNeedWarmupCount <= 0)
		{
			WaitInitializer.CompleteOne();
			WaitInitializer.SetCurStateComplete();
		}
		else
		{
			InitializeProgressUI();
			StartWarmupShader().Forget();
		}
	}

	protected override void OnComplete()
	{
		WaitInitializer.onUpdate -= UpdateProgressUI;
		base.OnComplete();
	}

	private static bool ShouldSkipWarmupForCurrentGpu()
	{
		string graphicsDeviceName = SystemInfo.graphicsDeviceName;
		if (!string.IsNullOrEmpty(graphicsDeviceName))
		{
			return Regex.IsMatch(graphicsDeviceName, "\\A(?=.*adreno)(?=.*(?:730|740))", RegexOptions.IgnoreCase | RegexOptions.Singleline | RegexOptions.CultureInvariant);
		}
		return false;
	}

	private void InitializeProgressUI()
	{
		_monoHotUpdate = UnityEngine.Object.FindFirstObjectByType<MonoHotUpdate>();
		if (!(_monoHotUpdate == null) && !(_monoHotUpdate.progress == null))
		{
			_monoHotUpdate.SetCanvasActive(active: true);
			_monoHotUpdate.SetProgressBarActive(active: true);
			_monoHotUpdate.progress.value = 0f;
			if ((bool)_monoHotUpdate.progressText)
			{
				_monoHotUpdate.progressText.SetText("着色器预热中...");
			}
			if ((bool)_monoHotUpdate.percentText)
			{
				_monoHotUpdate.percentText.SetText(MonoHotUpdate.ToPercentage(0f, 0));
			}
			if ((bool)_monoHotUpdate.progressNum)
			{
				_monoHotUpdate.progressNum.SetText(string.Empty);
			}
			WaitInitializer.onUpdate -= UpdateProgressUI;
			WaitInitializer.onUpdate += UpdateProgressUI;
			UpdateProgressUI();
		}
	}

	private void UpdateProgressUI()
	{
		if (!(_monoHotUpdate == null) && !(_monoHotUpdate.progress == null))
		{
			float num = Mathf.Clamp01(WaitInitializer.percent);
			_monoHotUpdate.progress.value = num;
			if ((bool)_monoHotUpdate.percentText)
			{
				_monoHotUpdate.percentText.SetText(MonoHotUpdate.ToPercentage(num, 0));
			}
		}
	}

	private async UniTask StartWarmupShader()
	{
		try
		{
			if (_totalNeedWarmupCount > 0)
			{
				await DoWarmup();
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
		finally
		{
			long num = WaitInitializer.Total - WaitInitializer.Current;
			if (num > 0)
			{
				WaitInitializer.AddBatch(num);
			}
		}
	}

	private static bool TryLoadPlatformShaderVariantCollection(out ShaderVariantCollection collection)
	{
		collection = null;
		try
		{
			PlatformShaderVariantCollectionIndex platformShaderVariantCollectionIndex = AssetStationManager.Root.Load<PlatformShaderVariantCollectionIndex>("PlatformShaderVariantCollectionIndex").As<PlatformShaderVariantCollectionIndex>();
			if (platformShaderVariantCollectionIndex == null)
			{
				Debug.LogWarning("[InitShaderVariant] 未找到平台 SVC 索引 PlatformShaderVariantCollectionIndex，跳过本次预热。");
				return false;
			}
			string shaderVariantPlatform = GetShaderVariantPlatform();
			if (shaderVariantPlatform != "Editor" && shaderVariantPlatform != "Win64" && shaderVariantPlatform != "Android" && shaderVariantPlatform != "iOS")
			{
				return false;
			}
			collection = platformShaderVariantCollectionIndex.GetCollection(shaderVariantPlatform);
			if (collection == null)
			{
				Debug.LogWarning("[InitShaderVariant] 平台 SVC 索引中没有 " + shaderVariantPlatform + " SVC，跳过本次预热。");
				return false;
			}
			return true;
		}
		catch (Exception ex)
		{
			Debug.LogWarning("[InitShaderVariant] 平台 SVC 索引加载失败，跳过本次预热：" + ex.Message);
			return false;
		}
	}

	private static string GetShaderVariantPlatform()
	{
		return LuminApplication.GetPlatformName;
	}

	private async UniTask DoWarmup()
	{
		bool finished = false;
		int noProgressFrames = 0;
		while (!finished)
		{
			int warmedUpVariantCount = _collection.warmedUpVariantCount;
			bool flag = _collection.WarmUpProgressively(2);
			int warmedUpVariantCount2 = _collection.warmedUpVariantCount;
			int num = Mathf.Min(_totalNeedWarmupCount, Mathf.Max(0, warmedUpVariantCount2 - _initialWarmedUpCount));
			_initialWarmedUpCount = warmedUpVariantCount2;
			for (int i = 0; i < num; i++)
			{
				WaitInitializer.CompleteOne();
			}
			finished = flag || warmedUpVariantCount2 >= _totalVariantCount;
			if (finished)
			{
				break;
			}
			if (warmedUpVariantCount2 <= warmedUpVariantCount)
			{
				noProgressFrames++;
				if (noProgressFrames >= 60)
				{
					Debug.LogWarning($"[InitShaderVariant] Shader variant warmup made no progress for {60} frames " + $"({warmedUpVariantCount2}/{_totalVariantCount}). Continuing startup.");
					break;
				}
			}
			else
			{
				noProgressFrames = 0;
			}
			await UniTask.NextFrame();
		}
	}
}
