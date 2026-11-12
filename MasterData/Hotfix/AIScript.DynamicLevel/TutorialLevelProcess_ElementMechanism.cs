using System.Collections.Generic;
using TrueSync;

namespace AIScript.DynamicLevel;

public class TutorialLevelProcess_ElementMechanism : TutorialLevelProcessBase
{
	private readonly int buffId_Room = 911210110;

	private readonly Dictionary<int, string> operationTipsDic = new Dictionary<int, string>
	{
		[1210501] = "Tutorial_WeekEle",
		[1210502] = "Tutorial_PowerfulEle",
		[1210503] = "Tutorial_CommonEle",
		[1210504] = "Tutorial_GuideEnd"
	};

	private readonly Dictionary<int, FP> waitTimeDic = new Dictionary<int, FP>
	{
		[1210501] = 2.5,
		[1210502] = 2.5
	};

	private readonly int tutorialCardId_Element = 300113;

	private readonly string monsterSpawnWave_Element_1 = "Wave_1_1";

	private readonly string monsterSpawnWave_Element_2 = "Wave_1_2";

	private readonly string monsterSpawnWave_Element_3 = "Wave_1_3";

	public override void OnLevelStart()
	{
		base.OnLevelStart();
		AddRoomBuff(buffId_Room);
		EnableButtonControl("ActorSwitch1", isEnable: false);
		EnableButtonControl("ActorSwitch2", isEnable: false);
		EnableButtonControl("SwitchWithUltra1", isEnable: false);
		EnableButtonControl("SwitchWithUltra2", isEnable: false);
		StartWaitTime(0.5, () =>
		{
			TriggerNextTask(tutorialCardId_Element, isLevelStart: true);
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
			ActiveMonsterSpawnWave(monsterSpawnWave_Element_1);
			break;
		case 2:
			ActiveMonsterSpawnWave(monsterSpawnWave_Element_2);
			break;
		case 3:
			ActiveMonsterSpawnWave(monsterSpawnWave_Element_3);
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
		int tutorialCardId = 0;
		if (_subProcessIndex == 4)
		{
			tutorialCardId = 300114;
		}
		if (!isLastTask && waitTimeDic.TryGetValue(taskId, out var value))
		{
			StartWaitTime(value, () =>
			{
				TriggerNextTask(tutorialCardId);
			});
		}
		else
		{
			TriggerNextTask(tutorialCardId);
		}
	}

	public override void OnLevelEnd()
	{
		base.OnLevelEnd();
	}
}
