using System.Collections.Generic;
using TrueSync;

namespace AIScript.DynamicLevel;

public class TutorialLevelProcess_MarkMechanism : TutorialLevelProcessBase
{
	private readonly int buffId_Room = 911210110;

	private readonly Dictionary<int, string> operationTipsDic = new Dictionary<int, string>
	{
		[1210401] = "Tutorial_Mark",
		[1210402] = "Tutorial_MarkExp"
	};

	private readonly Dictionary<int, FP> waitTimeDic = new Dictionary<int, FP>();

	private readonly int tutorialCardId_Mark = 300112;

	private readonly string monsterSpawnWave_Mark_1 = "Wave_1_1";

	private readonly int guideId_Mark_1 = 11;

	private readonly FP guideDelayTime_Mark_1 = 3;

	private readonly int guideId_Mark_2 = 12;

	private readonly FP guideDelayTime_Mark_2 = 1.5;

	private readonly string interactiveId_Mark = "TutorialEnd";

	private readonly string monsterSpawnWave_Mark_2 = "Wave_2_1";

	private PlayerSkillCd _playerSkillCd;

	public override void OnLevelStart()
	{
		base.OnLevelStart();
		AddRoomBuff(buffId_Room);
		AddRoomBuff(911210410);
		StartWaitTime(0.5, () =>
		{
			TriggerNextTask(tutorialCardId_Mark, isLevelStart: true);
		});
		if (_playerSkillCd == null)
		{
			_playerSkillCd = _actor.GetLogicComponent<PlayerSkillCd>();
		}
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
			ActiveMonsterSpawnWave(monsterSpawnWave_Mark_1);
			StartWaitTime(1.5, () =>
			{
				TriggerGuide(guideId_Mark_1);
				_playerSkillCd.ReduceSkillSection(10331000);
			});
			StartWaitTime(5.5, () =>
			{
				_actor?.buffComponent.AddBuff(911210430, _actor);
				OpenTutorialCard(300117);
			});
			break;
		case 2:
			ActiveMonsterSpawnWave(monsterSpawnWave_Mark_2);
			_actor?.buffComponent.RemoveBuffByBuffId(911210410);
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

	protected override void OnGuideEnd(int guideId)
	{
		base.OnGuideEnd(guideId);
		if (guideId == guideId_Mark_1)
		{
			StartWaitTime(guideDelayTime_Mark_1, () =>
			{
				TriggerGuide(guideId_Mark_2);
			});
		}
		else if (guideId == guideId_Mark_2)
		{
			StartWaitTime(guideDelayTime_Mark_2, () =>
			{
				AdventureInteractiveIDTrigger adventureInteractiveIDTrigger = AdventureInteractiveIDTrigger.Generate();
				adventureInteractiveIDTrigger.interactiveID = interactiveId_Mark;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureInteractiveIDTrigger);
			});
		}
	}

	public override void OnTaskFinish(int taskId, bool isLastTask = false)
	{
		base.OnTaskFinish(taskId, isLastTask);
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
