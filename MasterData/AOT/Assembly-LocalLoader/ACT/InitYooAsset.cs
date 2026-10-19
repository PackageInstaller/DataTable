using System;
using System.Collections.Generic;
using ACT.Error;
using Newtonsoft.Json.Linq;
using UnityEngine;
using YooAsset;
using bamboosdk;

namespace ACT;

internal class InitYooAsset : GameLoadingFlowBase
{
	private enum PackageInitStep
	{
		PackageInit = 1,
		PlayModeInit,
		RequestPackageVersion,
		UpdatePackageManifest,
		Complete
	}

	private Dictionary<PackageInitStep, Action> _stepActions;

	private Dictionary<AssetType, PackageInfo> _packageInfos;

	private List<AsyncOperationBase> _packageOperations;

	private PackageInitStep _currentStep;

	private YooAssetInitData _initData;

	private DateTime _verStart;

	private LoadInstructionWithTime _checkUpdateInstruction;

	private float _instructionProgressRangeStartTime;

	private float _displayCheckUpdatePercent;

	private float _lastDisplayCheckUpdateTime;

	private bool _isCheckUpdateDisplayCompleting;

	private float _checkUpdateDisplayCompleteStartPercent;

	private float _checkUpdateDisplayCompleteStartTime;

	private float _initStartTime;

	private float _stageStartTime;

	private const long CheckUpdateInstructionTotal = 1000L;

	private const long PlayModeInitProgressStart = 0L;

	private const long PlayModeInitProgressEnd = 500L;

	private const long RequestPackageVersionProgressStart = 500L;

	private const long RequestPackageVersionProgressEnd = 750L;

	private const long UpdatePackageManifestProgressStart = 750L;

	private const long UpdatePackageManifestProgressEnd = 1000L;

	private const float CheckUpdateFallbackSeconds = 10f;

	private const float CheckUpdateDisplayFakeMaxPercent = 0.98f;

	private const float CheckUpdateDisplayFakeSeconds = 30f;

	private const float CheckUpdateDisplayCompleteSeconds = 1.5f;

	internal override int TotalRetryCount => 0;

	internal override EGameLoadingStage Stage => EGameLoadingStage.YooAsset;

	internal InitYooAsset(YooAssetInitData initData)
	{
		_initData = initData;
	}

	internal override void Init(GameLoadingData data)
	{
		_packageInfos = _initData.PackageInfos;
		_initStartTime = Time.realtimeSinceStartup;
		Log($"[InitYooAsset] Begin: playMode={_initData.YooAssetParam?.PlayMode}, packageCount={_packageInfos?.Count ?? 0}");
		_stepActions = new Dictionary<PackageInitStep, Action>
		{
			{
				PackageInitStep.PackageInit,
				PackageInit
			},
			{
				PackageInitStep.PlayModeInit,
				PlayModeInit
			},
			{
				PackageInitStep.RequestPackageVersion,
				RequestPackageVersion
			},
			{
				PackageInitStep.UpdatePackageManifest,
				UpdatePackageManifest
			},
			{
				PackageInitStep.Complete,
				Complete
			}
		};
		RemoteServices.UseIntegrityCdn = false;
		_checkUpdateInstruction = new LoadInstructionWithTime(4f, AOTStringDefine.CheckIntegrity);
		_checkUpdateInstruction.Start(1000L);
		_checkUpdateInstruction.onUpdate += OnInstructionUpdate;
		ResetCheckUpdateDisplayProgress();
		_currentStep = PackageInitStep.PackageInit;
		_loadState = EGameLoadingState.Loading;
		LogStageStart(_currentStep);
	}

	internal override void Retry()
	{
		_loadState = EGameLoadingState.Loading;
		_packageOperations?.Clear();
		_currentStep = PackageInitStep.PackageInit;
		LogStageStart(_currentStep);
	}

	internal override void Update()
	{
		if (_stepActions.TryGetValue(_currentStep, out var value) && _loadState == EGameLoadingState.Loading)
		{
			value?.Invoke();
		}
		else if (_loadState == EGameLoadingState.Loading)
		{
			Error("Unknown step");
			LuminErrorAOT.ReportGameLoadingError("C01-0405", "01", 0, $"未知步骤: {_currentStep}");
		}
		if (_checkUpdateInstruction != null)
		{
			_checkUpdateInstruction.AddTime(Time.deltaTime);
		}
	}

	internal override void OnException()
	{
		if (_checkUpdateInstruction != null)
		{
			_checkUpdateInstruction.SetCurStateComplete();
		}
	}

	private void OnInstructionUpdate()
	{
		_initData.DownloadData?.CheckState?.Invoke(_checkUpdateInstruction.name, GetDisplayCheckUpdatePercent());
	}

	private void PackageInit()
	{
		try
		{
			YooAssets.Initialize();
			foreach (KeyValuePair<AssetType, PackageInfo> packageInfo in _packageInfos)
			{
				ResourcePackage resourcePackage = YooAssets.TryGetPackage(packageInfo.Value.PackageName);
				bool flag = resourcePackage == null;
				if (resourcePackage == null)
				{
					resourcePackage = YooAssets.CreatePackage(packageInfo.Value.PackageName);
					packageInfo.Value.Package = resourcePackage;
				}
				Log($"[InitYooAsset] PackageInit package={packageInfo.Value.PackageName}, created={flag}");
			}
			TurnToNextStep(PackageInitStep.PlayModeInit);
		}
		catch (Exception exception)
		{
			Exception(exception);
			throw;
		}
	}

	private void PlayModeInit()
	{
		try
		{
			if (TickToNextStepByList(_packageOperations, out var isSuccess))
			{
				UpdateInstructionProgressByOperations(0L, 500L, isSuccess);
				if (isSuccess)
				{
					SetInstructionProgress(500L);
					TurnToNextStep(PackageInitStep.RequestPackageVersion);
				}
				return;
			}
			if (_packageOperations == null)
			{
				_packageOperations = new List<AsyncOperationBase>();
			}
			_checkUpdateInstruction.Reset();
			BeginInstructionProgressRange(0L);
			foreach (KeyValuePair<AssetType, PackageInfo> packageInfo in _packageInfos)
			{
				ResourcePackage package = packageInfo.Value.Package;
				InitializeParameters parameters = YooAssetPackageInitUtility.CreateInitializeParameters(packageInfo.Key, package.PackageName, _initData.YooAssetParam.PlayMode);
				_packageOperations.Add(package.InitializeAsync(parameters));
				Log($"[InitYooAsset] PlayModeInit scheduled package={packageInfo.Value.PackageName}, mode={_initData.YooAssetParam.PlayMode}");
			}
			Log($"[InitYooAsset] PlayModeInit waiting: operationCount={_packageOperations.Count}");
		}
		catch (Exception exception)
		{
			Exception(exception);
		}
	}

	private void RequestPackageVersion()
	{
		try
		{
			if (TickToNextStepByList(_packageOperations, out var isSuccess))
			{
				UpdateInstructionProgressByOperations(500L, 750L, isSuccess);
				if (isSuccess)
				{
					SetInstructionProgress(750L);
					TurnToNextStep(PackageInitStep.UpdatePackageManifest);
				}
				return;
			}
			BeginInstructionProgressRange(500L);
			BamBooSdk.getInstance().taEvent("file_verification_start", new JObject().ToString());
			_verStart = DateTime.Now;
			if (_packageOperations == null)
			{
				_packageOperations = new List<AsyncOperationBase>();
			}
			foreach (KeyValuePair<AssetType, PackageInfo> packageInfo in _packageInfos)
			{
				RequestPackageVersionOperation requestPackageVersionOperation = packageInfo.Value.Package.RequestPackageVersionAsync();
				_packageOperations.Add(requestPackageVersionOperation);
				packageInfo.Value.RequestPackageVersionOperation = requestPackageVersionOperation;
				Log("[InitYooAsset] RequestPackageVersion scheduled package=" + packageInfo.Value.PackageName);
			}
			Log($"[InitYooAsset] RequestPackageVersion waiting: operationCount={_packageOperations.Count}");
		}
		catch (Exception exception)
		{
			Exception(exception);
		}
	}

	private void UpdatePackageManifest()
	{
		try
		{
			if (TickToNextStepByList(_packageOperations, out var isSuccess))
			{
				UpdateInstructionProgressByOperations(750L, 1000L, isSuccess);
				if (isSuccess)
				{
					SetInstructionProgress(1000L);
					StartCheckUpdateDisplayComplete();
					if (IsCheckUpdateDisplayComplete())
					{
						_checkUpdateInstruction.SetCurStateComplete();
						TurnToNextStep(PackageInitStep.Complete);
						_checkUpdateInstruction = null;
					}
				}
				return;
			}
			BeginInstructionProgressRange(750L);
			if (_packageOperations == null)
			{
				_packageOperations = new List<AsyncOperationBase>();
			}
			foreach (KeyValuePair<AssetType, PackageInfo> packageInfo in _packageInfos)
			{
				ResourcePackage package = packageInfo.Value.Package;
				string packageVersion = packageInfo.Value.RequestPackageVersionOperation.PackageVersion;
				UpdatePackageManifestOperation item = package.UpdatePackageManifestAsync(packageVersion);
				_packageOperations.Add(item);
				Log("[InitYooAsset] UpdatePackageManifest scheduled package=" + packageInfo.Value.PackageName + ", version=" + packageVersion);
			}
			Log($"[InitYooAsset] UpdatePackageManifest waiting: operationCount={_packageOperations.Count}");
		}
		catch (Exception exception)
		{
			Exception(exception);
		}
	}

	private void Complete()
	{
		JObject jObject = new JObject
		{
			["result"] = 1,
			["event_duration"] = (DateTime.Now - _verStart).TotalSeconds
		};
		BamBooSdk.getInstance().taEvent("file_verification_end", jObject.ToString());
		ResourcePackage resourcePackage = YooAssets.TryGetPackage("Assets");
		YooAssets.SetDefaultPackage(resourcePackage);
		Log($"[InitYooAsset] Complete: totalElapsed={Time.realtimeSinceStartup - _initStartTime:f3}s, defaultPackage={resourcePackage?.PackageName}");
		_loadState = EGameLoadingState.Succeed;
	}

	private void TurnToNextStep(PackageInitStep nextStep)
	{
		LogStageComplete(_currentStep, nextStep);
		_currentStep = nextStep;
		_packageOperations?.Clear();
		LogStageStart(_currentStep);
	}

	private void LogStageStart(PackageInitStep step)
	{
		_stageStartTime = Time.realtimeSinceStartup;
		Log($"[InitYooAsset] StageStart: {step}");
	}

	private void LogStageComplete(PackageInitStep step, PackageInitStep nextStep)
	{
		int num = _packageOperations?.Count ?? 0;
		Log($"[InitYooAsset] StageComplete: {step}, elapsed={Time.realtimeSinceStartup - _stageStartTime:f3}s, operationCount={num}, next={nextStep}");
		if (_packageOperations == null)
		{
			return;
		}
		for (int i = 0; i < _packageOperations.Count; i++)
		{
			AsyncOperationBase asyncOperationBase = _packageOperations[i];
			if (asyncOperationBase == null)
			{
				Log($"[InitYooAsset] StageOperation: stage={step}, index={i}, operation=null");
				continue;
			}
			Log($"[InitYooAsset] StageOperation: stage={step}, index={i}, status={asyncOperationBase.Status}, progress={asyncOperationBase.Progress:F3}, error={asyncOperationBase.Error}");
		}
	}

	private bool TickToNextStepByList(List<AsyncOperationBase> operations, out bool isSuccess)
	{
		isSuccess = true;
		if (operations == null || operations.Count == 0)
		{
			return false;
		}
		foreach (AsyncOperationBase operation in operations)
		{
			if (operation.IsDone)
			{
				if (operation.Status == EOperationStatus.Failed)
				{
					Error($"Operation['{operation}'] : ErrorMessage {operation.Error}");
					LuminErrorAOT.ReportGameLoadingError(_currentStep switch
					{
						PackageInitStep.PlayModeInit => "C01-0402", 
						PackageInitStep.RequestPackageVersion => "C01-0403", 
						PackageInitStep.UpdatePackageManifest => "C01-0404", 
						_ => "C01-0401", 
					}, "01", 0);
					isSuccess = false;
				}
			}
			else
			{
				isSuccess = false;
			}
		}
		return true;
	}

	private void UpdateInstructionProgressByOperations(long start, long end, bool allowRangeComplete)
	{
		if (_checkUpdateInstruction == null)
		{
			return;
		}
		if (_packageOperations == null || _packageOperations.Count == 0)
		{
			SetInstructionProgress(start);
			return;
		}
		float num = 0f;
		for (int i = 0; i < _packageOperations.Count; i++)
		{
			AsyncOperationBase asyncOperationBase = _packageOperations[i];
			if (asyncOperationBase != null)
			{
				num += (asyncOperationBase.IsDone ? 1f : Mathf.Clamp01(asyncOperationBase.Progress));
			}
		}
		num /= (float)_packageOperations.Count;
		num = Mathf.Max(num, GetFallbackProgress(start, end));
		long num2 = start + (long)((float)(end - start) * num);
		if (!allowRangeComplete && num2 >= end)
		{
			num2 = end - 1;
		}
		SetInstructionProgress(num2);
	}

	private void BeginInstructionProgressRange(long start)
	{
		_instructionProgressRangeStartTime = Time.unscaledTime;
		SetInstructionProgress(start);
	}

	private float GetFallbackProgress(long start, long end)
	{
		long num = end - start;
		if (num <= 0)
		{
			return 1f;
		}
		float num2 = 10f * ((float)num / 1000f);
		if (num2 <= 0f)
		{
			return 1f;
		}
		return Mathf.Clamp01((Time.unscaledTime - _instructionProgressRangeStartTime) / num2);
	}

	private void ResetCheckUpdateDisplayProgress()
	{
		_displayCheckUpdatePercent = 0f;
		_lastDisplayCheckUpdateTime = Time.unscaledTime;
		_isCheckUpdateDisplayCompleting = false;
		_checkUpdateDisplayCompleteStartPercent = 0f;
		_checkUpdateDisplayCompleteStartTime = 0f;
	}

	private float GetDisplayCheckUpdatePercent()
	{
		if (_checkUpdateInstruction == null)
		{
			return _displayCheckUpdatePercent;
		}
		float unscaledTime = Time.unscaledTime;
		if (_isCheckUpdateDisplayCompleting)
		{
			float t = Mathf.Clamp01((unscaledTime - _checkUpdateDisplayCompleteStartTime) / 1.5f);
			_displayCheckUpdatePercent = Mathf.Lerp(_checkUpdateDisplayCompleteStartPercent, 1f, t);
			_lastDisplayCheckUpdateTime = unscaledTime;
			return _displayCheckUpdatePercent;
		}
		float num = Mathf.Clamp01(_checkUpdateInstruction.percent);
		if (num >= 1f)
		{
			_displayCheckUpdatePercent = 1f;
			_lastDisplayCheckUpdateTime = unscaledTime;
			return _displayCheckUpdatePercent;
		}
		float num2 = Mathf.Max(0f, unscaledTime - _lastDisplayCheckUpdateTime);
		_lastDisplayCheckUpdateTime = unscaledTime;
		if (_displayCheckUpdatePercent < num)
		{
			_displayCheckUpdatePercent = num;
		}
		if (_displayCheckUpdatePercent < 0.98f)
		{
			float num3 = 0.03266667f;
			_displayCheckUpdatePercent += num3 * num2;
			if (_displayCheckUpdatePercent > 0.98f)
			{
				_displayCheckUpdatePercent = 0.98f;
			}
		}
		if (_displayCheckUpdatePercent < num)
		{
			_displayCheckUpdatePercent = num;
		}
		return Mathf.Clamp01(_displayCheckUpdatePercent);
	}

	private void StartCheckUpdateDisplayComplete()
	{
		if (!_isCheckUpdateDisplayCompleting)
		{
			float num = ((_checkUpdateInstruction != null) ? Mathf.Clamp01(_checkUpdateInstruction.percent) : _displayCheckUpdatePercent);
			if (_displayCheckUpdatePercent < num)
			{
				_displayCheckUpdatePercent = num;
			}
			_checkUpdateDisplayCompleteStartPercent = Mathf.Clamp01(_displayCheckUpdatePercent);
			_checkUpdateDisplayCompleteStartTime = Time.unscaledTime;
			_lastDisplayCheckUpdateTime = _checkUpdateDisplayCompleteStartTime;
			_isCheckUpdateDisplayCompleting = true;
		}
	}

	private bool IsCheckUpdateDisplayComplete()
	{
		if (_isCheckUpdateDisplayCompleting)
		{
			return _displayCheckUpdatePercent >= 1f;
		}
		return false;
	}

	private void SetInstructionProgress(long target)
	{
		if (_checkUpdateInstruction != null)
		{
			if (target < 0)
			{
				target = 0L;
			}
			else if (target > 1000)
			{
				target = 1000L;
			}
			long num = target - _checkUpdateInstruction.Current;
			if (num > 0)
			{
				_checkUpdateInstruction.AddBatch(num);
			}
		}
	}

	internal Dictionary<AssetType, PackageInfo> GetPackageInfos()
	{
		return _packageInfos;
	}
}
