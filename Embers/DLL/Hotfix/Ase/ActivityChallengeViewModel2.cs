#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;

namespace Ase;

public class ActivityChallengeViewModel2 : ActivityChallengeViewModel
{
	private const string WindowPath = "OperatingActivity/Challenge/ActivityChallengeWindow2";

	private bool pendingOpenBattleReady;

	protected override string ChallengeWindowPath => "OperatingActivity/Challenge/ActivityChallengeWindow2";

	protected override void SetCopyItemBossName(CopyItemViewModel copyItemVm)
	{
		if (copyItemVm != null && copyItemVm.Data != null)
		{
			copyItemVm.SetBossName(copyItemVm.Data.Name);
		}
	}

	public override async void ItemOnClick(object obj)
	{
		if (obj is BattleReadyViewModel { ReadyType: BattleReadyType.Ready } battleReadyViewModel)
		{
			battleReadyViewModel.SetStartBattleResult(await EnterBattleWorld(battleReadyViewModel));
		}
		else
		{
			base.ItemOnClick(obj);
		}
	}

	public void OpenSingleBattleReady()
	{
		pendingOpenBattleReady = true;
	}

	public bool TryOpenSingleBattleReady()
	{
		if (!pendingOpenBattleReady)
		{
			return false;
		}
		if (curSelectViewModel == null)
		{
			return false;
		}
		pendingOpenBattleReady = false;
		OnMulti().Forget();
		return true;
	}

	public void CancelPendingOpenSingleBattleReady()
	{
		pendingOpenBattleReady = false;
	}

	protected override async UniTask OnMulti()
	{
		try
		{
			optCommand.Enabled = false;
			if (curSelectViewModel.Data.IsLock)
			{
				Toast.ShowInfo($"传火等级达到Lv{curSelectViewModel.Data.AdvLevel}开放！");
				optCommand.Enabled = true;
				return;
			}
			if (_leftActivityTime != -1 && _leftActivityTime <= 0)
			{
				Toast.ShowInfo("活动已结束！");
				optCommand.Enabled = true;
				return;
			}
			if (CopyEntryLimitHelper.TryBlockEntry(curSelectViewModel.Data, isMulti: false))
			{
				optCommand.Enabled = true;
				return;
			}
			BattleReadyTarget target = ((!curSelectViewModel.Data.IsNeedFirst || curSelectViewModel.Data.IsAccessed) ? BattleReadyTarget.Copy : BattleReadyTarget.CopyFirstPass);
			BattleReadyViewModel userData = new BattleReadyViewModel(this, new BattleReadyData(target, curSelectViewModel.Data.Id));
			openWindowRequest.Raise(new OpenViewArg(typeof(BattleReadyWindow), userData), delegate
			{
				optCommand.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Toast.ShowInfo("打开组队界面失败，请重试！");
			Log.Error("打开组队界面失败! " + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
		await UniTask.CompletedTask;
	}

	private async Task<bool> EnterBattleWorld(BattleReadyViewModel readyVm)
	{
		_ = 1;
		try
		{
			CopyData copyById = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyById(readyVm.ReadyData.TargetId);
			if (copyById == null)
			{
				return false;
			}
			int dropRate = readyVm.ReadyData.DropRate;
			int serviceCopyType = CopyData.GetServiceCopyType(dropRate, readyVm.ReadyData.Target == BattleReadyTarget.CopyFirstPass);
			copyById.SetDropRate(dropRate);
			return await CreateActivityCopyLoading(await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().EnterBattleWorld(copyById, null, readyVm.TeamData(), serviceCopyType, readyVm.ReadyData.CopyDropType, null), readyVm);
		}
		catch (Exception ex)
		{
			Toast.ShowInfo("打开组队界面失败，请重试！");
			Log.Error("打开组队界面失败! " + ex.Message + " / " + ex.StackTrace);
		}
		return false;
	}

	private async Task<bool> CreateActivityCopyLoading(CopyEnterInfoData copyEnterInfoData, BattleReadyViewModel readyVm)
	{
		if (copyEnterInfoData == null)
		{
			return false;
		}
		try
		{
			List<TeamMember> teamMembers = copyEnterInfoData.TeamMembers;
			CopyData copyData = copyEnterInfoData.CopyData;
			List<PeripheryHeroData> list = new List<PeripheryHeroData>();
			foreach (TeamMember item in teamMembers)
			{
				if (copyData.HasFirstBuff())
				{
					item.HeroModel.AddOuterBuff(OuterBuffEnum.CopyFirstAccessBuff, copyData.CopyEnvironId);
				}
				list.Add(item.GetPeripheryHeroData());
			}
			List<AchievementMedal> battleAchievementMedals = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetBattleAchievementMedals(copyData.CopyType == 99000 || copyData.CopyType == 99100);
			WorldData worldData = ActivityBattleWorldData.Create(copyData.Id, 0u, list, null, copyEnterInfoData.SeedID, copyEnterInfoData.RoomId, 0L, 0, Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid, 0, "", 0, 0u, battleAchievementMedals, copyData.Id);
			worldData.TeamMemberList = teamMembers;
			worldData.IsBattleSend = copyEnterInfoData.IsBattleSend;
			LoadingActivitiyBattleViewModel loadingSingleViewModel = new LoadingActivitiyBattleViewModel("Outer/Outer", worldData, autoUnload: true);
			Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetSceneLoadPath(worldData.SceneLoadPath);
			DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Battle);
			loadingSingleViewModel.SetRandomLoadingTap(randomLoadingTap);
			await GameEntry.UI.OpenWindow<LoadingWindow>("Loading/LoadingWindow", "LOADING", loadingSingleViewModel);
			await UniTask.WaitUntil(() => loadingSingleViewModel.IsLoadingFinish);
			if (loadingSingleViewModel.LoadingSuccess)
			{
				readyVm.Close();
				UIWindowHelper.WindowRelease();
				await loadingSingleViewModel.CloseLoading();
				Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSingleViewModel.LoadingSuccess);
				Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().AddEnterCopyTDA(copyEnterInfoData);
				Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetIsSingleBattle(value: true);
				return true;
			}
		}
		catch (Exception ex)
		{
			Log.Error("ActivityChallengeViewModel2 loading failed " + ex.Message + " / " + ex.StackTrace);
		}
		return false;
	}
}
