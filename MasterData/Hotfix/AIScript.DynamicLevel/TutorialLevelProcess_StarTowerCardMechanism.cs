using System.Collections.Generic;
using TrueSync;

namespace AIScript.DynamicLevel;

public class TutorialLevelProcess_StarTowerCardMechanism : TutorialLevelProcessBase
{
	private readonly int buffId_Room = 911210110;

	private readonly Dictionary<int, string> operationTipsDic = new Dictionary<int, string>
	{
		[1210601] = "Tutorial_PotentialGuide_1",
		[1210602] = "Tutorial_PotentialGuide_2",
		[1210603] = "Tutorial_PotentialGuide_3",
		[1210604] = "Tutorial_GuideEnd"
	};

	private readonly Dictionary<int, FP> waitTimeDic = new Dictionary<int, FP>
	{
		[1210601] = 3.5,
		[1210602] = 3.5,
		[1210603] = 0
	};

	private readonly string monsterSpawnWave_CorePerk = "Wave_1";

	private readonly List<int> perkIdList_CorePerk = new List<int> { 510301, 510302, 510304 };

	private readonly string monsterSpawnWave_NormalPerk = "Wave_2";

	private readonly List<int> perkIdList_NormalPerk = new List<int> { 510309, 511126, 511229 };

	private readonly string monsterSpawnWave_FreeBattle = "Wave_3";

	public override void OnLevelStart()
	{
		base.OnLevelStart();
		AddRoomBuff(buffId_Room);
		StartWaitTime(0.5, () =>
		{
			TriggerNextTask();
		});
	}

	public override void OnTriggerNextTask(int taskId)
	{
		base.OnTriggerNextTask(taskId);
		if (operationTipsDic.TryGetValue(taskId, out var value))
		{
			UpdateOperationTips(value);
		}
		switch (_subProcessIndex)
		{
		case 1:
			ActiveMonsterSpawnWave(monsterSpawnWave_CorePerk);
			break;
		case 2:
			ActiveMonsterSpawnWave(monsterSpawnWave_NormalPerk);
			break;
		case 3:
			ActiveMonsterSpawnWave(monsterSpawnWave_FreeBattle);
			break;
		case 4:
			StartWaitTime(2, () =>
			{
				AdventureInteractiveIDTrigger adventureInteractiveIDTrigger = AdventureInteractiveIDTrigger.Generate();
				adventureInteractiveIDTrigger.interactiveID = "TutorialEnd";
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureInteractiveIDTrigger);
			});
			break;
		}
	}

	public override void OnTaskFinish(int taskId, bool isLastTask = false)
	{
		base.OnTaskFinish(taskId, isLastTask);
		switch (_subProcessIndex)
		{
		case 1:
			StartWaitTime(2, () =>
			{
				TriggerPerkSelect(perkIdList_CorePerk);
			});
			break;
		case 2:
			StartWaitTime(2, () =>
			{
				TriggerPerkSelect(perkIdList_NormalPerk);
			});
			break;
		}
		if (!isLastTask && waitTimeDic.TryGetValue(taskId, out var value))
		{
			StartWaitTime(value, () =>
			{
				TriggerNextTask();
			});
		}
		else
		{
			TriggerNextTask();
		}
	}

	public override void OnLevelEnd()
	{
		base.OnLevelEnd();
	}
}
