using System.Collections.Generic;
using TrueSync;

namespace AIScript.DynamicLevel;

public class TutorialLevelProcess_MoveOperation : TutorialLevelProcessBase
{
	private readonly Dictionary<int, string> operationTipsDic = new Dictionary<int, string>
	{
		[1210201] = "Tutorial_Dash",
		[1210202] = "Tutorial_FastRun",
		[1210203] = "Tutorial_GuideEnd"
	};

	private readonly Dictionary<int, FP> waitTimeDic = new Dictionary<int, FP>
	{
		[1210201] = 2.5,
		[1210202] = 0,
		[1210203] = 0
	};

	private readonly int tutorialCardId_Dodge = 300108;

	private readonly string monsterSpawnWave_Dodge = "Wave_1_1";

	private readonly int tutorialCardId_Rush = 300109;

	public override void OnLevelStart()
	{
		base.OnLevelStart();
		EnableButtonControl("Fire2", isEnable: false);
		EnableButtonControl("Fire4", isEnable: false);
		EnableButtonControl("ActorSwitch1", isEnable: false);
		EnableButtonControl("ActorSwitch2", isEnable: false);
		EnableButtonControl("SwitchWithUltra1", isEnable: false);
		EnableButtonControl("SwitchWithUltra2", isEnable: false);
		StartWaitTime(1, () =>
		{
			TriggerNextTask(tutorialCardId_Dodge, isLevelStart: true);
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
			AddRoomBuff(911210210);
			ShowTutorialButtonHint("Fire1", isShow: true);
			break;
		case 2:
			AddRoomBuff(911210210);
			break;
		case 3:
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
		switch (_subProcessIndex)
		{
		case 1:
			AddRoomBuff(911210220);
			tutorialCardId = tutorialCardId_Rush;
			break;
		case 2:
			ShowTutorialButtonHint("Fire1", isShow: false);
			AddRoomBuff(911210220);
			break;
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
