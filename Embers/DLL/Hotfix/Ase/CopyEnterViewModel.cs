#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;

namespace Ase;

public class CopyEnterViewModel : OptionBase
{
	public override async void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is BattleReadyViewModel battleReadyViewModel)
		{
			if (battleReadyViewModel.ReadyType == BattleReadyType.Ready)
			{
				SetEnterBattle();
				battleReadyViewModel.SetStartBattleResult(await EnterBattleWorld(battleReadyViewModel));
			}
		}
		else if (obj is CopyST4EnterItemViewModel enterViewModel)
		{
			if (CopyEntryLimitHelper.TryBlockEntry(enterViewModel.Data, isMulti: false))
			{
				enterViewModel.SetEnterResult(result: false);
			}
			else
			{
				enterViewModel.SetEnterResult(await EnterBattleWorld(enterViewModel));
			}
		}
	}

	protected virtual void SetEnterBattle()
	{
	}

	private async Task<bool> EnterBattleWorld(BattleReadyViewModel readyVm)
	{
		int dropRate = readyVm.ReadyData.DropRate;
		int serviceCopyType = CopyData.GetServiceCopyType(dropRate, readyVm.ReadyData.Target == BattleReadyTarget.CopyFirstPass);
		CopyData copyById = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyById(readyVm.ReadyData.TargetId);
		copyById.SetDropRate(dropRate);
		return await CreateLoadingNormal(await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().EnterBattleWorld(copyById, null, readyVm.TeamData(), serviceCopyType, readyVm.ReadyData.CopyDropType, null), delegate
		{
			readyVm.Close();
		});
	}

	private async Task<bool> EnterBattleWorld(CopyST4EnterItemViewModel enterViewModel)
	{
		CopyData copyById = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyById(enterViewModel.Data.Id);
		List<TeamMember> teamCopyData = enterViewModel.GetTeamCopyData();
		return await CreateLoadingType4(await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().EnterBattleWorld(copyById, null, teamCopyData, 0, 0, null));
	}

	protected async Task<bool> EnterBattleWorld(CopyST5EnterItemViewModel enterViewModel)
	{
		CopyData copyById = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyById(enterViewModel.CopyId);
		if (CopyEntryLimitHelper.TryBlockEntry(copyById, isMulti: false))
		{
			return false;
		}
		copyById.AddType5Buff(enterViewModel.EnvironId);
		List<TeamMember> teamCopyData = enterViewModel.GetTeamCopyData();
		return await CreateLoadingNormal(await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().EnterBattleWorld(copyById, null, teamCopyData, 1, 0, null), null);
	}

	private async Task<bool> CreateLoadingType4(CopyEnterInfoData copyEnterInfoData)
	{
		if (copyEnterInfoData == null)
		{
			return false;
		}
		try
		{
			CopyData copyData = copyEnterInfoData.CopyData;
			List<TeamMember> teamMembers = copyEnterInfoData.TeamMembers;
			List<PeripheryHeroData> list = new List<PeripheryHeroData>();
			for (int i = 0; i < teamMembers.Count; i++)
			{
				list.Add(teamMembers[i].GetPeripheryHeroData());
			}
			List<AchievementMedal> battleAchievementMedals = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetBattleAchievementMedals(copyData.CopyType == 99000 || copyData.CopyType == 99100);
			WorldData worldData = BattleWorldData.CreateBattleWorldData(0u, copyData.SceneName, copyData.Id, copyData.GetBossId(0), copyData.MapData, copyData.NavMeshId, list, teamMembers, null, battleAchievementMedals);
			worldData.IsBattleSend = copyEnterInfoData.IsBattleSend;
			worldData.RoomId = copyEnterInfoData.RoomId;
			worldData.RandomSeed = copyEnterInfoData.SeedID;
			LoadingSingleViewModel loadingSingleViewModel = new LoadingSingleViewModel("Outer/Outer", autoUnload: true, worldData);
			DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Battle);
			loadingSingleViewModel.SetRandomLoadingTap(randomLoadingTap);
			await GameEntry.UI.OpenWindow<LoadingWindow>("Loading/LoadingWindow", "LOADING", loadingSingleViewModel);
			await UniTask.WaitUntil(() => loadingSingleViewModel.IsLoadingFinish);
			if (loadingSingleViewModel.LoadingSuccess)
			{
				UIWindowHelper.WindowRelease();
				await loadingSingleViewModel.CloseLoading();
				Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSingleViewModel.LoadingSuccess);
				Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetCheckCode();
				Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().AddEnterCopyTDA(copyEnterInfoData);
				Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetIsSingleBattle(value: true);
				return true;
			}
		}
		catch (Exception ex)
		{
			Log.Error("单人进入战斗发生异常 " + ex.Message + " / " + ex.StackTrace);
		}
		return false;
	}

	private async Task<bool> CreateLoadingNormal(CopyEnterInfoData copyEnterInfoData, Action loadingEndAction)
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
			WorldData worldData = BattleWorldData.CreateBattleWorldData(0u, copyData.SceneName, copyData.Id, copyData.GetBossId(0), copyData.MapData, copyData.NavMeshId, list, teamMembers, null, battleAchievementMedals);
			worldData.RoomId = copyEnterInfoData.RoomId;
			worldData.RandomSeed = copyEnterInfoData.SeedID;
			worldData.IsBattleSend = copyEnterInfoData.IsBattleSend;
			LoadingSingleViewModel loadingSingleViewModel = new LoadingSingleViewModel("Outer/Outer", autoUnload: true, worldData);
			DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Battle);
			loadingSingleViewModel.SetRandomLoadingTap(randomLoadingTap);
			await GameEntry.UI.OpenWindow<LoadingWindow>("Loading/LoadingWindow", "LOADING", loadingSingleViewModel);
			await UniTask.WaitUntil(() => loadingSingleViewModel.IsLoadingFinish);
			if (loadingSingleViewModel.LoadingSuccess)
			{
				loadingEndAction?.Invoke();
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
			Log.Error("单人Loading进入战斗发生异常 " + ex.Message + " / " + ex.StackTrace);
		}
		return false;
	}
}
