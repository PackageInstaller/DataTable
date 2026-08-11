#define ENABLE_INFO_AND_ABOVE_LOG
#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Resource;
using GameFramework.Runtime;
using UnityEngine.SceneManagement;

namespace Ase;

public class LoadingViewModel : OptionBase
{
	protected LoadingProgressBar progressBar = new LoadingProgressBar();

	protected bool autoLoad = true;

	protected WorldData worldData;

	protected bool loadingSuccess;

	protected bool loadingFinish;

	protected new InteractionRequest dismissRequest;

	private float alpha = 1f;

	private bool blocksRaycasts = true;

	public LoadingProgressBar ProgressBar => progressBar;

	public bool LoadingSuccess => loadingSuccess;

	public bool IsLoadingFinish => loadingFinish;

	public bool AutoLoad => autoLoad;

	public new IInteractionRequest DismissRequest => dismissRequest;

	public float Alpha
	{
		get
		{
			return alpha;
		}
		set
		{
			Set<float>(ref alpha, value, "Alpha");
		}
	}

	public bool BlocksRaycasts
	{
		get
		{
			return blocksRaycasts;
		}
		set
		{
			Set<bool>(ref blocksRaycasts, value, "BlocksRaycasts");
		}
	}

	public LoadingViewModel()
	{
		dismissRequest = new InteractionRequest(this);
		loadingSuccess = false;
		loadingFinish = false;
	}

	public LoadingViewModel(WorldData worldData, bool autoLoad)
		: this()
	{
		this.autoLoad = autoLoad;
		this.worldData = worldData;
	}

	public virtual void LoadingFinish(bool success = true)
	{
		loadingFinish = true;
		loadingSuccess = success;
	}

	public void DoLoadingFinish()
	{
		loadingFinish = true;
		loadingSuccess = true;
	}

	public async Task CloseLoading()
	{
		GameEntry.Resource.UnloadUnusedAssets();
		await OnCloseLoading();
		dismissRequest.Raise();
		await OnCloseLoadWindow();
		await UniTask.WaitForSeconds(0.1f);
		OnLoadingClosed();
	}

	protected virtual void OnLoadingClosed()
	{
	}

	protected virtual async Task OnCloseLoading()
	{
	}

	protected virtual async Task OnCloseLoadWindow()
	{
	}

	public async void StartLoading()
	{
		_ = 1;
		try
		{
			await Singleton<AudioSystem>.Instance.LoadingClear();
			await LoadBanks();
			Load();
		}
		catch (Exception ex)
		{
			Log.Error("加载失败: {0}", ex.Message);
			LoadingFinish(success: false);
		}
	}

	public virtual async void Load()
	{
	}

	protected virtual async Task<WorldBase> CreateWorld()
	{
		return null;
	}

	protected virtual async Task<WorldBase> CreateLockstepWorld()
	{
		return null;
	}

	protected virtual async Task<bool> CreateBattleWorld()
	{
		try
		{
			uint num = 0u;
			if (worldData != null)
			{
				num = await Singleton<GameSystem>.Instance.CreateWorldChannel(WorldType.Battle, SceneManager.GetSceneByName(worldData.WorldName), worldData);
			}
			if (num != 0)
			{
				LoadingFinish();
			}
			else
			{
				Game.RemoveSingleton<GameSystem>();
				GameEntry.Scene.UnloadScene(worldData.SceneLoadPath, new UnloadSceneCallbacks(async delegate
				{
					await UniTask.Delay(TimeSpan.FromSeconds(1.0));
					LoadingFinish(success: false);
				}));
			}
		}
		catch (Exception ex)
		{
			Log.Error("加载失败 " + ex.Message + " / " + ex.StackTrace);
			LoadingFinish(success: false);
		}
		return true;
	}

	protected virtual UniTask LoadBanks()
	{
		return UniTask.CompletedTask;
	}

	public void SetRandomLoadingTap(DRLoadingTips drLoading)
	{
		if (drLoading != null)
		{
			progressBar.Tip = drLoading.Tips;
			progressBar.Title = drLoading.TipsTitle;
		}
		else
		{
			progressBar.Tip = "暂时没有更多了";
			progressBar.Title = "小提示";
		}
	}
}
