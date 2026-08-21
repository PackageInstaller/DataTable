#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase;

public class LoadingBackToMainViewModel : LoadingSceneViewModel
{
	private readonly string previousSceneName;

	private readonly bool autoUnloadPreviousScene;

	private string newWindowName;

	private uint worldId;

	private bool hasTask;

	private Func<bool, UniTask> loadTask;

	public LoadingBackToMainViewModel(string preSceneName, bool autoUnload, string newWindowName = null)
	{
		previousSceneName = preSceneName;
		autoUnloadPreviousScene = autoUnload;
		this.newWindowName = newWindowName;
	}

	public LoadingBackToMainViewModel(string preSceneName, bool autoUnload, Func<bool, UniTask> loadTask)
	{
		previousSceneName = preSceneName;
		autoUnloadPreviousScene = autoUnload;
		this.loadTask = loadTask;
		hasTask = true;
	}

	public void OnBattleOver()
	{
		Application.targetFrameRate = (GameSettingExtension.GetIntRawValue("帧率") + 1) * 30;
	}

	public override async void Load()
	{
		base.ProgressBar.Enable = true;
		string sceneName = "Outer/Outer";
		OnBattleOver();
		if (!(await LoadScene(sceneName)))
		{
			LoadingFinish(success: false);
			return;
		}
		if (hasTask)
		{
			await loadTask(arg: true);
		}
		Singleton<ServiceSystem>.Instance.GetService<IHeroService>().ClearHeroAdditionalDatas();
		if (autoUnloadPreviousScene && !string.IsNullOrEmpty(previousSceneName) && !(await UnloadScene(previousSceneName)))
		{
			Log.Error("离开战斗. 卸载前置场景【" + previousSceneName + "】失败.");
		}
		progressBar.ForceFinish();
		LoadingFinish();
	}

	protected override async UniTask LoadBanks()
	{
		await AudioHelper.LoadBanksByType(1);
	}

	protected override async Task OnCloseLoading()
	{
		UIWindowHelper.WindowRelease();
		List<object> cachedVm = UIWindowHelper.GetCachedVm();
		if (cachedVm == null || cachedVm.Count == 0)
		{
			(await GameEntry.UI.OpenWindow<MainWindow>("Main/MainWindow", new MainViewModel())).Entrance = "BackFromBattle";
			return;
		}
		if (cachedVm != null)
		{
			foreach (object item in cachedVm)
			{
				if (item is MapViewModel mapViewModel)
				{
					TaskDataViewModel currentMainTask = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetCurrentMainTask();
					if (currentMainTask != null && mapViewModel.TaskData != null && currentMainTask.LevelMapId != mapViewModel.TaskData.LevelMapId)
					{
						mapViewModel.RefreshData(currentMainTask.LevelMapId, forceReload: true);
						continue;
					}
					mapViewModel.RefreshBonfireData();
					mapViewModel.RefreshCaveActiveData();
				}
			}
		}
		if (GetCacheVm<CopySecondType5ViewModel>() != null)
		{
			await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetRaceCopyTotalScore();
		}
		if (newWindowName == null)
		{
			await UIWindowHelper.LoadCacheView();
			Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().RemoveGetBPListener();
			MainViewModel cacheVm = GetCacheVm<MainViewModel>();
			if (cacheVm != null)
			{
				cacheVm.AddBpGetListener();
				Singleton<ServiceSystem>.Instance.GetService<ICopyService>().UpdateRealisticTime();
			}
			Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SaveCanAcceptInvite(value: true);
			return;
		}
		if (newWindowName.Equals("Copy"))
		{
			GetCacheVm<CopyFirstViewModel>()?.JumpTo();
			GetCacheVm<CopySecondType1ViewModel>()?.JumpTo();
			CopySecondType2ViewModel cacheVm2 = GetCacheVm<CopySecondType2ViewModel>();
			if (cacheVm2 != null)
			{
				cacheVm2.JumpTo(selectNewOpen: true);
				cacheVm2.Return2PlayEffect(enable: true);
			}
			CopySecondType4ViewModel type4 = GetCacheVm<CopySecondType4ViewModel>();
			if (type4 != null)
			{
				await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetFloorCopyStarInfo();
				await type4.GetZoneStar(force: true);
			}
			await UIWindowHelper.LoadCacheView();
			CopyData copyData = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetCopyData();
			if (copyData != null && copyData.CopyMainId == 3)
			{
				GetCacheVm<CopySecondType3ViewModel>()?.ItemOnClick("ReturnSingle");
			}
		}
		else if (newWindowName.Equals("ReturnNextCopy"))
		{
			GetCacheVm<CopyFirstViewModel>()?.JumpTo();
			List<CopyType4TeamConfig> type4ReturnCopy = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetType4ReturnCopy();
			CopySecondType4ViewModel type4 = GetCacheVm<CopySecondType4ViewModel>();
			if (type4ReturnCopy != null && type4ReturnCopy.Count > 0)
			{
				List<CopyData> copyDatas = type4?.GetCopyList(type4ReturnCopy[0].CopyId);
				CopyST4EnterViewModel cacheVm3 = GetCacheVm<CopyST4EnterViewModel>();
				if (cacheVm3 != null)
				{
					await cacheVm3.SetCopyData(copyDatas, type4ReturnCopy);
				}
			}
			if (type4 != null)
			{
				await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetFloorCopyStarInfo();
				await type4.GetZoneStar(force: true);
			}
			await UIWindowHelper.LoadCacheView();
		}
		else if (newWindowName.Equals("SingleTeam") || newWindowName.Equals("MultiTeam"))
		{
			GetCacheVm<CopyFirstViewModel>()?.JumpTo();
			CopySecondType1ViewModel type5 = GetCacheVm<CopySecondType1ViewModel>();
			type5?.JumpTo();
			CopySecondType2ViewModel type6 = GetCacheVm<CopySecondType2ViewModel>();
			if (type6 != null)
			{
				type6.JumpTo(selectNewOpen: false);
				type6.Return2PlayEffect(enable: false);
			}
			await UIWindowHelper.LoadCacheView();
			string text = (newWindowName.Equals("SingleTeam") ? "ReturnSingle" : "ReturnMulti");
			if (text.Equals("ReturnSingle"))
			{
				CopyData copyData2 = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetCopyData();
				switch (copyData2.CopyMainId)
				{
				case 1:
					type5?.ItemOnClick(text);
					break;
				case 2:
					type6?.ItemOnClick(text);
					break;
				case 3:
					GetCacheVm<CopySecondType3ViewModel>()?.ItemOnClick(text);
					break;
				case 7:
					if (Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm()?.GetActivityViewModel(copyData2.ActivityTypeId) != null && UIWindowHelper.GetBottomVM() is MainViewModel mainViewModel2)
					{
						mainViewModel2.EnablePopBanner(isEnable: false);
						await mainViewModel2.OpenOpActivityWindow(copyData2.ActivityTypeId, copyData2);
					}
					break;
				case 8:
					if (UIWindowHelper.GetBottomVM() is MainViewModel mainViewModel)
					{
						mainViewModel.EnablePopBanner(isEnable: false);
						await mainViewModel.OpenOpActivityChallengeWindow(copyData2.ActivityTypeId, copyData2, openBattleReady: true, fromBattleReturn: true);
					}
					break;
				default:
					GetCacheVm<CopyTrainViewModel>()?.ItemOnClick(text);
					break;
				case 5:
					break;
				}
			}
			else
			{
				object bottomVM = UIWindowHelper.GetBottomVM();
				await OpenNewWindow(newWindowName, bottomVM);
			}
		}
		else
		{
			UIWindowHelper.WindowReleaseKeepBottom();
			await UIWindowHelper.LoadCacheView();
			object bottomVM2 = UIWindowHelper.GetBottomVM();
			await OpenNewWindow(newWindowName, bottomVM2);
		}
		Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().RemoveGetBPListener();
		MainViewModel cacheVm4 = GetCacheVm<MainViewModel>();
		if (cacheVm4 != null)
		{
			cacheVm4.AddBpGetListener();
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().UpdateRealisticTime();
		}
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SaveCanAcceptInvite(value: true);
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().ClearCopyEnterInfo();
	}

	private async Task OpenNewWindow(string windowName, object vmObjType)
	{
		int selfHeroId = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetSelfHeroId();
		HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(selfHeroId);
		if (heroById.Empty)
		{
			heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(1104);
		}
		if (!(vmObjType is MainViewModel mainViewModel))
		{
			return;
		}
		CopyData copyData = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetCopyData();
		switch (windowName)
		{
		case "HeroCultivateWindow":
		{
			HeroCultivateViewModel userData3 = new HeroCultivateViewModel(mainViewModel, heroById);
			await GameEntry.UI.OpenWindow<HeroCultivateWindow>("Hero/HeroCultivateWindow", userData3);
			break;
		}
		case "WeaponUpgrade":
		{
			WeaponCultureViewModel userData4 = new WeaponCultureViewModel(mainViewModel, heroById.HeldWeapon);
			await GameEntry.UI.OpenWindow<WeaponCultureWindow>("Equipment/WeaponCultureWindow", userData4);
			break;
		}
		case "ArmourUpgrade":
		{
			ArmourChangeViewModel userData2 = new ArmourChangeViewModel(mainViewModel, heroById, ArmourEnum.Heart);
			await GameEntry.UI.OpenWindow<ArmourChangeWindow>("Equipment/ArmourChangeWindow", userData2);
			break;
		}
		case "HeroTalend":
		{
			HeroCultivateViewModel userData5 = new HeroCultivateViewModel(mainViewModel, heroById, 4);
			await GameEntry.UI.OpenWindow<HeroCultivateWindow>("Hero/HeroCultivateWindow", userData5);
			break;
		}
		case "GuildCopy":
			if (copyData.CopyMainId == Constant.ConstantConfig.GuildCopyType)
			{
				await mainViewModel.OpenGuild(5, copyData, openRoom: false);
			}
			break;
		case "MultiTeam":
			mainViewModel.EnablePopBanner(isEnable: false);
			if (copyData.CopyMainId == 8)
			{
				if (await mainViewModel.OpenOpActivityChallengeWindow(copyData.ActivityTypeId, copyData, openBattleReady: false, fromBattleReturn: true))
				{
					mainViewModel.BackToMultiRoom();
				}
			}
			else if (copyData.CopyMainId == 6)
			{
				if (await mainViewModel.OpenOpActivityEquipWindow(copyData.ActivityTypeId, copyData) != null)
				{
					mainViewModel.BackToMultiRoom();
				}
			}
			else if (copyData.CopyMainId == Constant.ConstantConfig.GuildCopyType)
			{
				await mainViewModel.OpenGuild(5, copyData, openRoom: true);
			}
			else
			{
				mainViewModel.BackToMultiRoom();
			}
			break;
		case "OperatingActivityWindow":
			mainViewModel.EnablePopBanner(isEnable: false);
			if (copyData.CopyMainId == 8)
			{
				await mainViewModel.OpenOpActivityChallengeWindow(copyData.ActivityTypeId, copyData, openBattleReady: false, fromBattleReturn: true);
			}
			else if (copyData.CopyMainId == 6)
			{
				await mainViewModel.OpenOpActivityEquipWindow(copyData.ActivityTypeId, copyData);
			}
			else if (copyData == null || copyData.CopyType != Constant.ConstantConfig.ClimbTowerCopyType)
			{
				await mainViewModel.OpenOpActivityWindow(copyData.ActivityTypeId, null);
			}
			else
			{
				await mainViewModel.OpenOpActivityWindow(copyData.ActivityTypeId, copyData);
			}
			break;
		case "CampaignMapWindow":
		{
			ICampaignService service = Singleton<ServiceSystem>.Instance.GetService<ICampaignService>();
			if (!(service?.GetCampaignOpenState() ?? false))
			{
				Toast.ShowInfo("尊敬的传火者大人，活动已结束，期待下次再见");
			}
			else if (await service.RequestCampaignMainInfo() != null)
			{
				CampaignMainViewModel campaignMainViewModel = new CampaignMainViewModel(mainViewModel);
				await GameEntry.UI.OpenWindow<CampaignMainWindow>("Campaign/CampaignMainWindow", campaignMainViewModel);
				if (await service.RequestCampaignDetailInfo() != null)
				{
					CampaignMapViewModel userData = new CampaignMapViewModel(campaignMainViewModel);
					await GameEntry.UI.OpenWindow<CampaignMapWindow>("Campaign/CampaignMapWindow", userData);
				}
			}
			break;
		}
		}
	}

	private T GetCacheVm<T>() where T : OptionBase
	{
		List<object> cachedVm = UIWindowHelper.GetCachedVm();
		if (cachedVm == null || cachedVm.Count == 0)
		{
			return null;
		}
		if (cachedVm != null)
		{
			foreach (object item in cachedVm)
			{
				if (item.GetType().Equals(typeof(T)))
				{
					return (T)item;
				}
			}
		}
		return null;
	}
}
