using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using Google.Protobuf.Collections;
using Pb;

namespace ACT.Model;

public class TargetGuideModel : Model<TargetGuideModel>
{
	public Dictionary<int, bool> targetGuideReawrdState;

	public Dictionary<int, bool> targetGuideChapterReawrdState;

	private HashSet<int> _alreadyUnLockChapter;

	protected override void Init()
	{
		targetGuideReawrdState = DictionaryPool<int, bool>.Get();
		targetGuideChapterReawrdState = DictionaryPool<int, bool>.Get();
		_alreadyUnLockChapter = HashSetPool<int>.Get();
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction += OnTaskInfoChanged;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, OnTutorialSystemOpen);
		SyncTargetGuideRewardsState();
	}

	protected override void UnInit()
	{
		DictionaryPool<int, bool>.Release(targetGuideReawrdState);
		DictionaryPool<int, bool>.Release(targetGuideChapterReawrdState);
		HashSetPool<int>.Release(_alreadyUnLockChapter);
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction -= OnTaskInfoChanged;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, OnTutorialSystemOpen);
	}

	public void SyncTargetGuideRewardsState()
	{
		if (G.localPlayer.growthGuide == null)
		{
			return;
		}
		targetGuideReawrdState.Clear();
		targetGuideChapterReawrdState.Clear();
		foreach (KeyValuePair<int, bool> item in G.localPlayer.growthGuide.ClaimedChapterReward)
		{
			targetGuideChapterReawrdState[item.Key] = item.Value;
		}
		foreach (KeyValuePair<int, bool> item2 in G.localPlayer.growthGuide.ClaimedMissionReward)
		{
			targetGuideReawrdState[item2.Key] = item2.Value;
		}
		UpadteAlreadyUnLockChapter();
		SetRedDotState();
	}

	public void SetRedDotState()
	{
		if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.HandBook) && Model<HandBookModel>.HasInstance() && Model<HandBookModel>.Interface.IsFirstTabUnlock(2))
		{
			bool canRewardState = GetCanRewardState();
			if (!Singleton<RedDotManager>.instance.IsPathRegistered(RedDotPathDefine.HasTargetGuideReward))
			{
				Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(RedDotPathDefine.HasTargetGuideReward, canRewardState);
			}
			else
			{
				Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.HasTargetGuideReward, canRewardState);
			}
		}
	}

	private bool GetCanRewardState()
	{
		foreach (int item in _alreadyUnLockChapter)
		{
			MainGuid data = CoreUtils.GetData(item, RuntimeConfigs.data.mainGuids);
			if (data == null)
			{
				return false;
			}
			int[] missionGroupID = data.missionGroupID;
			foreach (int num in missionGroupID)
			{
				bool flag = CurGudieMissionCanReward(num);
				bool guideMissionRewardState = GetGuideMissionRewardState(num);
				if (flag && !guideMissionRewardState)
				{
					return true;
				}
			}
			bool flag2 = CurChapterCanReward(data.id);
			bool chapterRewardState = GetChapterRewardState(data.id);
			if (flag2 && !chapterRewardState)
			{
				return true;
			}
		}
		return false;
	}

	private void UpadteAlreadyUnLockChapter()
	{
		_alreadyUnLockChapter.Clear();
		_alreadyUnLockChapter.Add(RuntimeConfigs.data.mainGuids.Values.First().id);
		foreach (MainGuid value in RuntimeConfigs.data.mainGuids.Values)
		{
			bool flag = NextChapterIsUnLock(value.id);
			int num = value.id + 1;
			if (flag && num <= RuntimeConfigs.data.mainGuids.Values.Last().id)
			{
				_alreadyUnLockChapter.Add(num);
			}
		}
	}

	public bool GetGuideMissionRewardState(int guideMissionId)
	{
		if (targetGuideReawrdState.ContainsKey(guideMissionId))
		{
			return true;
		}
		return false;
	}

	public bool GetChapterRewardState(int chapterId)
	{
		if (targetGuideChapterReawrdState.ContainsKey(chapterId))
		{
			return true;
		}
		return false;
	}

	public (int, int) GetGuideMissionProgress(int guideMissionGroupId)
	{
		MissionGroup data = CoreUtils.GetData(guideMissionGroupId, RuntimeConfigs.data.missionGroups);
		Singleton<PreconditionInfoManager>.instance.taskDic.TryGetValue(data.missionId.FirstOrDefault(), out var value);
		int item = value?.progress ?? 0;
		int number = CoreUtils.GetData(data.missionId.FirstOrDefault(), RuntimeConfigs.data.missions).number;
		return (item, number);
	}

	public bool CurGudieMissionCanReward(int guideMissionGroupId)
	{
		MissionGroup data = CoreUtils.GetData(guideMissionGroupId, RuntimeConfigs.data.missionGroups);
		if (data == null)
		{
			return false;
		}
		int num = data.missionId.FirstOrDefault();
		if (num == 0)
		{
			return false;
		}
		if (Singleton<PreconditionInfoManager>.instance.taskDic.TryGetValue(num, out var value))
		{
			return value.status == 1;
		}
		return false;
	}

	public (int, int) GetNextChapterLockProgress(int curChapterId)
	{
		MainGuid data = CoreUtils.GetData(curChapterId, RuntimeConfigs.data.mainGuids);
		int unlockMissionRequire = data.unlockMissionRequire;
		int num = 0;
		int[] missionGroupID = data.missionGroupID;
		foreach (int num2 in missionGroupID)
		{
			if (CurGudieMissionCanReward(num2) && GetGuideMissionRewardState(num2))
			{
				num++;
			}
		}
		return (num, unlockMissionRequire);
	}

	public (int, int) GetCurChapterRewardProgress(int curChapterId)
	{
		MainGuid data = CoreUtils.GetData(curChapterId, RuntimeConfigs.data.mainGuids);
		int unlockRewardsRequire = data.unlockRewardsRequire;
		int num = 0;
		int[] missionGroupID = data.missionGroupID;
		foreach (int num2 in missionGroupID)
		{
			if (CurGudieMissionCanReward(num2) && GetGuideMissionRewardState(num2))
			{
				num++;
			}
		}
		return (num, unlockRewardsRequire);
	}

	public bool NextChapterIsUnLock(int curChapterId)
	{
		(int, int) nextChapterLockProgress = GetNextChapterLockProgress(curChapterId);
		return nextChapterLockProgress.Item1 >= nextChapterLockProgress.Item2;
	}

	public bool CurChapterIsUnlock(int curChapterId)
	{
		if (curChapterId == RuntimeConfigs.data.mainGuids.Values.First().id)
		{
			return true;
		}
		int curChapterId2 = curChapterId - 1;
		return NextChapterIsUnLock(curChapterId2);
	}

	public bool CurChapterCanReward(int curChapterId)
	{
		(int, int) curChapterRewardProgress = GetCurChapterRewardProgress(curChapterId);
		return curChapterRewardProgress.Item1 >= curChapterRewardProgress.Item2;
	}

	public bool CurAllRewardIsAwarded(int curChapterId)
	{
		MainGuid data = CoreUtils.GetData(curChapterId, RuntimeConfigs.data.mainGuids);
		int num = data.missionGroupID.Length;
		int num2 = 0;
		int[] missionGroupID = data.missionGroupID;
		foreach (int num3 in missionGroupID)
		{
			if (CurGudieMissionCanReward(num3) && GetGuideMissionRewardState(num3))
			{
				num2++;
			}
		}
		if (num2 >= num)
		{
			return GetChapterRewardState(curChapterId);
		}
		return false;
	}

	public (bool left, bool right) HasRewardableChapterAround(int curChapterId)
	{
		bool flag = false;
		bool flag2 = false;
		foreach (int item in _alreadyUnLockChapter)
		{
			if (flag & flag2)
			{
				break;
			}
			if (item == curChapterId)
			{
				continue;
			}
			MainGuid data = CoreUtils.GetData(item, RuntimeConfigs.data.mainGuids);
			if (data == null)
			{
				continue;
			}
			bool flag3 = false;
			int[] missionGroupID = data.missionGroupID;
			foreach (int num in missionGroupID)
			{
				if (CurGudieMissionCanReward(num) && !GetGuideMissionRewardState(num))
				{
					flag3 = true;
					break;
				}
			}
			if (!flag3)
			{
				flag3 = CurChapterCanReward(item) && !GetChapterRewardState(item);
			}
			if (flag3)
			{
				if (item < curChapterId)
				{
					flag = true;
				}
				else
				{
					flag2 = true;
				}
			}
		}
		return (left: flag, right: flag2);
	}

	public int GetDefultShowChapter()
	{
		foreach (int item in _alreadyUnLockChapter)
		{
			MainGuid data = CoreUtils.GetData(item, RuntimeConfigs.data.mainGuids);
			int[] missionGroupID = data.missionGroupID;
			foreach (int num in missionGroupID)
			{
				bool flag = CurGudieMissionCanReward(num);
				bool guideMissionRewardState = GetGuideMissionRewardState(num);
				if (flag && !guideMissionRewardState)
				{
					return data.id;
				}
			}
			bool flag2 = CurChapterCanReward(data.id);
			bool chapterRewardState = GetChapterRewardState(data.id);
			if (flag2 && !chapterRewardState)
			{
				return data.id;
			}
		}
		if (_alreadyUnLockChapter.Count != RuntimeConfigs.data.mainGuids.Count)
		{
			if (_alreadyUnLockChapter.Count <= 1)
			{
				return _alreadyUnLockChapter.First();
			}
			return _alreadyUnLockChapter.Last();
		}
		return _alreadyUnLockChapter.Last();
	}

	public void AwardChapterReward(int curChapterId, Action callback)
	{
		G.service.SendAwardChapterReward(curChapterId, (HandbookGrowthGuideChapterClaimRewardAck ack, bool b) =>
		{
			if (b)
			{
				PlayerGrowthGuide growthGuide = ack.GrowthGuide;
				targetGuideReawrdState.Clear();
				targetGuideReawrdState.AddRange(growthGuide.ClaimedMissionReward);
				targetGuideChapterReawrdState.Clear();
				targetGuideChapterReawrdState.AddRange(growthGuide.ClaimedChapterReward);
				GetReward(ack.Items);
				UpadteAlreadyUnLockChapter();
				SetRedDotState();
				callback?.Invoke();
			}
		});
	}

	public void AwardGuideMissionReward(int belongChapter, Action callback)
	{
		G.service.SendAwardTargetGuideMissionReward(0, belongChapter, (HandbookGrowthGuideMissionClaimRewardAck ack, bool b) =>
		{
			if (b)
			{
				PlayerGrowthGuide growthGuide = ack.GrowthGuide;
				targetGuideReawrdState.Clear();
				targetGuideReawrdState.AddRange(growthGuide.ClaimedMissionReward);
				targetGuideChapterReawrdState.Clear();
				targetGuideChapterReawrdState.AddRange(growthGuide.ClaimedChapterReward);
				GetReward(ack.Items);
				UpadteAlreadyUnLockChapter();
				SetRedDotState();
				callback?.Invoke();
			}
		});
	}

	private void GetReward(RepeatedField<UniversalItem> items)
	{
		Dictionary<int, Item> rewardsMap = DictionaryPool<int, Item>.Get();
		List<Item> rewards = ListPool<Item>.Get();
		foreach (UniversalItem item in items)
		{
			Item value2;
			if (item.ExtraItems.Count > 0)
			{
				foreach (UniversalItem extraItem in item.ExtraItems)
				{
					if (rewardsMap.TryGetValue(extraItem.Index, out var value))
					{
						rewardsMap[extraItem.Index].Count += value.Count;
						continue;
					}
					rewardsMap[extraItem.Index] = new Item
					{
						Id = extraItem.Index,
						Count = extraItem.Count
					};
				}
			}
			else if (rewardsMap.TryGetValue(item.Index, out value2))
			{
				rewardsMap[item.Index].Count += item.Count;
			}
			else
			{
				rewardsMap[item.Index] = new Item
				{
					Id = item.Index,
					Count = item.Count
				};
			}
		}
		foreach (Item value3 in rewardsMap.Values)
		{
			rewards.Add(value3);
		}
		GameUtility.OpenPopReward(GameUtility.ToUniversalItems(rewards), notSort: false, () =>
		{
			DictionaryPool<int, Item>.Release(rewardsMap);
			ListPool<Item>.Release(rewards);
		});
	}

	private void OnTaskInfoChanged(int arg1, ACT.Battle.TaskInfo arg2, bool arg3)
	{
		foreach (int item in _alreadyUnLockChapter)
		{
			if (RuntimeConfigs.data.mainGuids[item].missionGroupID.Contains(arg1))
			{
				SetRedDotState();
				break;
			}
		}
	}

	private void OnTutorialSystemOpen(BaseEventContent obj)
	{
		if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.HandBook))
		{
			SetRedDotState();
		}
	}
}
