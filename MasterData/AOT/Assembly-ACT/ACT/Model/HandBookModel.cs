using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Model.Jump;
using ACT.RichText;
using ACT.UI;
using Fundamental;
using UnityEngine;

namespace ACT.Model;

public class HandBookModel : Model<HandBookModel>, IJumpable
{
	public LuminModelType JumpSourceType => LuminModelType.HandBook;

	protected override void Init()
	{
		try
		{
			RefreshDailyRedDot();
			Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction += NotifyTaskProgressChange;
		}
		catch (Exception message)
		{
			Debug.LogWarning(message);
		}
	}

	protected override void UnInit()
	{
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction -= NotifyTaskProgressChange;
	}

	public bool IsFirstTabUnlock(int firsTabID)
	{
		HandBookMain data = CoreUtils.GetData(firsTabID, RuntimeConfigs.data.handBookMains);
		if (data == null)
		{
			return false;
		}
		int[] contentLv2ID = data.contentLv2ID;
		foreach (int secondTabID in contentLv2ID)
		{
			if (IsSecondTabUnlock(secondTabID))
			{
				return true;
			}
		}
		return false;
	}

	public bool IsSecondTabUnlock(int secondTabID)
	{
		HbContent data = CoreUtils.GetData(secondTabID, RuntimeConfigs.data.hbContents);
		if (data == null)
		{
			return false;
		}
		MissionGroup data2 = CoreUtils.GetData(data.openRequire, RuntimeConfigs.data.missionGroups);
		if (data2 == null)
		{
			return true;
		}
		int key = data2.missionId.FirstOrDefault();
		Singleton<PreconditionInfoManager>.instance.taskDic.TryGetValue(key, out var value);
		if (value != null)
		{
			int status = value.status;
			if ((uint)(status - 1) <= 1u)
			{
				return true;
			}
		}
		return false;
	}

	public bool IsPowerExchangeTabUnlock(int exchangeItemId)
	{
		if (exchangeItemId == 0)
		{
			return true;
		}
		if (!RuntimeConfigs.data.ExchangeItems.TryGetValue(exchangeItemId, out var value) || !RuntimeConfigs.data.raidEntranceDatas.TryGetValue(value.raidEntranceId, out var value2))
		{
			return false;
		}
		if (value2.unlockCondition > 0)
		{
			return Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(value2.unlockCondition);
		}
		return true;
	}

	private int GetUnlockedPowerExchangeTabId(int exchangeItemId)
	{
		if (exchangeItemId > 0 && IsPowerExchangeTabUnlock(exchangeItemId))
		{
			return exchangeItemId;
		}
		int num = 0;
		foreach (KeyValuePair<int, ExchangeItem> exchangeItem in RuntimeConfigs.data.ExchangeItems)
		{
			if (IsPowerExchangeTabUnlock(exchangeItem.Key) && (num == 0 || exchangeItem.Key < num))
			{
				num = exchangeItem.Key;
			}
		}
		return num;
	}

	private void NotifyTaskProgressChange(int arg1, TaskInfo info, bool arg3)
	{
		bool flag;
		if (info != null)
		{
			int status = info.status;
			if ((uint)(status - 1) <= 1u)
			{
				flag = true;
				goto IL_0016;
			}
		}
		flag = false;
		goto IL_0016;
		IL_0016:
		if (flag)
		{
			RefreshDailyRedDot();
		}
	}

	public void RefreshDailyRedDot()
	{
		bool flag = false;
		if (IsFirstTabUnlock(1) && Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.HandBook))
		{
			G.detailUserInfo.Attributes.TryGetValue(RuntimeConfigs.data.game.attrActivePoint, out var value);
			bool value3;
			foreach (KeyValuePair<int, DailyMissionReward> dailyMissionReward in RuntimeConfigs.data.dailyMissionRewards)
			{
				DailyMissionReward value2 = dailyMissionReward.Value;
				if (G.localPlayer?.DailyData?.HandbookRewardStatus?.DailyPointReward?.TryGetValue(value2.id, out value3) != true && value >= value2.creditRequire)
				{
					flag = true;
					break;
				}
			}
			if (!flag && value < 500)
			{
				foreach (KeyValuePair<int, DailyMission> dailyMission in RuntimeConfigs.data.dailyMissions)
				{
					if (!G.localPlayer.DailyData.HandbookRewardStatus.DailyConditionTaskReward.TryGetValue(dailyMission.Key, out value3))
					{
						MissionGroup data = CoreUtils.GetData(CoreUtils.GetData(dailyMission.Key, RuntimeConfigs.data.dailyMissions).groupID, RuntimeConfigs.data.missionGroups);
						Singleton<PreconditionInfoManager>.instance.taskDic.TryGetValue(data.missionId.FirstOrDefault(), out var value4);
						if (value4 != null && value4.status == 1)
						{
							flag = true;
							break;
						}
					}
				}
			}
		}
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.HasDailyReward, flag);
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		if (JumpModel.IsCurrentWorldChallangeNormal())
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.Hide
			};
		}
		List<int> list = jumpData.Params;
		if (list.Count >= 2 && list[1] == 5)
		{
			return CanJumpPowerExchange(list);
		}
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.HandBook) || (list.Count >= 2 && !IsFirstTabUnlock(list[1])) || (list.Count >= 3 && !IsSecondTabUnlock(list[2])))
		{
			List<string> list2 = ListPool<string>.Get();
			try
			{
				TryAddHandBookPageLockTips(list, list2);
				JumpResult result = new JumpResult(JumpResult.JumpShowType.Forbidden, null);
				result.SetMessages(list2);
				return result;
			}
			finally
			{
				ListPool<string>.Release(list2);
			}
		}
		if (list.Count >= 4 && IsWildBossJumpLocked(list[3]))
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.Hide
			};
		}
		return new JumpResult
		{
			ShowType = JumpResult.JumpShowType.CanJump
		};
	}

	private bool IsWildBossJumpLocked(int wildBossUseId)
	{
		WildBossUse data = CoreUtils.GetData(wildBossUseId, RuntimeConfigs.data.wildBossUses);
		if (data != null)
		{
			return !Model<MonsterHandModel>.Interface.WildBossUnLock(data.monsterID);
		}
		return false;
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		List<int> list = jumpData.Params;
		int num = ((list.Count >= 2) ? list[1] : 0);
		int num2 = ((list.Count >= 3) ? list[2] : 0);
		bool flag = num == 5;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_HANDBOOK, new HandBookViewParam
		{
			H1TabIndex = num,
			H2TabIndex = ((!flag) ? num2 : 0),
			WildBossUseId = ((list.Count >= 4) ? list[3] : 0),
			PowerExchangeId = (flag ? GetUnlockedPowerExchangeTabId(num2) : 0)
		});
	}

	private JumpResult CanJumpPowerExchange(List<int> jumpParams)
	{
		int firstTabId = jumpParams[1];
		int num = ((jumpParams.Count > 2) ? jumpParams[2] : 0);
		if (IsPowerExchangeJumpUnlocked(firstTabId, num))
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.CanJump
			};
		}
		List<string> list = ListPool<string>.Get();
		try
		{
			TryAddPowerExchangePageLockTips(firstTabId, num, list);
			if (list.Count == 0)
			{
				AddUniqueJumpTip(list, Singleton<SystemUnlockManager>.instance.GetSystemLockTips(SystemType.HandBook));
			}
			JumpResult result = new JumpResult(JumpResult.JumpShowType.Forbidden, null);
			result.SetMessages(list);
			return result;
		}
		finally
		{
			ListPool<string>.Release(list);
		}
	}

	private bool IsPowerExchangeJumpUnlocked(int firstTabId, int exchangeId)
	{
		if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.HandBook) && IsFirstTabUnlock(firstTabId))
		{
			return IsPowerExchangeTabUnlock(exchangeId);
		}
		return false;
	}

	private void TryAddHandBookPageLockTips(List<int> jumpParams, List<string> messages)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.HandBook))
		{
			AddUniqueJumpTip(messages, Singleton<SystemUnlockManager>.instance.GetSystemLockTips(SystemType.HandBook));
		}
		if (jumpParams.Count >= 3 && !IsSecondTabUnlock(jumpParams[2]))
		{
			int num = jumpParams[2];
			TryAddMissionGroupPreconditionTip(messages, CoreUtils.GetData(num, RuntimeConfigs.data.hbContents)?.openRequire ?? 0);
			HandBookMain data = CoreUtils.GetData(jumpParams[1], RuntimeConfigs.data.handBookMains);
			if (data?.contentLv2ID != null && data.contentLv2ID.Contains(num))
			{
				return;
			}
		}
		if (jumpParams.Count < 2 || IsFirstTabUnlock(jumpParams[1]))
		{
			return;
		}
		HandBookMain data2 = CoreUtils.GetData(jumpParams[1], RuntimeConfigs.data.handBookMains);
		if (data2?.contentLv2ID == null)
		{
			return;
		}
		int[] contentLv2ID = data2.contentLv2ID;
		foreach (int num2 in contentLv2ID)
		{
			if (!IsSecondTabUnlock(num2))
			{
				TryAddMissionGroupPreconditionTip(messages, CoreUtils.GetData(num2, RuntimeConfigs.data.hbContents)?.openRequire ?? 0);
			}
		}
	}

	private void TryAddPowerExchangePageLockTips(int firstTabId, int exchangeItemId, List<string> messages)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.HandBook))
		{
			AddUniqueJumpTip(messages, Singleton<SystemUnlockManager>.instance.GetSystemLockTips(SystemType.HandBook));
		}
		HandBookMain data = CoreUtils.GetData(firstTabId, RuntimeConfigs.data.handBookMains);
		if (data?.contentLv2ID != null)
		{
			int[] contentLv2ID = data.contentLv2ID;
			foreach (int num in contentLv2ID)
			{
				if (!IsSecondTabUnlock(num))
				{
					TryAddMissionGroupPreconditionTip(messages, CoreUtils.GetData(num, RuntimeConfigs.data.hbContents)?.openRequire ?? 0);
				}
			}
		}
		if (exchangeItemId > 0 && !IsPowerExchangeTabUnlock(exchangeItemId) && RuntimeConfigs.data.ExchangeItems.TryGetValue(exchangeItemId, out var value) && RuntimeConfigs.data.raidEntranceDatas.TryGetValue(value.raidEntranceId, out var value2))
		{
			TryAddMissionGroupPreconditionTip(messages, value2.unlockCondition);
		}
	}

	private void TryAddMissionGroupPreconditionTip(List<string> messages, int missionGroupId)
	{
		if (TryGetMissionGroupConditionText(missionGroupId, out var tip))
		{
			AddUniqueJumpTip(messages, tip);
		}
	}

	private bool TryGetMissionGroupConditionText(int missionGroupId, out string tip)
	{
		tip = null;
		if (missionGroupId <= 0)
		{
			return false;
		}
		MissionGroup data = CoreUtils.GetData(missionGroupId, RuntimeConfigs.data.missionGroups);
		if (data?.missionId == null || data.missionId.Length == 0)
		{
			return false;
		}
		Mission data2 = CoreUtils.GetData(data.missionId[0], RuntimeConfigs.data.missions);
		if (data2 == null)
		{
			return false;
		}
		PreconditionData data3 = CoreUtils.GetData(data2.preconditionId, RuntimeConfigs.data.preconditionDatas);
		if (data3 == null || data3.desId <= 0)
		{
			return false;
		}
		tip = CustomTagParser.ReplacePreconditionText(data2, data2.number, data2.param);
		return !string.IsNullOrEmpty(tip);
	}

	private void AddUniqueJumpTip(List<string> messages, string tip)
	{
		if (string.IsNullOrEmpty(tip))
		{
			return;
		}
		for (int i = 0; i < messages.Count; i++)
		{
			if (messages[i] == tip)
			{
				return;
			}
		}
		messages.Add(tip);
	}
}
