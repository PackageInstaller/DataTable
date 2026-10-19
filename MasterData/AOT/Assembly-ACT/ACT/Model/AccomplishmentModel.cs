using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI;
using ACT.Utility;
using ACT.World;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Pb;
using Runtime.WaitSort;
using UnityEngine;

namespace ACT.Model;

public class AccomplishmentModel : Model<AccomplishmentModel>
{
	private static readonly HashSet<string> StaticAccomplishmentRedDotLeafPaths = new HashSet<string>
	{
		RedDotPathDefine.NewAccomplishmentTaskTab,
		RedDotPathDefine.NewAccomplishmentExploreTab,
		RedDotPathDefine.NewAccomplishmentBattleTab,
		RedDotPathDefine.NewAccomplishmentCultivateTab,
		RedDotPathDefine.NewAccomplishmentOtherTab
	};

	private static readonly string[] LegacyAccomplishmentGroupRootPaths = new string[5]
	{
		RedDotPathDefine.NewAccomplishmentTaskTab + "|GroupId",
		RedDotPathDefine.NewAccomplishmentExploreTab + "|GroupId",
		RedDotPathDefine.NewAccomplishmentBattleTab + "|GroupId",
		RedDotPathDefine.NewAccomplishmentCultivateTab + "|GroupId",
		RedDotPathDefine.NewAccomplishmentOtherTab + "|GroupId"
	};

	private static readonly Dictionary<SyncBattleDataType, Action<AchievementSyncInfo, int, int>> AchievementSyncInfoSetters = new Dictionary<SyncBattleDataType, Action<AchievementSyncInfo, int, int>>
	{
		{
			SyncBattleDataType.FightTypeCount,
			(AchievementSyncInfo info, int id, int count) =>
			{
				info.FightTypeCntInfo[id] = count;
			}
		},
		{
			SyncBattleDataType.BossKillTime,
			(AchievementSyncInfo info, int id, int count) =>
			{
				info.BossKillTime[id] = count;
			}
		},
		{
			SyncBattleDataType.UseSkill,
			(AchievementSyncInfo info, int id, int count) =>
			{
				info.UseSkillCount[id] = count;
			}
		},
		{
			SyncBattleDataType.CharacterDieOnOneHit,
			(AchievementSyncInfo info, int id, int count) =>
			{
				info.CharacterDieOnOneHit[id] = count;
			}
		},
		{
			SyncBattleDataType.DamageTypeDieOnOneHit,
			(AchievementSyncInfo info, int id, int count) =>
			{
				info.DamageTypeDieOnOneHit[id] = count;
			}
		},
		{
			SyncBattleDataType.CharacterKillMonsterInAirCount,
			(AchievementSyncInfo info, int id, int count) =>
			{
				info.CharacterKillMonsterInAirCount[id] = count;
			}
		},
		{
			SyncBattleDataType.PlayerDeadByMonsterPointID,
			(AchievementSyncInfo info, int id, int count) =>
			{
				info.PlayerDeadByMonsterPointID[id] = count;
			}
		},
		{
			SyncBattleDataType.DamageAccumulateByType,
			(AchievementSyncInfo info, int id, int count) =>
			{
				info.DamageAccumulateByType[id] = count;
			}
		},
		{
			SyncBattleDataType.DamageOnceMaximumByType,
			(AchievementSyncInfo info, int id, int count) =>
			{
				info.DamageOnceMaximumByType[id] = count;
			}
		},
		{
			SyncBattleDataType.InteractedNPCS,
			(AchievementSyncInfo info, int id, int count) =>
			{
				info.InteractedNPCs.Add(id);
			}
		}
	};

	private readonly Dictionary<int, int[]> _groupMilestoneRewardCollectionId = new Dictionary<int, int[]>();

	private readonly List<int> _mainIdsOrdered = new List<int>();

	private readonly Dictionary<int, List<int>> _groupsByMain = new Dictionary<int, List<int>>();

	private readonly Dictionary<int, List<int>> _contentIdsByGroup = new Dictionary<int, List<int>>();

	private readonly Dictionary<int, AchievementContents> _contentById = new Dictionary<int, AchievementContents>();

	private readonly Dictionary<int, int> _contentIdByPreconditionId = new Dictionary<int, int>();

	private readonly Dictionary<int, int> _contentIdByUnlockPreconditionId = new Dictionary<int, int>();

	private readonly HashSet<int> _achievementRelatedTaskIds = new HashSet<int>();

	private readonly Dictionary<int, AchievementContents> _battleAccomplishmentIds = new Dictionary<int, AchievementContents>();

	private readonly List<int[]> _battleMissionCParams = new List<int[]>();

	private bool _battleMissionCParamsCached;

	private readonly Dictionary<int, int> _lastAchievementTaskStatusByPreconditionId = new Dictionary<int, int>();

	private readonly Queue<int> _achievementToastQueue = new Queue<int>();

	private bool _isProcessingAchievementToastQueue;

	private const int AchievementToastIntervalMs = 2000;

	private const int OpenAllChestInLargeAreaPreconditionId = 114;

	private const int OpenAllChestInAreaPreconditionId = 115;

	public IReadOnlyList<int> OrderedMainIds => _mainIdsOrdered;

	protected override void Init()
	{
		Singleton<AchievementSyncBattleTypeManager>.CreateInstance();
		InitStaticData();
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction += InstanceOnTaskProgressChangeAction;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AddBehaveCount, UpdateAchievementType);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, OnSystemOpen);
		RefreshAccomplishmentRedDot();
	}

	protected override void UnInit()
	{
		Singleton<AchievementSyncBattleTypeManager>.DestroyInstance();
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction -= InstanceOnTaskProgressChangeAction;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AddBehaveCount, UpdateAchievementType);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, OnSystemOpen);
		_lastAchievementTaskStatusByPreconditionId.Clear();
		_achievementToastQueue.Clear();
		_isProcessingAchievementToastQueue = false;
		_battleAccomplishmentIds.Clear();
	}

	protected override void OnDestroy()
	{
	}

	private void InstanceOnTaskProgressChangeAction(int taskId, ACT.Battle.TaskInfo taskInfo, bool isNew)
	{
		if (Singleton<SystemBlockManager>.instance.IsBlocked(SystemType.Achievement))
		{
			return;
		}
		bool flag = _contentIdByPreconditionId.TryGetValue(taskId, out var value);
		bool flag2 = _contentIdByUnlockPreconditionId.ContainsKey(taskId);
		if (!flag && !flag2 && !_achievementRelatedTaskIds.Contains(taskId))
		{
			return;
		}
		RefreshAccomplishmentRedDot();
		if (!flag)
		{
			if (Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(taskId))
			{
				NotifyDataChanged();
			}
			return;
		}
		int value2 = -1;
		_lastAchievementTaskStatusByPreconditionId.TryGetValue(taskId, out value2);
		_lastAchievementTaskStatusByPreconditionId[taskId] = taskInfo.status;
		NotifyDataChanged();
		if (!isNew)
		{
			int num = 1;
			if (taskInfo.status == num && value2 == 0)
			{
				ShowAchievementHudTips(value);
			}
		}
	}

	private void OnSystemOpen(BaseEventContent obj)
	{
		if (obj is SystemOpenEvt { unLock: not false, systemId: 1049 })
		{
			RefreshAccomplishmentRedDot();
		}
	}

	private void RefreshAccomplishmentRedDot()
	{
		ResetDynamicAccomplishmentRedDotLeaves();
		if (!CanRefreshAccomplishmentRedDot())
		{
			SetAccomplishmentRedDotActive(active: false);
		}
		else if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(1049))
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.NewAccomplishmentTaskTab, MainHasClaimable(1));
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.NewAccomplishmentExploreTab, MainHasClaimable(2));
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.NewAccomplishmentBattleTab, MainHasClaimable(3));
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.NewAccomplishmentCultivateTab, MainHasClaimable(4));
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.NewAccomplishmentOtherTab, MainHasClaimable(5));
		}
		else
		{
			SetAccomplishmentRedDotActive(active: false);
		}
	}

	private static void ResetDynamicAccomplishmentRedDotLeaves()
	{
		if (!Singleton<RedDotManager>.HasInstance())
		{
			return;
		}
		RemoveLegacyGroupNodesUnderTabLeaves();
		RedDotTrieNode node = Singleton<RedDotManager>.instance.GetNode(RedDotPathDefine.NewAccomplishment);
		if (node == null || node.childNodeDic == null || node.childNodeDic.Count == 0)
		{
			return;
		}
		Stack<RedDotTrieNode> stack = new Stack<RedDotTrieNode>();
		foreach (RedDotTrieNode value in node.childNodeDic.Values)
		{
			stack.Push(value);
		}
		while (stack.Count > 0)
		{
			RedDotTrieNode redDotTrieNode = stack.Pop();
			if (redDotTrieNode == null)
			{
				continue;
			}
			if (redDotTrieNode.isLeaf)
			{
				if (redDotTrieNode.isActive && !StaticAccomplishmentRedDotLeafPaths.Contains(redDotTrieNode.CompletePath))
				{
					Singleton<RedDotManager>.instance.SetLeafNodeActive(redDotTrieNode.CompletePath, active: false);
				}
				continue;
			}
			foreach (RedDotTrieNode value2 in redDotTrieNode.childNodeDic.Values)
			{
				stack.Push(value2);
			}
		}
	}

	private static void RemoveLegacyGroupNodesUnderTabLeaves()
	{
		string[] legacyAccomplishmentGroupRootPaths = LegacyAccomplishmentGroupRootPaths;
		foreach (string nodeFullPath in legacyAccomplishmentGroupRootPaths)
		{
			if (Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath))
			{
				Singleton<RedDotManager>.instance.RemoveNode(nodeFullPath);
			}
		}
	}

	private static bool CanRefreshAccomplishmentRedDot()
	{
		if (Singleton<RedDotManager>.HasInstance())
		{
			return G.localPlayer?.Achievements?.ProgressData?.AchievementsProgress != null;
		}
		return false;
	}

	private void SetAccomplishmentRedDotActive(bool active)
	{
		if (Singleton<RedDotManager>.HasInstance())
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.NewAccomplishmentTaskTab, active);
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.NewAccomplishmentExploreTab, active);
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.NewAccomplishmentBattleTab, active);
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.NewAccomplishmentCultivateTab, active);
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.NewAccomplishmentOtherTab, active);
		}
	}

	public void InitStaticData()
	{
		_mainIdsOrdered.Clear();
		_groupsByMain.Clear();
		_contentIdsByGroup.Clear();
		_contentById.Clear();
		_contentIdByPreconditionId.Clear();
		_contentIdByUnlockPreconditionId.Clear();
		_achievementRelatedTaskIds.Clear();
		_battleAccomplishmentIds.Clear();
		_battleMissionCParams.Clear();
		_battleMissionCParamsCached = false;
		Dictionary<int, AchievementMain> achievementMains = RuntimeConfigs.data.achievementMains;
		if (achievementMains == null || achievementMains.Count == 0)
		{
			return;
		}
		foreach (int key in achievementMains.Keys)
		{
			_mainIdsOrdered.Add(key);
		}
		_mainIdsOrdered.Sort(CompareMainIdBySortDesc);
		Dictionary<int, AchievementGroup> achievementGroups = RuntimeConfigs.data.achievementGroups;
		if (achievementGroups == null || achievementGroups.Count == 0)
		{
			return;
		}
		foreach (AchievementGroup value4 in achievementGroups.Values)
		{
			if (!_groupsByMain.TryGetValue(value4.typeID, out var value))
			{
				value = new List<int>();
				_groupsByMain[value4.typeID] = value;
			}
			value.Add(value4.id);
		}
		foreach (List<int> value5 in _groupsByMain.Values)
		{
			value5.Sort(CompareGroupIdBySortDesc);
		}
		RebuildGroupMilestoneRewardMap();
		Dictionary<int, AchievementContents> achievementContentss = RuntimeConfigs.data.achievementContentss;
		if (achievementContentss == null || achievementContentss.Count == 0)
		{
			return;
		}
		foreach (KeyValuePair<int, AchievementGroup> item in achievementGroups)
		{
			AchievementGroup value2 = item.Value;
			List<int> value3 = ResolveContentIdsForGroup(value2);
			_contentIdsByGroup[value2.id] = value3;
		}
		foreach (AchievementContents value6 in achievementContentss.Values)
		{
			_contentById[value6.id] = value6;
			if (value6.preconditionID != 0 && !_contentIdByPreconditionId.ContainsKey(value6.preconditionID))
			{
				_contentIdByPreconditionId[value6.preconditionID] = value6.id;
			}
			IndexAchievementTaskIds(value6.preconditionID);
			if (value6.unlockPreconditionID != 0 && !_contentIdByUnlockPreconditionId.ContainsKey(value6.unlockPreconditionID))
			{
				_contentIdByUnlockPreconditionId[value6.unlockPreconditionID] = value6.id;
			}
			IndexAchievementTaskIds(value6.unlockPreconditionID);
		}
	}

	private void IndexAchievementTaskIds(int preconditionId)
	{
		if (preconditionId == 0)
		{
			return;
		}
		_achievementRelatedTaskIds.Add(preconditionId);
		Dictionary<int, MissionGroup> missionGroups = RuntimeConfigs.data.missionGroups;
		if (missionGroups == null || !missionGroups.TryGetValue(preconditionId, out var value) || value.missionId == null)
		{
			return;
		}
		for (int i = 0; i < value.missionId.Length; i++)
		{
			int num = value.missionId[i];
			if (num != 0)
			{
				_achievementRelatedTaskIds.Add(num);
			}
		}
	}

	private void RebuildGroupMilestoneRewardMap()
	{
		_groupMilestoneRewardCollectionId.Clear();
		foreach (KeyValuePair<int, AchievementGroup> achievementGroup in RuntimeConfigs.data.achievementGroups)
		{
			int key = achievementGroup.Key;
			int[] collectionId = achievementGroup.Value.collectionId;
			if (collectionId.Length != 0)
			{
				_groupMilestoneRewardCollectionId[key] = collectionId;
			}
		}
	}

	private List<int> ResolveContentIdsForGroup(AchievementGroup group)
	{
		Dictionary<int, AchievementContents> achievementContentss = RuntimeConfigs.data.achievementContentss;
		List<int> list = new List<int>();
		foreach (AchievementContents value in achievementContentss.Values)
		{
			if (value.groupID == group.id)
			{
				list.Add(value.id);
			}
		}
		list.Sort(CompareContentIdByGroupSort);
		return list;
	}

	public List<int> GetGroupIdsForMain(int mainId)
	{
		if (!_groupsByMain.TryGetValue(mainId, out var value))
		{
			return new List<int>();
		}
		return value;
	}

	public List<int> GetContentIdsForGroup(int groupId)
	{
		if (!_contentIdsByGroup.TryGetValue(groupId, out var value))
		{
			return new List<int>();
		}
		return value;
	}

	private int CompareMainIdBySortDesc(int leftMainId, int rightMainId)
	{
		Dictionary<int, AchievementMain> achievementMains = RuntimeConfigs.data.achievementMains;
		int num = (achievementMains.TryGetValue(leftMainId, out var value) ? value.sort : 0);
		int num2 = (achievementMains.TryGetValue(rightMainId, out var value2) ? value2.sort : 0);
		if (num != num2)
		{
			return num2.CompareTo(num);
		}
		return leftMainId.CompareTo(rightMainId);
	}

	private int CompareGroupIdBySortDesc(int leftGroupId, int rightGroupId)
	{
		Dictionary<int, AchievementGroup> achievementGroups = RuntimeConfigs.data.achievementGroups;
		int num = (achievementGroups.TryGetValue(leftGroupId, out var value) ? value.sort : 0);
		int num2 = (achievementGroups.TryGetValue(rightGroupId, out var value2) ? value2.sort : 0);
		if (num != num2)
		{
			return num2.CompareTo(num);
		}
		return leftGroupId.CompareTo(rightGroupId);
	}

	private int CompareContentIdByGroupSort(int leftContentId, int rightContentId)
	{
		Dictionary<int, AchievementContents> achievementContentss = RuntimeConfigs.data.achievementContentss;
		int num = (achievementContentss.TryGetValue(leftContentId, out var value) ? value.groupSort : 0);
		int num2 = (achievementContentss.TryGetValue(rightContentId, out var value2) ? value2.groupSort : 0);
		if (num != num2)
		{
			return num.CompareTo(num2);
		}
		return leftContentId.CompareTo(rightContentId);
	}

	public bool TryGetContent(int contentId, out AchievementContents content)
	{
		return _contentById.TryGetValue(contentId, out content);
	}

	public bool TryGetGroup(int groupId, out AchievementGroup group)
	{
		group = null;
		return RuntimeConfigs.data.achievementGroups.TryGetValue(groupId, out group);
	}

	public bool TryGetMain(int mainId, out AchievementMain main)
	{
		main = null;
		return RuntimeConfigs.data.achievementMains.TryGetValue(mainId, out main);
	}

	public bool IsContentReached(int contentId)
	{
		if (!TryGetContent(contentId, out var content))
		{
			return false;
		}
		if (!TryGetProgress(contentId, out var prog) || prog.CompleteTS == 0)
		{
			return false;
		}
		if (!HasReward(content))
		{
			return false;
		}
		return !prog.HasTakenReward;
	}

	public bool IsContentClaimed(int contentId)
	{
		if (!TryGetProgress(contentId, out var prog) || prog.CompleteTS == 0)
		{
			return false;
		}
		return prog.HasTakenReward;
	}

	public bool IsContentCompleted(int contentId)
	{
		if (!TryGetContent(contentId, out var content))
		{
			return false;
		}
		if (TryGetProgress(contentId, out var prog) && prog != null && prog.CompleteTS > 0)
		{
			return true;
		}
		return Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(content.preconditionID);
	}

	public bool IsContentVisible(int contentId)
	{
		if (!TryGetContent(contentId, out var content))
		{
			return false;
		}
		if (!IsContentDisplayUnlocked(content))
		{
			return false;
		}
		if (content.type == 1)
		{
			return IsContentCompleted(contentId);
		}
		return true;
	}

	private bool IsContentDisplayUnlocked(AchievementContents content)
	{
		if (content.unlockPreconditionID != 0 && !Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(content.unlockPreconditionID))
		{
			return false;
		}
		if (content.unlockID != 0)
		{
			return IsContentClaimed(content.unlockID);
		}
		return true;
	}

	public List<int> GetVisibleContentIdsForGroup(int groupId)
	{
		List<int> contentIdsForGroup = GetContentIdsForGroup(groupId);
		if (contentIdsForGroup == null || contentIdsForGroup.Count == 0)
		{
			return contentIdsForGroup;
		}
		List<int> list = new List<int>(contentIdsForGroup.Count);
		foreach (int item in contentIdsForGroup)
		{
			if (IsContentVisible(item))
			{
				list.Add(item);
			}
		}
		return list;
	}

	public AccomplishmentRowState GetRowState(int contentId)
	{
		if (!TryGetContent(contentId, out var content))
		{
			return AccomplishmentRowState.InProgress;
		}
		if (!IsContentCompleted(contentId))
		{
			return AccomplishmentRowState.InProgress;
		}
		if (!HasReward(content))
		{
			return AccomplishmentRowState.Claimed;
		}
		if (!IsContentClaimed(contentId))
		{
			return AccomplishmentRowState.Claimable;
		}
		return AccomplishmentRowState.Claimed;
	}

	public bool HasReward(AchievementContents c)
	{
		if (c.achievementsRewards != null && c.achievementsRewards.Count > 0)
		{
			return c.achievementsRewards[0].id != 0;
		}
		return false;
	}

	public string GetMainPercent(int mainId)
	{
		int num = 0;
		int num2 = 0;
		foreach (int item in GetGroupIdsForMain(mainId))
		{
			foreach (int item2 in GetContentIdsForGroup(item))
			{
				if (IsContentVisible(item2))
				{
					num++;
					if (IsContentCompleted(item2))
					{
						num2++;
					}
				}
			}
		}
		if (num == 0)
		{
			return "0%";
		}
		return GameUtility.TopercentageNoSpace((float)num2 / (float)num, 0);
	}

	public string GetGroupPercent(int groupId)
	{
		int num = 0;
		int num2 = 0;
		foreach (int item in GetContentIdsForGroup(groupId))
		{
			if (IsContentVisible(item))
			{
				num++;
				if (IsContentCompleted(item))
				{
					num2++;
				}
			}
		}
		if (num == 0)
		{
			return "0%";
		}
		return GameUtility.TopercentageNoSpace((float)num2 / (float)num, 0);
	}

	public int GetTotalReachedCount()
	{
		int num = 0;
		foreach (int key in _contentById.Keys)
		{
			if (IsContentVisible(key) && IsContentCompleted(key))
			{
				num++;
			}
		}
		return num;
	}

	public (int gold, int silver, int bronze) GetRarityReachedCounts()
	{
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		foreach (KeyValuePair<int, AchievementContents> item in _contentById)
		{
			if (!IsContentVisible(item.Key) || !IsContentCompleted(item.Key))
			{
				continue;
			}
			int level = item.Value.level;
			if (level < 3)
			{
				if (level == 2)
				{
					num2++;
				}
				else
				{
					num3++;
				}
			}
			else
			{
				num++;
			}
		}
		return (gold: num, silver: num2, bronze: num3);
	}

	public List<int> GetRecentReachedContentIds(int max = 4)
	{
		MapField<int, AchievementProgress> map = G.localPlayer.Achievements.ProgressData.AchievementsProgress;
		if (map == null)
		{
			return new List<int>();
		}
		List<int> list = new List<int>();
		foreach (int key in _contentById.Keys)
		{
			if (IsContentVisible(key) && map.TryGetValue(key, out var value) && value.CompleteTS > 0)
			{
				list.Add(key);
			}
		}
		list.Sort((int a, int b) => map[b].CompleteTS.CompareTo(map[a].CompleteTS));
		List<int> list2 = new List<int>((list.Count < max) ? list.Count : max);
		for (int num = 0; num < list.Count && num < max; num++)
		{
			list2.Add(list[num]);
		}
		return list2;
	}

	public bool MainHasClaimable(int mainId)
	{
		foreach (int item in GetGroupIdsForMain(mainId))
		{
			if (GroupHasClaimable(item))
			{
				return true;
			}
		}
		return false;
	}

	public bool GroupHasClaimable(int groupId)
	{
		if (GroupHasClaimableContentReward(groupId))
		{
			return true;
		}
		if (TryGetGroupMilestoneCollectionId(groupId, out var _) && IsGroupMilestoneClaimable(groupId))
		{
			return true;
		}
		return false;
	}

	private bool GroupHasClaimableContentReward(int groupId)
	{
		foreach (int item in GetContentIdsForGroup(groupId))
		{
			if (IsContentVisible(item) && GetRowState(item) == AccomplishmentRowState.Claimable)
			{
				return true;
			}
		}
		return false;
	}

	public bool TryGetGroupMilestoneCollectionId(int groupId, out int[] collectionId)
	{
		if (_groupMilestoneRewardCollectionId.TryGetValue(groupId, out collectionId))
		{
			return collectionId.Length != 0;
		}
		return false;
	}

	public bool IsGroupMilestoneReached(int groupId)
	{
		int num = 0;
		int num2 = 0;
		foreach (int item in GetContentIdsForGroup(groupId))
		{
			if (IsContentVisible(item) && !IsConcealAchievement(item))
			{
				num++;
				if (!IsContentCompleted(item))
				{
					return false;
				}
				num2++;
			}
		}
		if (num == 0)
		{
			return false;
		}
		return num == num2;
	}

	public bool IsGroupMilestoneTaken(int groupId)
	{
		MapField<int, bool> mapField = G.localPlayer?.Achievements?.ProgressData?.TookAchievementGroupRewards;
		if (mapField == null || mapField.Count == 0)
		{
			return false;
		}
		bool value;
		return mapField.TryGetValue(groupId, out value) & value;
	}

	public bool IsGroupMilestoneClaimable(int groupId)
	{
		if (TryGetGroupMilestoneCollectionId(groupId, out var _) && IsGroupMilestoneReached(groupId))
		{
			return !IsGroupMilestoneTaken(groupId);
		}
		return false;
	}

	public string GetGroupMilestonePercent(int groupId)
	{
		return GetGroupPercent(groupId);
	}

	public float GetGroupPercentValue(int groupId)
	{
		List<int> contentIdsForGroup = GetContentIdsForGroup(groupId);
		if (contentIdsForGroup.Count == 0)
		{
			return 0f;
		}
		int num = 0;
		int num2 = 0;
		foreach (int item in contentIdsForGroup)
		{
			if (IsContentVisible(item))
			{
				num2++;
				if (IsContentCompleted(item))
				{
					num++;
				}
			}
		}
		if (num2 == 0)
		{
			return 0f;
		}
		return (float)num * 100f / (float)num2;
	}

	public float GetGroupMilestonePercentValue(int groupId)
	{
		return GetGroupPercentValue(groupId);
	}

	public List<int> GetSortedContentIdsForGroup(int groupId)
	{
		List<int> visibleContentIdsForGroup = GetVisibleContentIdsForGroup(groupId);
		List<int> list = new List<int>(visibleContentIdsForGroup.Count);
		for (int i = 0; i < visibleContentIdsForGroup.Count; i++)
		{
			list.Add(visibleContentIdsForGroup[i]);
		}
		list.Sort(CompareContentForList);
		return list;
		int CompareContentForList(int a, int b)
		{
			int contentListSortRank = GetContentListSortRank(a);
			int contentListSortRank2 = GetContentListSortRank(b);
			if (contentListSortRank != contentListSortRank2)
			{
				return contentListSortRank.CompareTo(contentListSortRank2);
			}
			int levelOrDefault = GetLevelOrDefault(a);
			int levelOrDefault2 = GetLevelOrDefault(b);
			if (levelOrDefault != levelOrDefault2)
			{
				return levelOrDefault2.CompareTo(levelOrDefault);
			}
			return CompareContentIdByGroupSort(a, b);
		}
	}

	private int GetContentListSortRank(int contentId)
	{
		switch (GetRowState(contentId))
		{
		case AccomplishmentRowState.Claimable:
			return 0;
		case AccomplishmentRowState.Claimed:
			return 2;
		default:
			if (!IsContentInfoUnlocked(contentId))
			{
				return 3;
			}
			return 1;
		}
	}

	private bool IsContentInfoUnlocked(int contentId)
	{
		return GetContentProgressPercentValue(contentId) > 0f;
	}

	public bool HasRevealedContentName(int groupId)
	{
		List<int> contentIdsForGroup = GetContentIdsForGroup(groupId);
		for (int i = 0; i < contentIdsForGroup.Count; i++)
		{
			int contentId = contentIdsForGroup[i];
			if (IsContentVisible(contentId) && IsContentInfoUnlocked(contentId))
			{
				return true;
			}
		}
		return false;
	}

	private int GetLevelOrDefault(int contentId)
	{
		if (!TryGetContent(contentId, out var content))
		{
			return 0;
		}
		return content.level;
	}

	public List<int> FilterContentIdsBySearch(int mainId, string keyword)
	{
		if (string.IsNullOrWhiteSpace(keyword))
		{
			return null;
		}
		List<int> list = new List<int>();
		foreach (int item in GetGroupIdsForMain(mainId))
		{
			foreach (int item2 in GetContentIdsForGroup(item))
			{
				if (IsContentVisible(item2) && AchievementContentMatchesSearch(item2, keyword))
				{
					list.Add(item2);
				}
			}
		}
		return list;
	}

	public bool AchievementContentMatchesSearch(int contentId, string keyword)
	{
		if (string.IsNullOrWhiteSpace(keyword))
		{
			return true;
		}
		if (!TryGetContent(contentId, out var content))
		{
			return false;
		}
		if (!IsContentVisible(contentId))
		{
			return false;
		}
		string value = keyword.Trim().ToLowerInvariant();
		string text = SafeLocalizeShort(content.groupName).ToLowerInvariant();
		string text2 = SafeLocalizeLong(content.description).ToLowerInvariant();
		if (!text.Contains(value))
		{
			return text2.Contains(value);
		}
		return true;
	}

	public bool GroupContainsSearchTarget(int groupId, string keyword)
	{
		if (string.IsNullOrWhiteSpace(keyword))
		{
			return true;
		}
		foreach (int item in GetVisibleContentIdsForGroup(groupId))
		{
			if (AchievementContentMatchesSearch(item, keyword))
			{
				return true;
			}
		}
		return false;
	}

	public List<int> GetSearchFilteredGroupIdsForMain(int mainId, string keyword)
	{
		List<int> list = new List<int>();
		if (string.IsNullOrWhiteSpace(keyword))
		{
			return GetGroupIdsForMain(mainId);
		}
		foreach (int item in GetGroupIdsForMain(mainId))
		{
			if (GroupContainsSearchTarget(item, keyword))
			{
				list.Add(item);
			}
		}
		return list;
	}

	public List<int> GetSearchFilteredSortedContentIdsForGroup(int groupId, string keyword)
	{
		List<int> sortedContentIdsForGroup = GetSortedContentIdsForGroup(groupId);
		if (string.IsNullOrWhiteSpace(keyword))
		{
			return sortedContentIdsForGroup;
		}
		string keyword2 = keyword.Trim();
		List<int> list = new List<int>(sortedContentIdsForGroup.Count);
		foreach (int item in sortedContentIdsForGroup)
		{
			if (AchievementContentMatchesSearch(item, keyword2))
			{
				list.Add(item);
			}
		}
		return list;
	}

	public void GetMatchSearchAchievementMainIds(string search, out List<int> result)
	{
		result = new List<int>();
		if (string.IsNullOrWhiteSpace(search))
		{
			return;
		}
		string keyword = search.Trim();
		foreach (int item in _mainIdsOrdered)
		{
			bool flag = false;
			foreach (int item2 in GetGroupIdsForMain(item))
			{
				if (GroupContainsSearchTarget(item2, keyword))
				{
					flag = true;
					break;
				}
			}
			if (flag)
			{
				result.Add(item);
			}
		}
	}

	private string SafeLocalizeShort(int id)
	{
		if (id == 0)
		{
			return string.Empty;
		}
		return LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, id);
	}

	private string SafeLocalizeLong(int id)
	{
		if (id == 0)
		{
			return string.Empty;
		}
		return LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, id);
	}

	public bool TryGetProgress(int contentId, out AchievementProgress prog)
	{
		prog = null;
		return (G.localPlayer?.Achievements?.ProgressData?.AchievementsProgress)?.TryGetValue(contentId, out prog) ?? false;
	}

	public string GetCompleteTimeText(int contentId)
	{
		if (!TryGetProgress(contentId, out var prog) || prog.CompleteTS == 0)
		{
			return string.Empty;
		}
		return TimeManager.GetDateTimeString(TimeManager.ServerTime.GetDateTime((long)prog.CompleteTS * 1000L));
	}

	public string GetProgressCounterText(int contentId)
	{
		if (!TryGetContentProgress(contentId, out var current, out var need))
		{
			return string.Empty;
		}
		return $"{current}/{need}";
	}

	public float GetContentProgressPercentValue(int contentId)
	{
		if (IsContentCompleted(contentId))
		{
			return 100f;
		}
		if (!TryGetContentProgress(contentId, out var current, out var need))
		{
			return 0f;
		}
		if (need <= 0)
		{
			if (current <= 0)
			{
				return 0f;
			}
			return 100f;
		}
		return Mathf.Clamp((float)current * 100f / (float)need, 0f, 100f);
	}

	private bool TryGetContentProgress(int contentId, out int current, out int need)
	{
		current = 0;
		need = 0;
		if (!TryGetContent(contentId, out var content))
		{
			return false;
		}
		int preconditionID = content.preconditionID;
		Dictionary<int, MissionGroup> missionGroups = RuntimeConfigs.data.missionGroups;
		int num = 0;
		if (missionGroups.TryGetValue(preconditionID, out var value))
		{
			num = value.missionId[0];
			ACT.Config.Mission data = CoreUtils.GetData(num, RuntimeConfigs.data.missions);
			if (data == null)
			{
				return true;
			}
			need = data.number;
			int value2;
			if (data.preconditionId == 114)
			{
				int openAllChestInLargeAreaNeed = GetOpenAllChestInLargeAreaNeed(data.cParam, data.param);
				if (openAllChestInLargeAreaNeed > 0)
				{
					need = openAllChestInLargeAreaNeed;
				}
			}
			else if (data.preconditionId == 115 && Singleton<PreconditionInfoManager>.instance.taskTargetDic.TryGetValue(num, out value2))
			{
				need = value2;
			}
		}
		if (Singleton<PreconditionInfoManager>.instance.taskDic.TryGetValue(num, out var value3))
		{
			current = value3.progress;
		}
		return true;
	}

	private static int GetOpenAllChestInLargeAreaNeed(int[] cParam, int[] param)
	{
		int missionLargeAreaId = GetMissionLargeAreaId(cParam, param);
		if (missionLargeAreaId <= 0)
		{
			return 0;
		}
		ACT.Config.MapArea data = CoreUtils.GetData(missionLargeAreaId, RuntimeConfigs.data.mapAreas);
		if (data == null || data.subMapArea == null || data.subMapArea.Length == 0)
		{
			return 0;
		}
		if (!Model<MapModel>.HasInstance())
		{
			return 0;
		}
		AreaExploreData areaGroupExploreData = Model<MapModel>.Interface.GetAreaGroupExploreData((ACT.World.MapArea)missionLargeAreaId);
		if (areaGroupExploreData == null)
		{
			return 0;
		}
		Dictionary<int, SubAreaExploreData> subAreaData = areaGroupExploreData.GetSubAreaData();
		if (subAreaData == null)
		{
			return 0;
		}
		int num = 0;
		for (int i = 0; i < data.subMapArea.Length; i++)
		{
			if (subAreaData.TryGetValue(data.subMapArea[i], out var value) && value != null)
			{
				MapExploreGroupProgress groupExploreRatioById = value.GetGroupExploreRatioById(2);
				if (groupExploreRatioById != null)
				{
					num += groupExploreRatioById.Total;
				}
			}
		}
		return num;
	}

	private static int GetMissionLargeAreaId(int[] cParam, int[] param)
	{
		if (cParam != null && cParam.Length != 0 && cParam[0] != 0)
		{
			return cParam[0];
		}
		if (param != null && param.Length != 0)
		{
			return param[0];
		}
		return 0;
	}

	public int GetMainIdForContent(int contentId)
	{
		if (!TryGetContent(contentId, out var content))
		{
			return 0;
		}
		if (!TryGetGroup(content.groupID, out var group))
		{
			return 0;
		}
		return group.typeID;
	}

	public bool IsConcealAchievement(int id)
	{
		if (_contentById.TryGetValue(id, out var value))
		{
			return value.type == 1;
		}
		return false;
	}

	public UniTask ClaimAllInCurrentGroupAsync(int groupId)
	{
		UniTaskCompletionSource tcs = new UniTaskCompletionSource();
		G.service.SendAchievementRewardReq(groupId, (AchievementRewardAck achievementRewardAck) =>
		{
			try
			{
				OpenPooledRewardPopup(achievementRewardAck.Items);
				MarkGroupRewardsClaimedLocally(groupId);
				RefreshAccomplishmentRedDot();
				NotifyDataChanged();
				tcs.TrySetResult();
			}
			catch (Exception exception)
			{
				tcs.TrySetException(exception);
			}
		});
		return tcs.Task;
	}

	private void MarkGroupRewardsClaimedLocally(int groupId)
	{
		MapField<int, AchievementProgress> mapField = G.localPlayer?.Achievements?.ProgressData?.AchievementsProgress;
		if (mapField == null)
		{
			return;
		}
		IEnumerable<int> enumerable;
		if (groupId != 0)
		{
			IEnumerable<int> contentIdsForGroup = GetContentIdsForGroup(groupId);
			enumerable = contentIdsForGroup;
		}
		else
		{
			IEnumerable<int> contentIdsForGroup = _contentById.Keys;
			enumerable = contentIdsForGroup;
		}
		foreach (int item in enumerable)
		{
			if (TryGetContent(item, out var content) && HasReward(content) && mapField.TryGetValue(item, out var value) && value != null && value.CompleteTS > 0)
			{
				value.HasTakenReward = true;
			}
		}
	}

	public UniTask ClaimCurrentGroupRewardAsync(int groupId)
	{
		UniTaskCompletionSource tcs = new UniTaskCompletionSource();
		G.service.SendAchievementGroupRewardReq(groupId, (AchievementGroupRewardAck achievementGroupRewardAck) =>
		{
			try
			{
				OpenPooledRewardPopup(achievementGroupRewardAck.Items);
				MarkGroupMilestoneRewardClaimedLocally(groupId);
				RefreshAccomplishmentRedDot();
				NotifyDataChanged();
				tcs.TrySetResult();
			}
			catch (Exception exception)
			{
				tcs.TrySetException(exception);
			}
		});
		return tcs.Task;
	}

	private static void OpenPooledRewardPopup(RepeatedField<UniversalItem> rewardItems)
	{
		List<Item> merged = ListPool<Item>.Get();
		bool flag = false;
		bool mergedReleased = false;
		try
		{
			foreach (UniversalItem rewardItem in rewardItems)
			{
				merged.Add(new Item
				{
					Id = rewardItem.Index,
					Count = rewardItem.Count
				});
			}
			if (merged.Count == 0)
			{
				ReleaseMerged();
				return;
			}
			GameUtility.OpenPopReward(GameUtility.ToUniversalItems(merged), notSort: false, ReleaseMerged);
			flag = true;
		}
		catch
		{
			if (!flag)
			{
				ReleaseMerged();
			}
			throw;
		}
		void ReleaseMerged()
		{
			if (!mergedReleased)
			{
				mergedReleased = true;
				ListPool<Item>.Release(merged);
			}
		}
	}

	private static void MarkGroupMilestoneRewardClaimedLocally(int groupId)
	{
		AchievementProgressData achievementProgressData = G.localPlayer?.Achievements?.ProgressData;
		if (achievementProgressData != null)
		{
			achievementProgressData.TookAchievementGroupRewards[groupId] = true;
		}
	}

	public void ShowAchievementHudTips(int achievementId)
	{
		if (!Singleton<SystemBlockManager>.instance.IsBlocked(SystemType.Achievement) && IsContentVisible(achievementId))
		{
			AchievementHudTipsData uiData = new AchievementHudTipsData
			{
				Id = achievementId
			};
			MapField<int, AchievementProgress> mapField = G.localPlayer?.Achievements?.ProgressData?.AchievementsProgress;
			if (mapField == null || !mapField.TryGetValue(achievementId, out var value) || value == null || !value.HasTakenReward)
			{
				OnHudCpEnqueue evt = Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
				evt.position = UIPosition.UpperMiddle;
				evt.type = HudComponentType.AchievementTip;
				evt.uiData = uiData;
				evt.timeOutDuration = 15f;
				evt.priorityInQueue = 5;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
		}
	}

	private void EnqueueAchievementToast(int achievementId)
	{
		_achievementToastQueue.Enqueue(achievementId);
		if (!_isProcessingAchievementToastQueue)
		{
			ProcessAchievementToastQueue().Forget();
		}
	}

	private async UniTaskVoid ProcessAchievementToastQueue()
	{
		_isProcessingAchievementToastQueue = true;
		try
		{
			while (_achievementToastQueue.Count > 0)
			{
				int id = _achievementToastQueue.Dequeue();
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACHIEVEMENTTOASTTIPS, new AchievementTipsViewData
				{
					Id = id
				});
				await UniTask.Delay(2000);
			}
		}
		finally
		{
			_isProcessingAchievementToastQueue = false;
		}
	}

	public void UpdateAchievementData(AchievementInfoNtf ntf)
	{
		if (ntf?.AchievementData == null)
		{
			return;
		}
		Achievements achievements = G.localPlayer?.Achievements;
		if (achievements == null)
		{
			return;
		}
		Achievements achievements2 = achievements;
		if (achievements2.ProgressData == null)
		{
			AchievementProgressData achievementProgressData = (achievements2.ProgressData = new AchievementProgressData());
		}
		AchievementProgressData progressData = achievements.ProgressData;
		AchievementProgressData achievementData = ntf.AchievementData;
		foreach (KeyValuePair<int, AchievementProgress> item in achievementData.AchievementsProgress)
		{
			progressData.AchievementsProgress[item.Key] = item.Value?.Clone() ?? new AchievementProgress();
		}
		foreach (KeyValuePair<int, bool> tookAchievementGroupReward in achievementData.TookAchievementGroupRewards)
		{
			progressData.TookAchievementGroupRewards[tookAchievementGroupReward.Key] = tookAchievementGroupReward.Value;
		}
		RefreshAccomplishmentRedDot();
		NotifyDataChanged();
	}

	private void NotifyDataChanged()
	{
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_AccomplishmentRefresh, null);
	}

	public bool IsShowPickUpBtn()
	{
		foreach (int orderedMainId in OrderedMainIds)
		{
			foreach (int item in GetGroupIdsForMain(orderedMainId))
			{
				if (GroupHasClaimableContentReward(item))
				{
					return true;
				}
			}
		}
		return false;
	}

	public void UpdateAchievementType(BaseEventContent message)
	{
		if (!(message is SyncBattleMassage syncBattleMassage))
		{
			return;
		}
		if (syncBattleMassage.syncInfo != null)
		{
			SendAchievementTypeMassage(syncBattleMassage.syncInfo);
			syncBattleMassage.syncInfo = null;
			return;
		}
		if (!AchievementSyncInfoSetters.TryGetValue(syncBattleMassage.syncType, out var value))
		{
			value = AchievementSyncInfoSetters[SyncBattleDataType.FightTypeCount];
		}
		AchievementSyncInfo achievementSyncInfo = new AchievementSyncInfo();
		value(achievementSyncInfo, syncBattleMassage.id, syncBattleMassage.count);
		SendAchievementTypeMassage(achievementSyncInfo);
	}

	public void SendAchievementTypeMassage(AchievementSyncInfo achievementSyncInfo)
	{
		if (achievementSyncInfo != null)
		{
			G.service.AchievementSyncInfoReq(achievementSyncInfo, null);
		}
	}

	public Dictionary<int, AchievementContents> GetBattleGroupList()
	{
		if (_battleAccomplishmentIds.Count > 0)
		{
			return new Dictionary<int, AchievementContents>(_battleAccomplishmentIds);
		}
		if (!_groupsByMain.TryGetValue(3, out var value) || value == null || value.Count == 0)
		{
			return new Dictionary<int, AchievementContents>();
		}
		for (int i = 0; i < value.Count; i++)
		{
			int groupId = value[i];
			List<int> contentIdsForGroup = GetContentIdsForGroup(groupId);
			if (contentIdsForGroup == null || contentIdsForGroup.Count == 0)
			{
				continue;
			}
			for (int j = 0; j < contentIdsForGroup.Count; j++)
			{
				int key = contentIdsForGroup[j];
				if (!_battleAccomplishmentIds.ContainsKey(key) && _contentById.TryGetValue(key, out var value2))
				{
					_battleAccomplishmentIds.Add(key, value2);
				}
			}
		}
		return new Dictionary<int, AchievementContents>(_battleAccomplishmentIds);
	}

	private void EnsureBattleMissionParamsCache()
	{
		if (_battleMissionCParamsCached)
		{
			return;
		}
		_battleMissionCParams.Clear();
		Dictionary<int, AchievementContents> battleGroupList = GetBattleGroupList();
		if (battleGroupList.Count <= 0)
		{
			_battleMissionCParamsCached = true;
			return;
		}
		foreach (KeyValuePair<int, AchievementContents> item in battleGroupList)
		{
			int preconditionID = item.Value.preconditionID;
			if (preconditionID == 0)
			{
				continue;
			}
			MissionGroup data = CoreUtils.GetData(preconditionID, RuntimeConfigs.data.missionGroups);
			if (data != null && data.missionId != null && data.missionId.Length != 0)
			{
				ACT.Config.Mission data2 = CoreUtils.GetData(data.missionId[0], RuntimeConfigs.data.missions);
				if (data2 != null && data2.cParam != null && data2.cParam.Length != 0)
				{
					_battleMissionCParams.Add(data2.cParam);
				}
			}
		}
		_battleMissionCParamsCached = true;
	}

	private bool ContainsParam(int[] cParam, int value)
	{
		if (cParam == null || cParam.Length == 0)
		{
			return false;
		}
		for (int i = 0; i < cParam.Length; i++)
		{
			if (cParam[i] == value)
			{
				return true;
			}
		}
		return false;
	}

	public bool CheckBattleParam(int inParam)
	{
		EnsureBattleMissionParamsCache();
		if (_battleMissionCParams.Count <= 0)
		{
			return false;
		}
		foreach (int[] battleMissionCParam in _battleMissionCParams)
		{
			if (ContainsParam(battleMissionCParam, inParam))
			{
				return true;
			}
		}
		return false;
	}

	public bool CheckBattleParam(int inParam1, int inParam2)
	{
		EnsureBattleMissionParamsCache();
		if (_battleMissionCParams.Count <= 0)
		{
			return false;
		}
		foreach (int[] battleMissionCParam in _battleMissionCParams)
		{
			if (ContainsParam(battleMissionCParam, inParam1) && ContainsParam(battleMissionCParam, inParam2))
			{
				return true;
			}
		}
		return false;
	}

	public bool CheckBattleParam(int inParam1, int inParam2, int inParam3)
	{
		EnsureBattleMissionParamsCache();
		if (_battleMissionCParams.Count <= 0)
		{
			return false;
		}
		foreach (int[] battleMissionCParam in _battleMissionCParams)
		{
			if (ContainsParam(battleMissionCParam, inParam1) && ContainsParam(battleMissionCParam, inParam2) && ContainsParam(battleMissionCParam, inParam3))
			{
				return true;
			}
		}
		return false;
	}

	public bool CheckBattleParam(int inParam1, int inParam2, int inParam3, int inParam4)
	{
		EnsureBattleMissionParamsCache();
		if (_battleMissionCParams.Count <= 0)
		{
			return false;
		}
		foreach (int[] battleMissionCParam in _battleMissionCParams)
		{
			if (ContainsParam(battleMissionCParam, inParam1) && ContainsParam(battleMissionCParam, inParam2) && ContainsParam(battleMissionCParam, inParam3) && ContainsParam(battleMissionCParam, inParam4))
			{
				return true;
			}
		}
		return false;
	}
}
