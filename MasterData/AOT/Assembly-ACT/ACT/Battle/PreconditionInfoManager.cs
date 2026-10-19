using System;
using System.Collections.Generic;
using Fundamental;

namespace ACT.Battle;

public class PreconditionInfoManager : Singleton<PreconditionInfoManager>
{
	public Dictionary<int, PreconditionInfo> preconditionInfos;

	public Dictionary<int, int> taskGroupDic;

	public Dictionary<int, TaskInfo> taskDic;

	public Dictionary<int, int> taskTargetDic;

	private Action<int, TaskInfo, bool> _taskProgressChangeAction;

	public override ContextType ContextType => ContextType.GAME;

	public event Action<int, TaskInfo, bool> TaskProgressChangeAction
	{
		add
		{
			_taskProgressChangeAction = (Action<int, TaskInfo, bool>)Delegate.Combine(_taskProgressChangeAction, value);
		}
		remove
		{
			_taskProgressChangeAction = (Action<int, TaskInfo, bool>)Delegate.Remove(_taskProgressChangeAction, value);
		}
	}

	public void NotifyTaskProgressChange(int taskId, TaskInfo taskInfo, bool isNew)
	{
		_taskProgressChangeAction?.Invoke(taskId, taskInfo, isNew);
	}

	public override void Init()
	{
		preconditionInfos = new Dictionary<int, PreconditionInfo>();
		taskGroupDic = new Dictionary<int, int>();
		taskDic = new Dictionary<int, TaskInfo>();
		taskTargetDic = new Dictionary<int, int>();
		preconditionInfos.Add(1, new MissionInfo());
		preconditionInfos.Add(2, new PlayerLevelInfo());
		preconditionInfos.Add(5, new PassLevelInfo());
		preconditionInfos.Add(6, new GetItemInfo());
		preconditionInfos.Add(7, new GetItemsWithQualityInfo());
		preconditionInfos.Add(9, new LevelWeaponInfo());
		preconditionInfos.Add(11, new DialogKeyPointInfo());
		preconditionInfos.Add(12, new HasItemUnLockSystem());
		preconditionInfos.Add(13, new CompleteAbyssInfo());
		preconditionInfos.Add(14, new AbyssStarsInfo());
		preconditionInfos.Add(16, new PassRaidType());
		preconditionInfos.Add(17, new ShowInScene());
		preconditionInfos.Add(18, new CountDatas());
		preconditionInfos.Add(25, new GetRewardBoxCount());
		preconditionInfos.Add(26, new GetCharacterTypeCount());
		preconditionInfos.Add(27, new GetWeaponTypeCount());
		preconditionInfos.Add(28, new BossFightTime());
		preconditionInfos.Add(29, new ActivityLoginDays());
		preconditionInfos.Add(30, new GachaCount());
		preconditionInfos.Add(31, new SetTeamCharacterNum());
		preconditionInfos.Add(32, new PotionLevelNum());
		preconditionInfos.Add(33, new UseItem());
		preconditionInfos.Add(34, new GemEquippedNum());
		preconditionInfos.Add(35, new TempleEndCount());
		preconditionInfos.Add(36, new GetDailyReward());
		preconditionInfos.Add(37, new MakeEquipCount());
		preconditionInfos.Add(38, new EquipLevel());
		preconditionInfos.Add(39, new EquipRareCount());
		preconditionInfos.Add(40, new SkillLevel());
		preconditionInfos.Add(41, new TriggerInteraction());
		preconditionInfos.Add(42, new PassRaidByIdCount());
		preconditionInfos.Add(43, new PassRaidByMarkCount());
		preconditionInfos.Add(44, new PassRaidByEntranceCount());
		preconditionInfos.Add(45, new SubMissionInfo());
		preconditionInfos.Add(116, new MapUnlockInfo());
	}

	public override void UnInit()
	{
		base.UnInit();
		taskGroupDic.Clear();
		taskGroupDic = null;
		taskTargetDic?.Clear();
		taskTargetDic = null;
	}

	public bool IsComplete(int id, int para1)
	{
		if (preconditionInfos.TryGetValue(id, out var value))
		{
			return value.IsComplete(new int[1] { para1 });
		}
		return false;
	}

	public bool IsComplete(int id, int[] param)
	{
		if (preconditionInfos.TryGetValue(id, out var value))
		{
			return value.IsComplete(param);
		}
		return false;
	}

	public bool GetTaskGroupIsComplete(int taskGroupId)
	{
		if (taskGroupDic.TryGetValue(taskGroupId, out var value))
		{
			return value != 0;
		}
		return false;
	}
}
