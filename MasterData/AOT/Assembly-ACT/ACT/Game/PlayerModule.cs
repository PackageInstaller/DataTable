using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Error;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.Local;
using ACT.MissionSystem;
using ACT.Model;
using ACT.Net;
using ACT.UI;
using ACT.UI.AOT;
using ACT.UI.DataProxy;
using ACT.Utility;
using ACT.World.Asset;
using ACT.World.Bloodstain;
using Bamboo.ECS;
using Battle.LittleItemsModel;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Pb;
using Runtime.Model;
using Runtime.WaitSort;
using UnityEngine;
using UnityEngine.Pool;
using bamboosdk;

namespace ACT.Game;

public class PlayerModule : BaseModule
{
	private Dictionary<int, int> _oldStateMap = new Dictionary<int, int>();

	public PlayerModule()
	{
		Singleton<NetManager>.instance.AddListener(4500, OnMapCustomFlagNtf);
		Singleton<NetManager>.instance.AddListener(4401, OnAssistSkinNtf);
		Singleton<NetManager>.instance.AddListener(4400, OnAssistNtf);
		Singleton<NetManager>.instance.AddListener(3300, OnCharacterNtf);
		Singleton<NetManager>.instance.AddListener(3400, OnWeaponNtf);
		Singleton<NetManager>.instance.AddListener(3200, OnItemNtf);
		Singleton<NetManager>.instance.AddListener(3323, OnCharacterChangeNtf);
		Singleton<NetManager>.instance.AddListener(3324, OnCharacterDependChangeNtf);
		Singleton<NetManager>.instance.AddListener(3230, OnPotionChangeNtf);
		Singleton<NetManager>.instance.AddListener(4011, OnMissionRNtf);
		Singleton<NetManager>.instance.AddListener(4012, OnNewMissionRNtf);
		Singleton<NetManager>.instance.AddListener(4013, OnMissionRStateNtf);
		Singleton<NetManager>.instance.AddListener(4016, OnMissionRConditionStateNtf);
		Singleton<NetManager>.instance.AddListener(4023, OnMissionStageConditionGroupCompleteNtf);
		Singleton<NetManager>.instance.AddListener(4024, OnMissionRFlowCompleteNtf);
		Singleton<NetManager>.instance.AddListener(4019, OnMissionRFlowUpdateNtf);
		Singleton<NetManager>.instance.AddListener(4025, OnMissionTrackingNtf);
		Singleton<NetManager>.instance.AddListener(4022, OnMissionRExpireNtf);
		Singleton<NetManager>.instance.AddListener(4, OnAttributeNtf);
		Singleton<NetManager>.instance.AddListener(4200, OnHandBookInfoNtf);
		Singleton<NetManager>.instance.AddListener(4505, OnServiceSaveStateNtf);
		Singleton<NetManager>.instance.AddListener(3702, OnDropItemAddNtf);
		Singleton<NetManager>.instance.AddListener(4902, OnSystemOpenNtf);
		Singleton<NetManager>.instance.AddListener(4905, OnSystemTakeLevelRewardNtf);
		Singleton<NetManager>.instance.AddListener(5003, OnProgressNtf);
		Singleton<NetManager>.instance.AddListener(4509, OnLightedMapBlocksNtf);
		Singleton<NetManager>.instance.AddListener(5209, OnRaidNtf);
		Singleton<NetManager>.instance.AddListener(5300, OnShopNtf);
		Singleton<NetManager>.instance.AddListener(5609, OnAbyssNtf);
		Singleton<NetManager>.instance.AddListener(5002, OnOperationTimeStampsNtf);
		Singleton<NetManager>.instance.AddListener(3920, OnAvatarNtf);
		Singleton<NetManager>.instance.AddListener(3942, OnAvatarFrameNtf);
		Singleton<NetManager>.instance.AddListener(3945, OnTitleNtf);
		Singleton<NetManager>.instance.AddListener(5, OnKickUserNtf);
		Singleton<NetManager>.instance.AddListener(5106, OnMailNtf);
		Singleton<NetManager>.instance.AddListener(5706, OnAchievementNtf);
		Singleton<NetManager>.instance.AddListener(5808, OnCookNtf);
		Singleton<NetManager>.instance.AddListener(3205, OnItemGotLogsNtf);
		Singleton<NetManager>.instance.AddListener(5900, OnGuideLogsNtf);
		Singleton<NetManager>.instance.AddListener(5911, OnGuideChangeNtf);
		Singleton<NetManager>.instance.AddListener(3003, OnDailyDataNtf);
		Singleton<NetManager>.instance.AddListener(4512, OnMapViewNtf);
		Singleton<NetManager>.instance.AddListener(4201, OnHandbookNtf);
		Singleton<NetManager>.instance.AddListener(3208, OnLittleItemNtf);
		Singleton<NetManager>.instance.AddListener(6300, OnRedPointNtf);
		Singleton<NetManager>.instance.AddListener(6003, OnQNComplatedNtf);
		Singleton<NetManager>.instance.AddListener(6400, OnRogueInfoNtf);
		Singleton<NetManager>.instance.AddListener(6430, OnRogueTalentTreeUpgradeNtf);
		Singleton<NetManager>.instance.AddListener(5040, OnSkinAddNtf);
		Singleton<NetManager>.instance.AddListener(5048, OnSkinSyncNtf);
		Singleton<NetManager>.instance.AddListener(5058, OnEffectDressAddNtf);
		Singleton<NetManager>.instance.AddListener(5059, OnEffectDressSyncNtf);
		Singleton<NetManager>.instance.AddListener(6421, OnRogueCoinNtf);
		Singleton<NetManager>.instance.AddListener(6500, OnAssistantNpcNtf);
		Singleton<NetManager>.instance.AddListener(6601, OnGemInfoNtf);
		Singleton<NetManager>.instance.AddListener(6600, OnEquipNtf);
		Singleton<NetManager>.instance.AddListener(6800, OnContactNtf);
		Singleton<NetManager>.instance.AddListener(6802, OnContactCharacterSessionNtf);
		Singleton<NetManager>.instance.AddListener(6801, OnContactCharacterMessageNtf);
		Singleton<NetManager>.instance.AddListener(6700, OnTempleInfoNtf);
		Singleton<NetManager>.instance.AddListener(3101, OnActivityLevelRewardNtf);
		Singleton<NetManager>.instance.AddListener(3223, OnBloodBottleNtf);
		Singleton<NetManager>.instance.AddListener(3104, OnDoubleDungeonNtf);
		Singleton<NetManager>.instance.AddListener(5016, OnGachaPoolDataNtf);
		Singleton<NetManager>.instance.AddListener(5017, OnGachaPoolShareDataChangeNtf);
		Singleton<NetManager>.instance.AddListener(5036, OnGachaPoolTimeNtf);
		Singleton<NetManager>.instance.AddListener(3115, OnActivityCombinationNtf);
		Singleton<NetManager>.instance.AddListener(3138, OnActivityMainStoryNtf);
		Singleton<NetManager>.instance.AddListener(3141, OnActivityMapExploreNtf);
		Singleton<NetManager>.instance.AddListener(3144, OnActivityMultiDeviceNtf);
		Singleton<NetManager>.instance.AddListener(3118, OnActivityTempleChallengeNtf);
		Singleton<NetManager>.instance.AddListener(3107, OnActivitySignInNtf);
		Singleton<NetManager>.instance.AddListener(5023, OnClientUpdateNtf);
		Singleton<NetManager>.instance.AddListener(5022, OnAnnouncementUpdateNtf);
		Singleton<NetManager>.instance.AddListener(3100, OnOperationalActivityDataNtf);
		Singleton<NetManager>.instance.AddListener(3112, OnActivityAbyssNtf);
		Singleton<NetManager>.instance.AddListener(3224, OnTreasureInfoNtf);
		Singleton<NetManager>.instance.AddListener(5026, OnNewNoticeNtf);
		Singleton<NetManager>.instance.AddListener(6900, OnTeamNtf);
		Singleton<NetManager>.instance.AddListener(5033, TaskGroupNtf);
		Singleton<NetManager>.instance.AddListener(5027, OnTaskNtf);
		Singleton<NetManager>.instance.AddListener(4524, OnMapAreaDivinePupilsNtf);
		Singleton<NetManager>.instance.AddListener(4523, OnMapTrancePointNtf);
		Singleton<NetManager>.instance.AddListener(4529, OnMapAreaUnlockNtf);
		Singleton<NetManager>.instance.AddListener(4910, OnSystemStatusNtf);
		Singleton<NetManager>.instance.AddListener(4911, OnSystemStatusChangeNtf);
		Singleton<NetManager>.instance.AddListener(5034, OnClientModuleNtf);
		Singleton<NetManager>.instance.AddListener(5035, OnClientModuleUpdateNtf);
		Singleton<NetManager>.instance.AddListener(7100, OnBattlePassNtf);
		Singleton<NetManager>.instance.AddListener(3119, OnActivityRoleTrialNtf);
		Singleton<NetManager>.instance.AddListener(7200, OnVocabularyNtf);
		Singleton<NetManager>.instance.AddListener(3122, OnActivityDailyLotteryNtf);
		Singleton<NetManager>.instance.AddListener(3133, OnActivityKujiNtf);
		Singleton<NetManager>.instance.AddListener(5037, OnTipsNtf);
		Singleton<NetManager>.instance.AddListener(5720, OnAchievementInfoNtf);
		Singleton<NetManager>.instance.AddListener(5303, OnDiamondDataNtf);
		Singleton<NetManager>.instance.AddListener(5304, OnBundleDataNtf);
		Singleton<NetManager>.instance.AddListener(5030, OnGoodsNtf);
		Singleton<NetManager>.instance.AddListener(5032, OnDelGoodsNtf);
		Singleton<NetManager>.instance.AddListener(5031, OnAddGoodsNtf);
		Singleton<NetManager>.instance.AddListener(5045, OnMonthlyPassSyncNtf);
		Singleton<NetManager>.instance.AddListener(5041, OnMonthlyPassPurchaseNtf);
		Singleton<NetManager>.instance.AddListener(5042, OnMonthlyRewardNtf);
		Singleton<NetManager>.instance.AddListener(5504, OnOrderShipNtf);
		Singleton<NetManager>.instance.AddListener(3004, OnNotifyCollectionItemLimitNtf);
		Singleton<NetManager>.instance.AddListener(3234, OnItemDestroyedNtf);
		Singleton<NetManager>.instance.AddListener(3233, OnExpiredTimeLimitItemAutoUseNtf);
		Singleton<NetManager>.instance.AddListener(3127, OnActivitySkinTrialNtf);
		Singleton<NetManager>.instance.AddListener(3130, OnActivityTotalRechargeNtf);
		Singleton<NetManager>.instance.AddListener(5051, OnBloodStainNotify);
		Singleton<NetManager>.instance.AddListener(7300, OnReviewPromptNotify);
		Singleton<NetManager>.instance.AddListener(3237, OnUseSelfSelectGiftPackage);
	}

	private void OnReviewPromptNotify(IMessage message, bool reset)
	{
		if (message is ReviewPromptNtf)
		{
			MonoECS.instance.reviewPromptManager.Mark();
		}
	}

	private void OnBloodStainNotify(IMessage message, bool reset)
	{
		if (message is BloodStainNotify && !Model<BloodstainModel>.HasInstance())
		{
			Model<BloodstainModel>.CreateModel();
			Singleton<BloodstainRuntimeManager>.CreateInstance();
		}
	}

	private void OnNotifyCollectionItemLimitNtf(IMessage obj, bool reset)
	{
		if (obj is NotifyCollectionItemLimitNtf)
		{
			GameUtility.OpenToolTip(2640);
		}
	}

	private void OnAchievementInfoNtf(IMessage obj, bool reset)
	{
		if (obj is AchievementInfoNtf ntf)
		{
			if (!Model<AccomplishmentModel>.HasInstance())
			{
				Model<AccomplishmentModel>.CreateModel();
			}
			Model<AccomplishmentModel>.Interface.UpdateAchievementData(ntf);
		}
	}

	private void OnOrderShipNtf(IMessage arg1, bool arg2)
	{
		if (arg1 is OrderShipNtf ntf)
		{
			if (!Model<PayModel>.HasInstance())
			{
				Model<PayModel>.CreateModel();
			}
			Model<PayModel>.Interface.OnOrderShipNtf(ntf);
		}
	}

	private void OnBundleDataNtf(IMessage arg1, bool arg2)
	{
		if (!Model<ShopModel>.HasInstance())
		{
			Model<ShopModel>.CreateModel();
		}
		if (arg1 is BundleDataNtf bundleDataNtf)
		{
			Model<ShopModel>.Interface.UpdateBundleData(bundleDataNtf.BundleData);
			Model<ShopModel>.Interface.OnShopDataUpdate?.Invoke();
		}
	}

	private void OnDiamondDataNtf(IMessage arg1, bool arg2)
	{
		if (!Model<ShopModel>.HasInstance())
		{
			Model<ShopModel>.CreateModel();
		}
		if (arg1 is DiamondDataNtf diamondDataNtf)
		{
			Model<ShopModel>.Interface.UpdateDiamondData(diamondDataNtf.DiamondData);
		}
	}

	private void OnGoodsNtf(IMessage arg1, bool arg2)
	{
		if (!Model<ShopModel>.HasInstance())
		{
			Model<ShopModel>.CreateModel();
		}
		if (!(arg1 is GoodsNtf goodsNtf))
		{
			return;
		}
		Model<ShopModel>.Interface.GoodsData.Clear();
		foreach (PayGoods good in goodsNtf.Goods)
		{
			Model<ShopModel>.Interface.GoodsData[good.GoodsId] = good;
		}
		Model<ShopModel>.Interface.MarkGoodsDataSynced();
		Model<ShopModel>.Interface.OnShopDataUpdate?.Invoke();
		Model<ShopModel>.Interface.OnCommodityDataUpdate?.Invoke();
		if (Model<FacePushModel>.HasInstance())
		{
			Model<FacePushModel>.Interface.RequestCheck();
		}
	}

	private void OnDelGoodsNtf(IMessage arg1, bool arg2)
	{
		if (!Model<ShopModel>.HasInstance())
		{
			Model<ShopModel>.CreateModel();
		}
		if (!(arg1 is DelGoodsNtf delGoodsNtf))
		{
			return;
		}
		foreach (int goodsId in delGoodsNtf.GoodsIds)
		{
			Model<ShopModel>.Interface.GoodsData.Remove(goodsId);
		}
		Model<ShopModel>.Interface.OnShopDataUpdate?.Invoke();
		Model<ShopModel>.Interface.OnCommodityDataUpdate?.Invoke();
	}

	private void OnAddGoodsNtf(IMessage arg1, bool arg2)
	{
		if (!Model<ShopModel>.HasInstance())
		{
			Model<ShopModel>.CreateModel();
		}
		if (!(arg1 is AddGoodsNtf addGoodsNtf))
		{
			return;
		}
		foreach (PayGoods good in addGoodsNtf.Goods)
		{
			Model<ShopModel>.Interface.GoodsData[good.GoodsId] = good;
		}
		Model<ShopModel>.Interface.OnShopDataUpdate?.Invoke();
		Model<ShopModel>.Interface.OnCommodityDataUpdate?.Invoke();
	}

	private void OnMonthlyRewardNtf(IMessage arg1, bool arg2)
	{
		if (!Model<ShopModel>.HasInstance())
		{
			Model<ShopModel>.CreateModel();
		}
		if (arg1 is MonthlyPassDailyRewardNtf)
		{
			Model<ShopModel>.Interface.OnShopDataUpdate?.Invoke();
		}
	}

	private void OnMonthlyPassPurchaseNtf(IMessage arg1, bool arg2)
	{
		if (!Model<ShopModel>.HasInstance())
		{
			Model<ShopModel>.CreateModel();
		}
		if (arg1 is MonthlyPassPurchaseNtf monthlyPassPurchaseNtf)
		{
			Model<ShopModel>.Interface.MonthlyPassData[monthlyPassPurchaseNtf.Pass.PassId] = monthlyPassPurchaseNtf.Pass;
			Model<ShopModel>.Interface.OnShopDataUpdate?.Invoke();
			bool flag = false;
			if (Model<FacePushModel>.HasInstance())
			{
				flag = Model<FacePushModel>.Interface.ConsumeMonthlyPassItemFacePush();
				Model<FacePushModel>.Interface.NotifyMonthlyPassItemDataReady();
			}
			if (!flag)
			{
				GameUtility.OpenPopReward(GameUtility.ToUniversalItems(monthlyPassPurchaseNtf.ExtraItems.ToItems()));
				FacePushModel.MarkShopMonthlyPassFacePushPending((monthlyPassPurchaseNtf.Pass != null) ? monthlyPassPurchaseNtf.Pass.PassId : 0);
			}
		}
	}

	private void OnMonthlyPassSyncNtf(IMessage arg1, bool arg2)
	{
		if (!Model<ShopModel>.HasInstance())
		{
			Model<ShopModel>.CreateModel();
		}
		if (!(arg1 is MonthlyPassSyncNtf monthlyPassSyncNtf))
		{
			return;
		}
		Model<ShopModel>.Interface.MonthlyPassData.Clear();
		foreach (MonthlyPassEntry pass in monthlyPassSyncNtf.Passes)
		{
			Model<ShopModel>.Interface.MonthlyPassData[pass.PassId] = pass;
			Model<ShopModel>.Interface.OnShopDataUpdate?.Invoke();
		}
		if (Model<FacePushModel>.HasInstance())
		{
			Model<FacePushModel>.Interface.RequestCheck();
		}
	}

	private void OnVocabularyNtf(IMessage obj, bool rest)
	{
		if (obj is VocabularyNtf ntf)
		{
			if (!Model<TextLibraryModel>.HasInstance())
			{
				Model<TextLibraryModel>.CreateModel();
			}
			Model<TextLibraryModel>.Interface.UpdateTextLibrariesByNtf(ntf);
		}
	}

	private void OnBattlePassNtf(IMessage obj, bool reset)
	{
		if (obj is BattlePassNtf ntf)
		{
			if (!Model<BattlePassModel>.HasInstance())
			{
				Model<BattlePassModel>.CreateModel();
			}
			Model<BattlePassModel>.Interface.InitDataByNtf(ntf);
		}
	}

	private void OnSystemStatusNtf(IMessage obj, bool reset)
	{
		if (!(obj is SystemStatusNtf systemStatusNtf))
		{
			return;
		}
		foreach (SystemStatus system in systemStatusNtf.Systems)
		{
			Singleton<SystemBlockManager>.instance.Set(system);
		}
		if (reset)
		{
			FacePushModel.SuppressFacePushForReconnect();
		}
		else
		{
			FacePushModel.NotifyLoginSystemStatusSynced();
		}
	}

	private void OnSystemStatusChangeNtf(IMessage obj, bool reset)
	{
		if (obj is SystemStatusChangeNtf systemStatusChangeNtf)
		{
			Singleton<SystemBlockManager>.instance.Set(systemStatusChangeNtf.System);
		}
	}

	private void OnMapAreaDivinePupilsNtf(IMessage obj, bool reset)
	{
		if (obj is MapAreaDivinePupilsNtf areaDivinePupilsNtf)
		{
			G.localPlayer.ApplyChanges(areaDivinePupilsNtf, reset);
			if (!Model<DivineEyeModel>.HasInstance())
			{
				Model<DivineEyeModel>.CreateModel();
			}
			if (Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_LOGINWAITCLICK) is MonoLoginWaitClickView monoLoginWaitClickView)
			{
				monoLoginWaitClickView.UpdateAnnouncementRedDot();
			}
		}
	}

	private void OnClientUpdateNtf(IMessage obj, bool reset)
	{
		LuminApplication.RefreshRemoteConfig(MonoECS.instance);
	}

	private void OnAnnouncementUpdateNtf(IMessage obj, bool reset)
	{
		if (!(obj is TipNoticeNtf tipNoticeNtf) || !(BannerAnnouncement.Instance != null))
		{
			return;
		}
		foreach (TipNotice notice in tipNoticeNtf.Notices)
		{
			BannerAnnouncement.Instance.AddMessage(notice);
		}
	}

	private void OnNewNoticeNtf(IMessage obj, bool reset)
	{
		if (obj is NewNoticeNtf { Type: not 5 } newNoticeNtf)
		{
			if (newNoticeNtf.Type == 1)
			{
				AnnouncementRedDot.AddKnownId(isGameAnnouncement: true, newNoticeNtf.Id.ToString(), (AnnouncementPlace)newNoticeNtf.DisplayPos);
			}
			else if (newNoticeNtf.Type == 2)
			{
				AnnouncementRedDot.AddKnownId(isGameAnnouncement: false, newNoticeNtf.Id.ToString());
			}
			else
			{
				AnnouncementRedDot.SetKnownTimelineId(newNoticeNtf.Id.ToString());
			}
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.Announcement, !AnnouncementRedDot.IsAllRead(includeGame: true, includeActivity: true, includeTimeline: true, AnnouncementPlace.HCLR));
		}
	}

	private void OnDoubleDungeonNtf(IMessage obj, bool reset)
	{
		ActivityDoubleDungeonNtf activityDoubleDungeonNtf = obj as ActivityDoubleDungeonNtf;
		G.localPlayer.ApplyChanges(activityDoubleDungeonNtf, reset);
	}

	private void OnActivityLevelRewardNtf(IMessage obj, bool reset)
	{
		ActivityLevelRewardNtf activityLevelRewardNtf = obj as ActivityLevelRewardNtf;
		G.localPlayer.ApplyChanges(activityLevelRewardNtf, reset);
		if (!Model<ActivityModel>.HasInstance())
		{
			Model<ActivityModel>.CreateModel();
		}
	}

	private void OnTempleInfoNtf(IMessage obj, bool reset)
	{
		TempleInfoNtf templeInfoNtf = obj as TempleInfoNtf;
		if (!Model<TempleModel>.HasInstance())
		{
			Model<TempleModel>.CreateModel();
		}
		Model<TempleModel>.Interface.InitDataByNtf(templeInfoNtf.Info);
	}

	private void OnAssistantNpcNtf(IMessage obj, bool reset)
	{
		if ((G.localPlayer.AssistantSystem == null) | reset)
		{
			G.localPlayer.AssistantSystem = new AssistantSystem();
		}
		AssistantNpcNtf assistantNpcNtf = obj as AssistantNpcNtf;
		List<AssistantNpc> list = ListPool<AssistantNpc>.Get();
		list.AddRange(G.localPlayer.AssistantSystem.Npcs);
		G.localPlayer.AssistantSystem.Npcs.Clear();
		G.localPlayer.AssistantSystem.Npcs.AddRange(assistantNpcNtf.Npcs);
		foreach (AssistantNpc npc in list)
		{
			if (assistantNpcNtf.Npcs.All((AssistantNpc x) => x.Id != npc.Id))
			{
				NpcAssistChangeEvt evt = Singleton<EventManager>.instance.GetEvt<NpcAssistChangeEvt>();
				evt.npcId = npc.Id;
				evt.npcAssist = false;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.NpcAssistStateChange, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
		}
		foreach (AssistantNpc npc2 in assistantNpcNtf.Npcs)
		{
			if (list.All((AssistantNpc x) => x.Id != npc2.Id))
			{
				NpcAssistChangeEvt evt2 = Singleton<EventManager>.instance.GetEvt<NpcAssistChangeEvt>();
				evt2.npcId = npc2.Id;
				evt2.npcAssist = true;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.NpcAssistStateChange, evt2);
				Singleton<EventManager>.instance.ReleaseEvt(evt2);
			}
		}
		ListPool<AssistantNpc>.Release(list);
	}

	private void OnTeamNtf(IMessage obj, bool reset)
	{
		if (!Model<CharacterRepositoryModel>.HasInstance())
		{
			Model<CharacterRepositoryModel>.CreateModel();
		}
		if (!Model<CharacterModel>.HasInstance())
		{
			Model<CharacterModel>.CreateModel();
		}
		if (!Model<BloodBottleModel>.HasInstance())
		{
			Model<BloodBottleModel>.CreateModel();
		}
		if (!Model<EquipModel>.HasInstance())
		{
			Model<EquipModel>.CreateModel();
		}
		TeamInfoNtf team = obj as TeamInfoNtf;
		G.localPlayer.ApplyChanges(team, reset);
	}

	private void TaskGroupNtf(IMessage obj, bool reset)
	{
		foreach (ACT.Game.Data.TaskGroup change in (obj as TaskGroupNtf).Changes)
		{
			if (Singleton<PreconditionInfoManager>.instance.taskGroupDic.ContainsKey(change.Id))
			{
				Singleton<PreconditionInfoManager>.instance.taskGroupDic[change.Id] = change.Status;
			}
			else
			{
				Singleton<PreconditionInfoManager>.instance.taskGroupDic.Add(change.Id, change.Status);
			}
			if (change.Status == 1)
			{
				TaskGroupFinshEvt evt = Singleton<EventManager>.instance.GetEvt<TaskGroupFinshEvt>();
				evt.taskGroupId = change.Id;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.TaskGroupFinsh, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
		}
	}

	private void OnTaskNtf(IMessage obj, bool reset)
	{
		TaskNtf taskNtf = obj as TaskNtf;
		HashSet<int> hashSet = new HashSet<int>();
		foreach (KeyValuePair<int, int> target in taskNtf.Targets)
		{
			Dictionary<int, int> taskTargetDic = Singleton<PreconditionInfoManager>.instance.taskTargetDic;
			if (!taskTargetDic.TryGetValue(target.Key, out var value) || value != target.Value)
			{
				taskTargetDic[target.Key] = target.Value;
				hashSet.Add(target.Key);
			}
		}
		foreach (Task change in taskNtf.Changes)
		{
			ACT.Battle.TaskInfo taskInfo = new ACT.Battle.TaskInfo();
			taskInfo.progress = change.Progress;
			taskInfo.status = change.Status;
			bool flag = !Singleton<PreconditionInfoManager>.instance.taskDic.ContainsKey(change.Id);
			if (flag)
			{
				Singleton<PreconditionInfoManager>.instance.taskDic.Add(change.Id, taskInfo);
			}
			else
			{
				Singleton<PreconditionInfoManager>.instance.taskDic[change.Id] = taskInfo;
			}
			Singleton<PreconditionInfoManager>.instance.NotifyTaskProgressChange(change.Id, taskInfo, flag);
			hashSet.Remove(change.Id);
		}
		foreach (int item in hashSet)
		{
			if (Singleton<PreconditionInfoManager>.instance.taskDic.TryGetValue(item, out var value2))
			{
				Singleton<PreconditionInfoManager>.instance.NotifyTaskProgressChange(item, value2, isNew: false);
			}
		}
	}

	private void OnMapCustomFlagNtf(IMessage obj, bool reset)
	{
		MapCustomFlagNtf areaFlagsNtf = obj as MapCustomFlagNtf;
		if (!Model<MapSelfNodeModel>.HasInstance())
		{
			Model<MapSelfNodeModel>.CreateModel();
		}
		if (!Model<MapSelfNodeModel>.Interface.isFirstInit)
		{
			Model<MapSelfNodeModel>.Interface.Initialize(areaFlagsNtf);
			Model<MapSelfNodeModel>.Interface.isFirstInit = true;
		}
		else
		{
			Model<MapSelfNodeModel>.Interface.UpdateModelAreaFlags(areaFlagsNtf);
		}
	}

	private void OnLightedMapBlocksNtf(IMessage obj, bool reset)
	{
		LightedMapBlocksNtf lightedMapBlocksNtf = obj as LightedMapBlocksNtf;
		G.localPlayer.ApplyChanges(lightedMapBlocksNtf, reset);
	}

	private void OnAssistSkinNtf(IMessage obj, bool reset)
	{
		AssistSkinNtf assistSkinNtf = obj as AssistSkinNtf;
		G.localPlayer.ApplyChanges(assistSkinNtf, reset);
	}

	private void OnAssistNtf(IMessage obj, bool reset)
	{
		AssistNtf assistNtf = obj as AssistNtf;
		G.localPlayer.ApplyChanges(assistNtf, reset);
	}

	private void OnCharacterNtf(IMessage obj, bool reset)
	{
	}

	private void OnCharacterChangeNtf(IMessage obj, bool reset)
	{
		CharacterChangeNtf characterChangeNtf = obj as CharacterChangeNtf;
		CharacterRepository characterRepository = CharacterDataHelper.GetCharacterRepository(characterChangeNtf.SceneEnum);
		List<Character> list = ListPool<Character>.Get();
		foreach (KeyValuePair<int, Character> character2 in characterChangeNtf.Characters)
		{
			if (CharacterDataHelper.TryGetCharacter(characterRepository, character2.Key, out var character))
			{
				int level = character.Level;
				int level2 = character2.Value.Level;
				if (level != level2)
				{
					list.Add(character);
				}
			}
		}
		CharacterDataHelper.MergeCharacterDictionary(characterChangeNtf.SceneEnum, isExtraCharacter: false, characterRepository.Characters, characterChangeNtf.Characters, removeExcess: false);
		CharacterDataHelper.MergeCharacterDictionary(characterChangeNtf.SceneEnum, isExtraCharacter: true, characterRepository.ExtraCharacters, characterChangeNtf.ExtraCharacters, removeExcess: false);
		CharacterNtfEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterNtfEvt>();
		evt.characterChanges = ListPool<Character>.Get();
		evt.characterChanges.AddRange(characterChangeNtf.Characters.Values);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnCharcterNtf, evt);
		ListPool<Character>.Release(evt.characterChanges);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		foreach (Character item in list)
		{
			CharacterUpdateEvt evt2 = Singleton<EventManager>.instance.GetEvt<CharacterUpdateEvt>();
			evt2.character = item;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Character_LevelUp, evt2);
			Singleton<EventManager>.instance.ReleaseEvt(evt2);
		}
		ListPool<Character>.Release(list);
	}

	private void OnCharacterDependChangeNtf(IMessage obj, bool reset)
	{
		CharacterDependChangeNtf characterDependChangeNtf = obj as CharacterDependChangeNtf;
		CharacterRepository characterRepository = CharacterDataHelper.GetCharacterRepository(characterDependChangeNtf.SceneEnum);
		MergeCharacterDependChange(characterRepository.Characters, characterRepository.CharacterDependSnapshot, characterDependChangeNtf.CharacterDependSnapshot, characterDependChangeNtf.Remove);
		MergeCharacterDependChange(characterRepository.ExtraCharacters, characterRepository.ExtraCharacterDependSnapshot, characterDependChangeNtf.ExtraCharacterDependSnapshot, characterDependChangeNtf.Remove);
		CharacterDependChangeEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterDependChangeEvt>();
		evt.sceneEnum = characterDependChangeNtf.SceneEnum;
		evt.remove = characterDependChangeNtf.Remove;
		evt.characterDependSnapshot = characterDependChangeNtf.CharacterDependSnapshot;
		evt.extraCharacterDependSnapshot = characterDependChangeNtf.ExtraCharacterDependSnapshot;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterDependChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void MergeCharacterDependChange(MapField<int, Character> characters, CharacterDependSnapshot repoSnap, CharacterDependSnapshot incomingSnap, bool remove)
	{
		if (repoSnap != null && incomingSnap != null)
		{
			if (remove)
			{
				CharacterDependHelper.RemoveFromSnap(repoSnap, incomingSnap);
				return;
			}
			CharacterDependHelper.MergePresenceCharacterDependDictionary(characters, repoSnap, repoSnap.EquipSnapshot, incomingSnap.EquipSnapshot, removeExcess: false);
			CharacterDependHelper.MergePresenceCharacterDependDictionary(characters, repoSnap, repoSnap.GemSnapshot, incomingSnap.GemSnapshot, removeExcess: false);
		}
	}

	private async void OnPotionChangeNtf(IMessage obj, bool reset)
	{
		PotionChangeNtf potionChangeNtf = obj as PotionChangeNtf;
		PotionChangeEvt evt = Singleton<EventManager>.instance.GetEvt<PotionChangeEvt>();
		evt.sceneIndex = potionChangeNtf.SceneEnum;
		evt.potionItems = potionChangeNtf.Potions;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.PotionChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void OnWeaponNtf(IMessage obj, bool reset)
	{
		WeaponNtf weaponNtf = obj as WeaponNtf;
		foreach (Weapon change in weaponNtf.Changes)
		{
			if (G.localPlayer.Inventory.GetWeaponIndex(change.Uid) == -1)
			{
				WeaponGetEvt evt = EventTrackSolver.Instance.GetEvt<WeaponGetEvt>();
				evt.changeWay = (int)weaponNtf.ChangeWay;
				evt.weapon = change;
				EventTrackSolver.Instance.Dispatch(evt);
			}
		}
		foreach (int removeUid in weaponNtf.RemoveUids)
		{
			Weapon weapon = G.localPlayer.Inventory.GetWeapon(removeUid);
			WeaponCostEvt evt2 = EventTrackSolver.Instance.GetEvt<WeaponCostEvt>();
			evt2.changeWay = (int)weaponNtf.ChangeWay;
			evt2.weapon = weapon;
			EventTrackSolver.Instance.Dispatch(evt2);
		}
		G.localPlayer.Inventory.ApplyChanges(weaponNtf, reset);
	}

	private void OnEquipNtf(IMessage obj, bool reset)
	{
	}

	private void OnGemInfoNtf(IMessage obj, bool reset)
	{
	}

	private void OnCookNtf(IMessage obj, bool reset)
	{
		CookNtf cookNtf = obj as CookNtf;
		G.localPlayer.ApplyChanges(cookNtf, reset);
	}

	private void OnItemNtf(IMessage obj, bool reset)
	{
		List<Item> list = CollectionPool<List<Item>, Item>.Get();
		List<Item> list2 = CollectionPool<List<Item>, Item>.Get();
		List<ItemAchieveinfo> toRelease = CollectionPool<List<ItemAchieveinfo>, ItemAchieveinfo>.Get();
		List<ItemAchieveinfo> toRelease2 = CollectionPool<List<ItemAchieveinfo>, ItemAchieveinfo>.Get();
		List<int> list3 = CollectionPool<List<int>, int>.Get();
		ItemNtf itemNtf = obj as ItemNtf;
		for (int i = 0; i < itemNtf.Changes.Count; i++)
		{
			Item item = itemNtf.Changes[i];
			if (!G.localPlayer.newItem.Contains(item.Id))
			{
				list3.Add(0);
			}
			else
			{
				list3.Add(G.localPlayer.Inventory.GetItemInfo(item.Id).Count);
			}
			if (MonoECS.instance.isStartWorld && item.Count == 1 && CoreUtils.GetData(item.Id, RuntimeConfigs.data.itemDatas).useType == 2)
			{
				ChallengeTreasureMapGetitem evt = Singleton<EventManager>.instance.GetEvt<ChallengeTreasureMapGetitem>();
				evt.itemid = item.Id;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChallengeTreasureMapGetitem, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
		}
		G.localPlayer.Inventory.ApplyChanges(itemNtf, list, list2, reset);
		if (!Model<GiftPackageModel>.HasInstance())
		{
			Model<GiftPackageModel>.CreateModel();
		}
		if (itemNtf.ChangeWay == ItemsWays.ItemwaysGetBagChestReward && list.All((Item item4) => item4.itemType != 35))
		{
			GetPackageGiftItems evt2 = Singleton<EventManager>.instance.GetEvt<GetPackageGiftItems>();
			evt2.getItems = list;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.PackageGiftGetItems, evt2);
		}
		for (int num = 0; num < list.Count; num++)
		{
			Item item2 = list[num];
			ItemChangeEvt evt3 = Singleton<EventManager>.instance.GetEvt<ItemChangeEvt>();
			evt3.ItemProxies = ListPool<ItemUnifierProxy>.Get();
			evt3.ItemProxies.Add(ItemUnifierProxy.ItemUnifierPool.Get(item2));
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.BagItemChange, evt3);
			ItemUnifierProxy.ItemUnifierPool.Release(evt3.ItemProxies);
			ListPool<ItemUnifierProxy>.Release(evt3.ItemProxies);
			Singleton<EventManager>.instance.ReleaseEvt(evt3);
			ItemEvtGet evt4 = EventTrackSolver.Instance.GetEvt<ItemEvtGet>();
			evt4.item = item2;
			evt4.changeWay = (int)itemNtf.ChangeWay;
			evt4.changeNum = item2.Count;
			EventTrackSolver.Instance.Dispatch(evt4);
			ItemUnifierProxyEvt evt5 = Singleton<EventManager>.instance.GetEvt<ItemUnifierProxyEvt>();
			evt5.data = ItemUnifierProxy.ItemUnifierPool.Get(item2);
			evt5.source = itemNtf.ChangeWay;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.ItemAdd, evt5);
			ItemUnifierProxy.ItemUnifierPool.Release(ref evt5.data);
			Singleton<EventManager>.instance.ReleaseEvt(evt5);
		}
		for (int num2 = 0; num2 < list2.Count; num2++)
		{
			Item item3 = list2[num2];
			ItemChangeEvt evt6 = Singleton<EventManager>.instance.GetEvt<ItemChangeEvt>();
			evt6.ItemProxies = ListPool<ItemUnifierProxy>.Get();
			evt6.ItemProxies.Add(ItemUnifierProxy.ItemUnifierPool.Get(item3));
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.BagItemChange, evt6);
			ItemUnifierProxy.ItemUnifierPool.Release(evt6.ItemProxies);
			ListPool<ItemUnifierProxy>.Release(evt6.ItemProxies);
			ItemEvtCost evt7 = EventTrackSolver.Instance.GetEvt<ItemEvtCost>();
			evt7.item = item3;
			evt7.changeWay = (int)itemNtf.ChangeWay;
			evt7.changeNum = item3.Count;
			EventTrackSolver.Instance.Dispatch(evt7);
			ItemUnifierProxyEvt evt8 = Singleton<EventManager>.instance.GetEvt<ItemUnifierProxyEvt>();
			evt8.data = ItemUnifierProxy.ItemUnifierPool.Get(item3);
			evt8.source = itemNtf.ChangeWay;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.ItemMinus, evt8);
			ItemUnifierProxy.ItemUnifierPool.Release(ref evt8.data);
			Singleton<EventManager>.instance.ReleaseEvt(evt8);
		}
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.ItemChangeEnd, null);
		CollectionPool<List<Item>, Item>.Release(list);
		CollectionPool<List<Item>, Item>.Release(list2);
		CollectionPool<List<ItemAchieveinfo>, ItemAchieveinfo>.Release(toRelease);
		CollectionPool<List<ItemAchieveinfo>, ItemAchieveinfo>.Release(toRelease2);
		CollectionPool<List<int>, int>.Release(list3);
	}

	private void OnMissionRNtf(IMessage obj, bool reset)
	{
		if (!reset)
		{
			MissionRNtf missions = obj as MissionRNtf;
			((IMissionManagerServerCall)Singleton<MissionManager>.instance).InitMissions(missions);
		}
	}

	private void OnMissionRStateNtf(IMessage obj, bool reset)
	{
		if (!reset)
		{
			MissionStateUpdateNtf missionStateUpdateNtf = obj as MissionStateUpdateNtf;
			if (missionStateUpdateNtf.Rewards.Count > 0)
			{
				PropPickingUtility.DispatchPropPickingEvt(Model<InventoryModel>.Interface.InventoryOverflowHandle(missionStateUpdateNtf.Rewards).ToList(), PropPickingWay.Mission);
			}
		}
	}

	private void OnMissionRConditionStateNtf(IMessage obj, bool reset)
	{
	}

	private void OnMissionStageConditionGroupCompleteNtf(IMessage obj, bool reset)
	{
	}

	private void OnNewMissionRNtf(IMessage obj, bool reset)
	{
	}

	private void OnMissionRFlowCompleteNtf(IMessage obj, bool reset)
	{
	}

	private void OnMissionRFlowUpdateNtf(IMessage obj, bool reset)
	{
	}

	private void OnMissionRExpireNtf(IMessage obj, bool reset)
	{
	}

	private void OnMissionTrackingNtf(IMessage obj, bool reset)
	{
		if (!reset)
		{
			MissionTrackingNtf missionTrackingNtf = obj as MissionTrackingNtf;
			((IMissionManagerServerCall)Singleton<MissionManager>.instance).InitTracingMission((int)missionTrackingNtf.MissionID);
		}
	}

	private void OnAttributeNtf(IMessage obj, bool reset)
	{
		MapField<int, long> mapField = G.detailUserInfo.Attributes.Clone();
		AttributeNtf attributeNtf = obj as AttributeNtf;
		G.detailUserInfo.ApplyChanges(attributeNtf, reset);
		foreach (KeyValuePair<int, long> change in attributeNtf.Changes)
		{
			if (change.Key == 93)
			{
				if (mapField.TryGetValue(93, out var value) && mapField.TryGetValue(90, out var value2))
				{
					int num = (int)value2;
					int playerLevel = SystemUnlockManager.playerLevel;
					int num2 = 0;
					for (int i = num; i < playerLevel; i++)
					{
						PlayerLevelData playerLevelData = RuntimeConfigs.data.playerLevelDatas[i];
						num2 += playerLevelData.xpEachLv;
					}
					G.localPlayer.playerExpData.addExp = (int)(num2 - value + (int)change.Value);
					G.localPlayer.playerExpData.beforeExp = (int)value;
					G.localPlayer.playerExpData.totleExp = num2;
					G.localPlayer.playerExpData.currentExp = (int)G.detailUserInfo.Attributes[93];
					G.localPlayer.playerExpData.beforeLevel = num;
					G.localPlayer.playerExpData.curLevel = SystemUnlockManager.playerLevel;
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.PlayerExp_Change, null);
					GameUtility.OpenAdventureTip();
				}
				else if (!LuminApplication.LogEnabled)
				{
				}
			}
			else if (change.Key == 90 || change.Key == 94)
			{
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.PlayLevel_Change, null);
				if (mapField.TryGetValue(90, out var value3))
				{
					PlayerLevelUpEvt evt = EventTrackSolver.Instance.GetEvt<PlayerLevelUpEvt>();
					evt.levelBefore = (int)value3;
					evt.levelAfter = SystemUnlockManager.playerLevel;
					EventTrackSolver.Instance.Dispatch(evt);
					PlayerLevelChangeEvt evt2 = Singleton<EventManager>.instance.GetEvt<PlayerLevelChangeEvt>();
					evt2.beforeLevel = (int)value3;
					evt2.curretLevel = SystemUnlockManager.playerLevel;
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.PlayerLevelUpChange, evt2);
					Singleton<EventManager>.instance.ReleaseEvt(evt2);
				}
				BamBooSdk.getInstance().updateRole(new RoleInfo
				{
					serverId = LoginUtility.LoginAck.ServerGroup,
					roleId = LoginUtility.EnterGameAck.Info.Brief.AccountId.ToString(),
					roleLevel = SystemUnlockManager.playerLevel.ToString()
				});
			}
			else if (change.Key == 2)
			{
				if (mapField.TryGetValue(change.Key, out var value4))
				{
					LukeGetEvt evt3 = EventTrackSolver.Instance.GetEvt<LukeGetEvt>();
					evt3.item = new Item
					{
						Id = change.Key,
						Count = (int)change.Value
					};
					evt3.changeNum = (int)(change.Value - value4);
					evt3.changeWay = (int)attributeNtf.ChangeWay;
					EventTrackSolver.Instance.Dispatch(evt3);
				}
				else
				{
					_ = LuminApplication.LogEnabled;
				}
			}
			if (change.Key == 6)
			{
				if (mapField.TryGetValue(change.Key, out var value5))
				{
					MonsterExpAddEvt evt4 = Singleton<EventManager>.instance.GetEvt<MonsterExpAddEvt>();
					evt4.addNum = change.Value - value5;
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.MonsterExpAdd, evt4);
					Singleton<EventManager>.instance.ReleaseEvt(evt4);
				}
				if (RuntimeConfigs.data.game.worldExpDropLimit <= G.detailUserInfo.Attributes[change.Key])
				{
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.Role_Daily_Monster_Exp_Max, null);
				}
			}
			if (change.Key == 7 && RuntimeConfigs.data.game.worldCoinDropLimit <= G.detailUserInfo.Attributes[change.Key])
			{
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.Role_Daily_Monster_Coin_Max, null);
			}
			if (change.Key == 100)
			{
				G.detailUserInfo.Attributes.TryGetValue(change.Key, out var value6);
				EventTrackSolver.Instance.UpdateVipPoint(value6);
			}
			if (change.Key == 90)
			{
				G.detailUserInfo.Attributes.TryGetValue(change.Key, out var value7);
				EventTrackSolver.Instance.UpdatePlayerLevel(value7);
			}
			try
			{
				AttributeChangeEvt evt5 = EventTrackSolver.Instance.GetEvt<AttributeChangeEvt>();
				evt5.attributeType = (PlayerAttribute)change.Key;
				G.detailUserInfo.Attributes.TryGetValue(change.Key, out var value8);
				mapField.TryGetValue(change.Key, out var value9);
				evt5.changeNum = value8 - value9;
				evt5.getReason = (int)attributeNtf.ChangeWay;
				EventTrackSolver.Instance.Dispatch(evt5);
			}
			catch (Exception)
			{
				_ = LuminApplication.LogEnabled;
			}
		}
		foreach (KeyValuePair<int, long> change2 in attributeNtf.Changes)
		{
			mapField.TryGetValue(change2.Key, out var value10);
			PlayerAttributeChangeEvt evt6 = Singleton<EventManager>.instance.GetEvt<PlayerAttributeChangeEvt>();
			evt6.id = change2.Key;
			evt6.lastNum = value10;
			evt6.currentNum = change2.Value;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_PlayerAttribute_Refresh, evt6);
			Singleton<EventManager>.instance.ReleaseEvt(evt6);
		}
	}

	private void OnHandBookInfoNtf(IMessage obj, bool reset)
	{
		HandbookInfoNtf handbook = obj as HandbookInfoNtf;
		G.localPlayer.ApplyChanges(handbook, reset);
	}

	private void OnServiceSaveStateNtf(IMessage obj, bool reset)
	{
		ServiceSaveStateNtf serviceSaveStateNtf = obj as ServiceSaveStateNtf;
		_oldStateMap.Clear();
		foreach (ServiceSaveState change in serviceSaveStateNtf.Changes)
		{
			if (G.localPlayer.Maps.TryGetValue(serviceSaveStateNtf.Wid, out var value) && value.ServiceSaveStateIds.TryGetValue(change.Uid, out var value2))
			{
				_oldStateMap[change.Uid] = value2;
			}
		}
		foreach (ServiceSaveState change2 in serviceSaveStateNtf.Changes)
		{
			if ((reset && change2.StateId == _oldStateMap[change2.Uid]) || !G.localPlayer.Maps.TryGetValue(serviceSaveStateNtf.Wid, out var value3))
			{
				continue;
			}
			TrackInteractChangeEvt evt = EventTrackSolver.Instance.GetEvt<TrackInteractChangeEvt>();
			evt.worldId = serviceSaveStateNtf.Wid;
			evt.interactId = change2.Uid;
			_oldStateMap.TryGetValue(change2.Uid, out evt.stateOld);
			evt.stateCurrent = change2.StateId;
			if (MonoECS.instance.mainEntity.IsValid)
			{
				evt.Roleid = MonoECS.instance.mainEntity.GetTableId();
			}
			if (StateWorldAsset.TryGetWorldAssetBySwid(change2.Uid, out var stateWorldAsset))
			{
				if (stateWorldAsset.stateObjectBase != null)
				{
					evt.objectName = stateWorldAsset.stateObjectBase.name;
				}
				evt.interactType = stateWorldAsset.data.stateObjectType;
			}
			EventTrackSolver.Instance.Dispatch(evt);
			value3.ServiceSaveStateIds[change2.Uid] = change2.StateId;
			value3.ServiceBehaveIds[change2.Uid] = change2.BehaveId;
		}
		G.localPlayer.ApplyChanges(serviceSaveStateNtf, reset);
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (!worldManager.HasActiveWorld || worldManager.ActiveWorldId != serviceSaveStateNtf.Wid)
		{
			return;
		}
		if (worldManager.ActiveSceneStatus != SceneStatus.Main)
		{
			WorldChallengeState activeWorldChallengeState = worldManager.ActiveWorldChallengeState;
			if (activeWorldChallengeState == WorldChallengeState.Success || activeWorldChallengeState == WorldChallengeState.Fail)
			{
				return;
			}
		}
		foreach (ServiceSaveState change3 in serviceSaveStateNtf.Changes)
		{
			if (!reset || change3.StateId != _oldStateMap[change3.Uid])
			{
				ServiceStateRefresh evt2 = Singleton<EventManager>.instance.GetEvt<ServiceStateRefresh>();
				evt2.swid = change3.Uid;
				_oldStateMap.TryGetValue(evt2.swid, out evt2.oldStateId);
				evt2.stateId = change3.StateId;
				evt2.behaveId = change3.BehaveId;
				evt2.cleanedTs = change3.CleanedTs;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.ServiceSave_Refresh, evt2);
				Singleton<EventManager>.instance.ReleaseEvt(evt2);
			}
		}
	}

	private void OnDropItemAddNtf(IMessage obj, bool reset)
	{
		DropItemAddNtf dropItemAddNtf = obj as DropItemAddNtf;
		G.localPlayer.ApplyChanges(dropItemAddNtf, reset);
		Singleton<DropItemManager>.instance.RegisterDropPackage(dropItemAddNtf);
		DropItemChangeEvt evt = Singleton<EventManager>.instance.GetEvt<DropItemChangeEvt>();
		evt.dropItemAddNtf = dropItemAddNtf;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.DropItem_Change, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void OnSystemOpenNtf(IMessage obj, bool reset)
	{
		SystemOpenNtf systemOpens = obj as SystemOpenNtf;
		G.localPlayer.ApplyChanges(systemOpens, reset);
		if (reset)
		{
			FacePushModel.SuppressFacePushForReconnect();
		}
		else
		{
			FacePushModel.NotifyLoginSystemOpenSynced();
		}
	}

	private void OnSystemTakeLevelRewardNtf(IMessage obj, bool reset)
	{
		SystemTakeLevelRewardNtf systemTakeLevelRewardNtf = obj as SystemTakeLevelRewardNtf;
		G.localPlayer.ApplyChanges(systemTakeLevelRewardNtf, reset);
	}

	private void OnProgressNtf(IMessage obj, bool reset)
	{
	}

	private void OnRaidNtf(IMessage obj, bool reset)
	{
		RaidNtf raidNtf = obj as RaidNtf;
		if (!Model<RaidModel>.HasInstance())
		{
			Model<RaidModel>.CreateModel();
		}
		Model<RaidModel>.Interface.InitDataByNtf(raidNtf.Raids, raidNtf.ChallengingRaidId);
	}

	private void OnShopNtf(IMessage obj, bool reset)
	{
		ShopNtf shopNtf = obj as ShopNtf;
		G.localPlayer.ApplyChanges(shopNtf, reset);
	}

	private void OnDailyDataNtf(IMessage obj, bool reset)
	{
		DailyDataNtf dailyDataNtf = obj as DailyDataNtf;
		G.localPlayer.ApplyChanges(dailyDataNtf, reset);
		if (!Model<WildBossModel>.HasInstance())
		{
			Model<WildBossModel>.CreateModel();
		}
		Model<WildBossModel>.Interface.UpdateDataByNtf(dailyDataNtf.DailyData);
	}

	private void OnAbyssNtf(IMessage obj, bool reset)
	{
		if (obj is AbyssNtf abyssNtf)
		{
			if (!Model<AbyssModel>.HasInstance())
			{
				Model<AbyssModel>.CreateModel();
			}
			Model<AbyssModel>.Interface.InitDataByNtf(abyssNtf);
		}
	}

	private void OnOperationTimeStampsNtf(IMessage obj, bool reset)
	{
		OperationTimeStampsNtf operationTimeStampsNtf = obj as OperationTimeStampsNtf;
		SystemUnlockManager.operationTs = operationTimeStampsNtf.ChangeWorldLevelTS;
		if (!Model<PlayerGenderModel>.HasInstance())
		{
			Model<PlayerGenderModel>.CreateModel();
		}
		Model<PlayerGenderModel>.Interface.ReviseGenderTs(operationTimeStampsNtf.ChangeGenderTS);
	}

	private void OnAvatarNtf(IMessage obj, bool reset)
	{
		EscAvatarNtf avatarNtf = obj as EscAvatarNtf;
		G.localPlayer.ApplyChanges(avatarNtf, reset);
	}

	private void OnAvatarFrameNtf(IMessage obj, bool reset)
	{
		EscAvatarFrameNtf avatarFrameNtf = obj as EscAvatarFrameNtf;
		G.localPlayer.ApplyChanges(avatarFrameNtf, reset);
	}

	private void OnTitleNtf(IMessage obj, bool reset)
	{
		EscTitleNtf titleNtf = obj as EscTitleNtf;
		G.localPlayer.ApplyChanges(titleNtf, reset);
	}

	private void OnMailNtf(IMessage obj, bool reset)
	{
		MailNtf mailNtf = obj as MailNtf;
		G.localPlayer.ApplyChanges(mailNtf, reset);
		if (Singleton<MailboxCacheManager>.HasInstance())
		{
			Singleton<MailboxCacheManager>.instance.GetMailAfterCreateInstance(mailNtf);
		}
	}

	private void OnKickUserNtf(IMessage obj, bool reset)
	{
		KickUserNtf kickUserNtf = obj as KickUserNtf;
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("当前账号被踢出=>" + kickUserNtf.Reason);
		}
		if (kickUserNtf != null)
		{
			ErrorAck info = kickUserNtf.Info;
			if (info != null && info.CodeModule == 43 && info.CodeType == 1 && info.SubCode == 2)
			{
				if (LuminBambooBridgeListener.TryLogoutAndQuitGameForWeGameAccountSwitch())
				{
					return;
				}
				BamBooSdk.getInstance().getExtend("logoutAndCleanData");
			}
		}
		object obj2 = null;
		object obj3 = null;
		if (kickUserNtf?.Info?.Param != null)
		{
			obj2 = kickUserNtf.Info.Param.Uid;
			obj3 = ((kickUserNtf.Info.Param.BanEndTimestamp != 0L) ? TimeManager.GetDateTimeString(kickUserNtf.Info.Param.BanEndTimestamp, "yyyy/MM/dd  HH:mm:ss") : null);
		}
		MonoECS.instance.PushPause();
		LuminError.Handle(kickUserNtf.Info, new ErrorHandleOptions(ErrorPresentation.Dialog, new object[2] { obj2, obj3 }, null, null, () =>
		{
			MonoECS.instance.PopPause();
			MonoECS.instance.DestroyWorld().Forget();
		}));
		MonoECS.instance.RemoveNetworkListener();
	}

	private void OnAchievementNtf(IMessage obj, bool reset)
	{
		AchievementNtf achievementNtf = obj as AchievementNtf;
		G.localPlayer.ApplyChanges(achievementNtf, reset);
	}

	private void OnItemGotLogsNtf(IMessage obj, bool reset)
	{
		ItemGotLogsNtf itemGotLogsNtf = obj as ItemGotLogsNtf;
		G.localPlayer.ApplyChanges(itemGotLogsNtf, reset);
		if (!Model<ObtainedItemModel>.HasInstance())
		{
			Model<ObtainedItemModel>.CreateModel();
		}
		else
		{
			Model<ObtainedItemModel>.Interface.SyncFromPlayerGotItems();
		}
	}

	private void OnGuideLogsNtf(IMessage obj, bool reset)
	{
		GuideLogsNtf guideLogsNtf = obj as GuideLogsNtf;
		G.localPlayer.ApplyChanges(guideLogsNtf, reset);
		if (!Model<TutorialModel>.HasInstance())
		{
			Model<TutorialModel>.CreateModel();
			Model<TutorialModel>.Interface.MergeDataOnGuideLogsNtf(guideLogsNtf.GuideLogs);
		}
		else
		{
			Model<TutorialModel>.Interface.RefreshOnGuideLogsNtf(guideLogsNtf.GuideLogs);
		}
		if (!Model<GuideModel>.HasInstance())
		{
			Model<GuideModel>.CreateModel();
		}
		if (!reset)
		{
			Model<GuideModel>.Interface.RefreshGuideNtf(guideLogsNtf.GuideLogs.AllGuides);
		}
	}

	private void OnGuideChangeNtf(IMessage obj, bool reset)
	{
		if (obj is GuideChangeNtf guideChangeNtf)
		{
			if (!Model<GuideModel>.HasInstance())
			{
				Model<GuideModel>.CreateModel();
			}
			Model<GuideModel>.Interface.AddGuideNtf(guideChangeNtf.Changed);
		}
	}

	private void OnMapTrancePointNtf(IMessage obj, bool reset)
	{
		if (obj is MapTrancePointNtf mapTrancePointNtf)
		{
			if (!Model<MapModel>.HasInstance())
			{
				Model<MapModel>.CreateModel();
			}
			Model<MapModel>.Interface.SetMapPointTraceInfo(mapTrancePointNtf.Point.AreaID, (int)mapTrancePointNtf.Point.PointType, mapTrancePointNtf.Point.PointID, isInit: true);
		}
	}

	private void OnMapAreaUnlockNtf(IMessage message, bool reset)
	{
		MapAreaUnlockNtf mapAreaUnlockNtf = message as MapAreaUnlockNtf;
		if (!Model<MapModel>.HasInstance())
		{
			Model<MapModel>.CreateModel();
		}
		Model<MapModel>.Interface.InitMapExploreData(mapAreaUnlockNtf.AreaExplore.ToDictionary((KeyValuePair<int, MapAreaExplore> explore) => explore.Value.Id, (KeyValuePair<int, MapAreaExplore> explore) => explore.Value));
	}

	private void OnMapViewNtf(IMessage message, bool reset)
	{
		MapViewNtf mapViewNtf = message as MapViewNtf;
		if (!Model<MapModel>.HasInstance())
		{
			Model<MapModel>.CreateModel();
		}
		Model<MapModel>.Interface.MergeMapExploreInfo(mapViewNtf.MapViewFull, reset);
	}

	private void OnHandbookNtf(IMessage message, bool reset)
	{
		HandbookNtf handbookNtf = message as HandbookNtf;
		if (!Model<MonsterHandModel>.HasInstance())
		{
			Model<MonsterHandModel>.CreateModel();
		}
		Model<MonsterHandModel>.Interface.MergeHandBookInfo(handbookNtf.Handbook);
		Model<MonsterHandModel>.Interface.InitWildBossDic(handbookNtf.Handbook);
		G.localPlayer.ApplyChanges(handbookNtf, reset);
		if (Model<TargetGuideModel>.HasInstance())
		{
			Model<TargetGuideModel>.Interface.SyncTargetGuideRewardsState();
		}
	}

	private void OnLittleItemNtf(IMessage message, bool reset)
	{
		LittleItemsNtf littleItemNtf = message as LittleItemsNtf;
		G.localPlayer.ApplyChanges(littleItemNtf, reset);
		if (!Model<LittleItemModel>.HasInstance())
		{
			Model<LittleItemModel>.CreateModel();
		}
		Model<LittleItemModel>.Interface.BindData();
	}

	private void OnRedPointNtf(IMessage message, bool reset)
	{
		RedPointNtf redPointNtf = message as RedPointNtf;
		G.localPlayer.ApplyChanges(redPointNtf, reset);
		bool flag = false;
		foreach (KeyValuePair<int, bool> item in redPointNtf.Info.CustomerComplaint)
		{
			flag |= item.Value;
		}
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.HasFeedback, flag);
		if (redPointNtf.Info.Characters.Count > 0)
		{
			Singleton<RedDotManager>.instance.InitCharacterTrieNode(redPointNtf.Info.Characters);
		}
		if (redPointNtf.Info.AreaExploreRedPoint.Count > 0)
		{
			Singleton<RedDotManager>.instance.InitMapExploreTrieNode(redPointNtf.Info.AreaExploreRedPoint);
		}
		if (redPointNtf.Info.Avatars.Count > 0)
		{
			Singleton<RedDotManager>.instance.InitAccountDecorationTrieNode(redPointNtf.Info.Avatars, RedDotPathDefine.AccountDecorationAvatarNew, 1054);
		}
		if (redPointNtf.Info.AvatarFrames.Count > 0)
		{
			Singleton<RedDotManager>.instance.InitAccountDecorationTrieNode(redPointNtf.Info.AvatarFrames, RedDotPathDefine.AccountDecorationAvatarFrameNew, 1054);
		}
		if (redPointNtf.Info.Titles.Count > 0)
		{
			Singleton<RedDotManager>.instance.InitAccountDecorationTrieNode(redPointNtf.Info.Titles, RedDotPathDefine.AccountDecorationTitleNew, 1054);
		}
		foreach (KeyValuePair<int, bool> item2 in redPointNtf.Info.Items)
		{
			ItemData data = CoreUtils.GetData(item2.Key, RuntimeConfigs.data.itemDatas);
			if (data != null && data.type == 15)
			{
				string nodeFullPath = string.Format(RedDotPathDefine.BottleNPC + "|{0}|", item2.Key);
				Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath, item2.Value);
			}
		}
		if (!Model<BattleMainModel>.HasInstance())
		{
			Model<BattleMainModel>.CreateModel();
		}
		if (!Model<BattleMainModel>.HasInstance())
		{
			return;
		}
		foreach (KeyValuePair<int, bool> system in redPointNtf.Info.Systems)
		{
			if (RuntimeConfigs.data.systemOpens.TryGetValue(system.Key, out var value) && value.systemUnlockPrompts)
			{
				Model<BattleMainModel>.Interface.UpdateEscItemRedDot(system.Key, system.Value);
			}
		}
	}

	private void OnBloodBottleNtf(IMessage message, bool reset)
	{
		PotionInfoNtf bloodBottleNtf = message as PotionInfoNtf;
		G.localPlayer.ApplyChanges(bloodBottleNtf, reset);
	}

	private void OnQNComplatedNtf(IMessage message, bool reset)
	{
		QuestionnaireNtf ntf = message as QuestionnaireNtf;
		if (!Model<QuestionnaireModel>.HasInstance())
		{
			Model<QuestionnaireModel>.CreateModel();
		}
		Model<QuestionnaireModel>.Interface.MergeQuestionnaireInfo(ntf);
	}

	private void OnRogueInfoNtf(IMessage message, bool reset)
	{
		RogueInfoNtf rogueInfoNtf = message as RogueInfoNtf;
		if (!Model<RogueNewModel>.HasInstance())
		{
			Model<RogueNewModel>.CreateModel();
		}
		Model<RogueNewModel>.Interface.RogueInfo(rogueInfoNtf);
	}

	private void OnRogueTalentTreeUpgradeNtf(IMessage message, bool reset)
	{
		RogueTalentTreeNtf rogueTalentTreeNtf = message as RogueTalentTreeNtf;
		Model<RogueNewModel>.Interface.TalentNodeUpgradeNtf(rogueTalentTreeNtf);
	}

	private void OnRogueCoinNtf(IMessage message, bool reset)
	{
		RogueCoinNtf rogueCoinNtf = message as RogueCoinNtf;
		if (Model<RogueNewModel>.HasInstance())
		{
			Model<RogueNewModel>.Interface.RogueCoinInfo(rogueCoinNtf);
		}
	}

	private void OnContactNtf(IMessage message, bool reset)
	{
		if (message is ContactNtf contactNtf)
		{
			if (!Model<SNSModel>.HasInstance())
			{
				Model<SNSModel>.CreateModel();
			}
			Model<SNSModel>.Interface.OnReceiveContactNtf(contactNtf.Contact);
		}
	}

	private void OnContactCharacterSessionNtf(IMessage message, bool reset)
	{
		if (message is ContactCharacterSessionNtf contactCharacterSessionNtf)
		{
			if (!Model<SNSModel>.HasInstance())
			{
				Model<SNSModel>.CreateModel();
			}
			Model<SNSModel>.Interface.OnNewTriggerSession(contactCharacterSessionNtf.Sessions, contactCharacterSessionNtf.GmMode);
		}
	}

	private void OnContactCharacterMessageNtf(IMessage message, bool reset)
	{
		if (message is ContactCharacterMessageNtf contactCharacterMessageNtf)
		{
			Model<SNSModel>.Interface.OnContinueSession(contactCharacterMessageNtf.SessionId, contactCharacterMessageNtf.NewMessagesInt64, contactCharacterMessageNtf.SessionFinish, contactCharacterMessageNtf.UpdateTimeStamp);
		}
	}

	private void OnGachaPoolDataNtf(IMessage message, bool reset)
	{
		if (message is GachaPoolDataNtf info)
		{
			if (!Model<CardDrawModel>.HasInstance())
			{
				Model<CardDrawModel>.CreateModel();
			}
			Model<CardDrawModel>.Interface.InitGachaInfo(info);
		}
	}

	private void OnGachaPoolShareDataChangeNtf(IMessage message, bool reset)
	{
		if (message is GachaPoolShareDataChangeNtf info)
		{
			Model<CardDrawModel>.Interface.UpdateGachaInfo(info);
		}
	}

	private void OnGachaPoolTimeNtf(IMessage message, bool reset)
	{
		if (message is GachaPoolEffectiveInfoNtf info)
		{
			Model<CardDrawModel>.Interface.UpdateGachaTimeInfo(info);
			if (Model<FacePushModel>.HasInstance())
			{
				Model<FacePushModel>.Interface.RequestCheck();
			}
		}
	}

	private void OnActivityCombinationNtf(IMessage message, bool reset)
	{
		if (message is ActivityCombinationNtf ntf)
		{
			if (!Model<ActivityExploreChallengeModel>.HasInstance())
			{
				Model<ActivityExploreChallengeModel>.CreateModel();
			}
			Model<ActivityExploreChallengeModel>.Interface.HandleServerData(ntf);
			Model<ActivityExploreChallengeModel>.Interface.InitTaskData();
		}
	}

	private void OnActivityMainStoryNtf(IMessage message, bool reset)
	{
		if (message is ActivityMainStoryNtf activityMainStoryNtf)
		{
			if (!Model<ActivityCenterModel>.HasInstance())
			{
				Model<ActivityCenterModel>.CreateModel();
			}
			Model<ActivityCenterModel>.Interface.UpdateActivityMainStoryInfo(activityMainStoryNtf);
		}
	}

	private void OnActivityMapExploreNtf(IMessage message, bool reset)
	{
		if (message is ActivityMapExploreNtf activityMapExploreNtf)
		{
			if (!Model<ActivityCenterModel>.HasInstance())
			{
				Model<ActivityCenterModel>.CreateModel();
			}
			Model<ActivityCenterModel>.Interface.UpdateActivityMapExploreInfo(activityMapExploreNtf);
		}
	}

	private void OnActivityMultiDeviceNtf(IMessage message, bool reset)
	{
		if (message is ActivityMultiDeviceNtf activityMultiDeviceNtf)
		{
			if (!Model<ActivityCenterModel>.HasInstance())
			{
				Model<ActivityCenterModel>.CreateModel();
			}
			Model<ActivityCenterModel>.Interface.UpdateActivityMultiDeviceInfo(activityMultiDeviceNtf);
		}
	}

	private void OnOperationalActivityDataNtf(IMessage message, bool reset)
	{
		if (message is OperationalActivityDataNtf operationalActivityDataNtf)
		{
			if (!Model<ActivityCenterModel>.HasInstance())
			{
				Model<ActivityCenterModel>.CreateModel();
			}
			if (!Model<ActivityExploreChallengeModel>.HasInstance())
			{
				Model<ActivityExploreChallengeModel>.CreateModel();
			}
			Model<ActivityExploreChallengeModel>.Interface.HandleServerData(operationalActivityDataNtf);
			Model<ActivityCenterModel>.Interface.UpdateOperationalActivityInfo(operationalActivityDataNtf);
		}
	}

	private void OnActivitySignInNtf(IMessage message, bool reset)
	{
		if (message is ActivitySignInNtf activitySignInNtf)
		{
			if (!Model<ActivityCenterModel>.HasInstance())
			{
				Model<ActivityCenterModel>.CreateModel();
			}
			Model<ActivityCenterModel>.Interface.UpdateActivitySignInInfo(activitySignInNtf.ActivitSignInInfo);
		}
	}

	private void OnActivityTempleChallengeNtf(IMessage message, bool reset)
	{
		if (message is ActivityTempleChallengeNtf activityTempleChallengeNtf)
		{
			if (!Model<ActivityCenterModel>.HasInstance())
			{
				Model<ActivityCenterModel>.CreateModel();
			}
			Model<ActivityCenterModel>.Interface.UpdateActivityTempleChallengeInInfo(activityTempleChallengeNtf.ActivitTempleChallengeInfo);
			if (!Model<ActivityTempleChallengeModel>.HasInstance())
			{
				Model<ActivityTempleChallengeModel>.CreateModel();
			}
		}
	}

	private void OnActivityAbyssNtf(IMessage message, bool reset)
	{
		if (message is ActivityAbyssNtf activityAbyssNtf)
		{
			if (!Model<ActivityCenterModel>.HasInstance())
			{
				Model<ActivityCenterModel>.CreateModel();
			}
			Model<ActivityCenterModel>.Interface.UpdateActivityAbyssInfo(activityAbyssNtf);
		}
	}

	private void OnActivityRoleTrialNtf(IMessage message, bool reset)
	{
		if (message is ActivityRoleTrialNtf activityRoleTrialNtf)
		{
			if (!Model<ActivityCenterModel>.HasInstance())
			{
				Model<ActivityCenterModel>.CreateModel();
			}
			Model<ActivityCenterModel>.Interface.UpdateActivityRoleTrialInfo(activityRoleTrialNtf);
		}
	}

	private void OnActivityDailyLotteryNtf(IMessage message, bool reset)
	{
		if (message is ActivityDailyLotteryNtf activityDailyLotteryNtf)
		{
			if (!Model<ActivityCenterModel>.HasInstance())
			{
				Model<ActivityCenterModel>.CreateModel();
			}
			Model<ActivityCenterModel>.Interface.UpdateActivityLotteryInfo(activityDailyLotteryNtf);
		}
	}

	private void OnActivityKujiNtf(IMessage message, bool reset)
	{
		if (message is ActivityKujiNtf activityKujiNtf)
		{
			if (!Model<ActivityCenterModel>.HasInstance())
			{
				Model<ActivityCenterModel>.CreateModel();
			}
			Model<ActivityCenterModel>.Interface.UpdateActivityKujiInfo(activityKujiNtf);
		}
	}

	private void OnTreasureInfoNtf(IMessage message, bool reset)
	{
		if (message is TreasureInfoNtf treasureInfoNtf)
		{
			if (!Model<TreasureModel>.HasInstance())
			{
				Model<TreasureModel>.CreateModel();
				Model<TreasureModel>.Interface.OnReceiveTreasureInfoNtf(treasureInfoNtf.TreasureInfo);
			}
			else
			{
				Model<TreasureModel>.Interface.OnReceiveNewTreasureInfoNtf(treasureInfoNtf.TreasureInfo);
			}
			Model<TreasureModel>.Interface.CalculateTreasuresAttrBonus();
			TreasureEvent evt = Singleton<EventManager>.instance.GetEvt<TreasureEvent>();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.TreasureAdd, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	private void OnClientModuleNtf(IMessage message, bool reset)
	{
		if (!Model<ClientModuleModel>.HasInstance())
		{
			Model<ClientModuleModel>.CreateModel();
		}
		foreach (KeyValuePair<int, ClientComponentState> component in (message as ClientModuleComponentStateNtf).Components)
		{
			ClientModuleModel.ClientModuleEnum key = (ClientModuleModel.ClientModuleEnum)component.Key;
			foreach (KeyValuePair<int, bool> state in component.Value.States)
			{
				((IClientModuleModelNtfCall)Model<ClientModuleModel>.Interface).SetModuleState(key, state.Key, state.Value);
			}
		}
	}

	private void OnClientModuleUpdateNtf(IMessage message, bool reset)
	{
		if (!Model<ClientModuleModel>.HasInstance())
		{
			Model<ClientModuleModel>.CreateModel();
		}
		foreach (KeyValuePair<int, ClientComponentState> component in (message as ClientModuleClientModuleComponentStateChangeNtf).Components)
		{
			ClientModuleModel.ClientModuleEnum key = (ClientModuleModel.ClientModuleEnum)component.Key;
			foreach (KeyValuePair<int, bool> state in component.Value.States)
			{
				((IClientModuleModelNtfCall)Model<ClientModuleModel>.Interface).SetModuleState(key, state.Key, state.Value);
			}
		}
	}

	private void OnTipsNtf(IMessage message, bool reset)
	{
		if (message is TipsNtf tipsNtf)
		{
			Model<InventoryModel>.Interface.InvetoryTipsNtfHandle(tipsNtf);
		}
	}

	private void OnSkinAddNtf(IMessage message, bool reset)
	{
		if (message is SkinAddNtf skinAddNtf)
		{
			if (!Model<ShopModel>.HasInstance())
			{
				Model<ShopModel>.CreateModel();
			}
			Model<ShopModel>.Interface.SkinData.AddRange(skinAddNtf.Skins);
			Model<ShopModel>.Interface.OnShopDataUpdate?.Invoke();
			Model<SkinModel>.Interface.AddSkin(skinAddNtf);
		}
	}

	private void OnSkinSyncNtf(IMessage message, bool reset)
	{
		if (message is SkinSyncNtf skinSyncNtf)
		{
			if (!Model<ShopModel>.HasInstance())
			{
				Model<ShopModel>.CreateModel();
			}
			Model<ShopModel>.Interface.SkinData.AddRange(skinSyncNtf.Skins);
			if (!Model<SkinModel>.HasInstance())
			{
				Model<SkinModel>.CreateModel();
			}
			Model<SkinModel>.Interface.OnSkinInfoNtf(skinSyncNtf);
		}
	}

	private void OnEffectDressAddNtf(IMessage message, bool reset)
	{
		if (message is EffectDressAddNtf addNtf)
		{
			if (!Model<SkinModel>.HasInstance())
			{
				Model<SkinModel>.CreateModel();
			}
			Model<SkinModel>.Interface.AddEffectDress(addNtf);
		}
	}

	private void OnEffectDressSyncNtf(IMessage message, bool reset)
	{
		if (message is EffectDressSyncNtf syncNtf)
		{
			if (!Model<SkinModel>.HasInstance())
			{
				Model<SkinModel>.CreateModel();
			}
			Model<SkinModel>.Interface.OnEffectDressSyncNtf(syncNtf);
		}
	}

	private void OnItemDestroyedNtf(IMessage message, bool reset)
	{
		if (!(message is ItemDestroyedNtf itemDestroyedNtf))
		{
			return;
		}
		foreach (ItemDestroyedEntry item in itemDestroyedNtf.Items)
		{
			if (RuntimeConfigs.data.itemDatas.TryGetValue(item.ItemId, out var value))
			{
				string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value.nameLocal);
				IList<object> list = new List<object>();
				list.Add(localizeString);
				string localizeString2 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2528, list);
				Model<InventoryModel>.Interface.AddLimitItemTips(localizeString2);
			}
		}
	}

	private void OnExpiredTimeLimitItemAutoUseNtf(IMessage message, bool reset)
	{
		if (!(message is ExpiredTimeLimitItemAutoUseNtf expiredTimeLimitItemAutoUseNtf))
		{
			return;
		}
		foreach (ExpiredTimeLimitItemAutoUseEntry item in expiredTimeLimitItemAutoUseNtf.Items)
		{
			if (RuntimeConfigs.data.itemDatas.TryGetValue(item.ItemId, out var value))
			{
				string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value.nameLocal);
				IList<object> list = new List<object>();
				list.Add(localizeString);
				string localizeString2 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2683, list);
				Model<InventoryModel>.Interface.AddLimitItemTips(localizeString2);
			}
		}
	}

	private void OnActivitySkinTrialNtf(IMessage message, bool reset)
	{
		if (message is ActivitySkinTrialNtf activitySkinTrialNtf)
		{
			Model<ActivityCenterModel>.Interface.UpdateActivitySkinTrialInfo(activitySkinTrialNtf.ActivitSkinTrialInfo);
		}
	}

	private void OnActivityTotalRechargeNtf(IMessage message, bool reset)
	{
		if (message is ActivityTotalRechargeNtf activityTotalRechargeNtf)
		{
			Model<ActivityCenterModel>.Interface.UpdateActivityTotalRechargeInfo(activityTotalRechargeNtf.ActivityTotalRechargeInfo);
		}
	}

	private void OnUseSelfSelectGiftPackage(IMessage message, bool reset)
	{
		if (message is BagChestRewardSelectCountNtf newData)
		{
			if (!Model<GiftPackageModel>.HasInstance())
			{
				Model<GiftPackageModel>.CreateModel();
			}
			Model<GiftPackageModel>.Interface.RefreshSelfSelectGiftPackageUseData(newData);
		}
	}
}
