using System.Collections.Generic;
using TrueSync;

namespace AIScript.DynamicLevel;

public class TutorialLevelProcess_MonsterToughnessMechanism : TutorialLevelProcessBase
{
	private readonly int buffId_Room = 911210110;

	private readonly Dictionary<int, string> operationTipsDic = new Dictionary<int, string>
	{
		[1210801] = "Tutorial_ThoughnessGuide_1",
		[1210802] = "Tutorial_ThoughnessGuide_2"
	};

	private readonly Dictionary<int, FP> waitTimeDic = new Dictionary<int, FP> { [1210801] = 1.5 };

	private readonly int tutorialCardId_Toughness = 300115;

	private readonly string monsterSpawnWave_Toughness = "Wave_1_1";

	private readonly int tutorialCardId_BreakToughness = 300116;

	public override void OnLevelStart()
	{
		base.OnLevelStart();
		AddRoomBuff(buffId_Room);
		StartWaitTime(1.5, () =>
		{
			TriggerNextTask(tutorialCardId_Toughness, isLevelStart: true);
		});
	}

	public override void OnTriggerNextTask(int taskId)
	{
		base.OnTriggerNextTask(taskId);
		if (operationTipsDic.TryGetValue(taskId, out var value))
		{
			UpdateOperationTips(value);
		}
		if (_subProcessIndex == 3)
		{
			StartWaitTime(4.5, () =>
			{
				AdventureInteractiveIDTrigger adventureInteractiveIDTrigger = AdventureInteractiveIDTrigger.Generate();
				adventureInteractiveIDTrigger.interactiveID = "TutorialEnd";
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureInteractiveIDTrigger);
			});
		}
	}

	public override void OnTaskFinish(int taskId, bool isLastTask = false)
	{
		base.OnTaskFinish(taskId, isLastTask);
		int tutorialCardId = 0;
		if (_subProcessIndex == 1)
		{
			tutorialCardId = tutorialCardId_BreakToughness;
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
