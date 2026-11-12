using System.Collections.Generic;
using TrueSync;

namespace AIScript.DynamicLevel;

public class TutorialLevelProcess_SupportOperation : TutorialLevelProcessBase
{
	private readonly int buffId_Room = 911210110;

	private readonly Dictionary<int, string> operationTipsDic = new Dictionary<int, string>
	{
		[1210301] = "Tutorial_SupportSkill",
		[1210303] = "Tutorial_Charge",
		[1210304] = "Tutorial_SupportUltraSkill",
		[1210306] = "Tutorial_GuideEnd"
	};

	private readonly Dictionary<int, FP> waitTimeDic = new Dictionary<int, FP>
	{
		[1210301] = 0,
		[1210302] = 2.5,
		[1210303] = 0,
		[1210304] = 0,
		[1210305] = 0,
		[1210306] = 0
	};

	private readonly int tutorialCardId_SupportSkill = 300110;

	private readonly int buffId_SupportSkill = 911210310;

	private readonly string monsterSpawnWave_SupportSkill = "Wave_1_1";

	private readonly int tutorialCardId_SupportUltraSkill = 300111;

	private readonly int buffId_SupportUltraSkill = 911210320;

	private readonly string monsterSpawnWave_SupportUltraSkill_1 = "Wave_2_1";

	private readonly string monsterSpawnWave_SupportUltraSkill_2 = "Wave_2_2";

	private readonly int monsterCount_TriggerSecondWave;

	public override void OnLevelStart()
	{
		base.OnLevelStart();
		AddRoomBuff(buffId_Room);
		StartWaitTime(0.5, () =>
		{
			TriggerNextTask(tutorialCardId_SupportSkill, isLevelStart: true);
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
			ActiveMonsterSpawnWave(monsterSpawnWave_SupportSkill);
			ShowTutorialButtonHint("ActorSwitch1", isShow: true);
			ShowTutorialButtonHint("ActorSwitch2", isShow: true);
			break;
		case 2:
			ActiveMonsterSpawnWave("Wave_1_2");
			break;
		case 3:
			_actor?.buffComponent.AddBuff(buffId_SupportUltraSkill, _actor);
			ActiveMonsterSpawnWave(monsterSpawnWave_SupportUltraSkill_1);
			break;
		case 4:
			ShowTutorialButtonHint("SwitchWithUltra1", isShow: true);
			ShowTutorialButtonHint("SwitchWithUltra2", isShow: true);
			break;
		case 5:
			ActiveMonsterSpawnWave("Wave_2_2");
			break;
		case 6:
			StartWaitTime(2, () =>
			{
				AdventureInteractiveIDTrigger adventureInteractiveIDTrigger = AdventureInteractiveIDTrigger.Generate();
				adventureInteractiveIDTrigger.interactiveID = "TutorialEnd";
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureInteractiveIDTrigger);
			});
			break;
		}
	}

	protected override void OnRoomWaveMonsterCleared(AdventureLevelRoomWaveMonsterClearedEvent waveClearEvent)
	{
		base.OnRoomWaveMonsterCleared(waveClearEvent);
		if (string.Equals(waveClearEvent.wave, monsterSpawnWave_SupportSkill))
		{
			if (_subProcessIndex == 1)
			{
				ActiveMonsterSpawnWave(monsterSpawnWave_SupportSkill);
			}
		}
		else if (string.Equals(waveClearEvent.wave, monsterSpawnWave_SupportUltraSkill_1) && (_subProcessIndex == 3 || _subProcessIndex == 4))
		{
			ActiveMonsterSpawnWave(monsterSpawnWave_SupportUltraSkill_1);
		}
	}

	public override void OnTaskFinish(int taskId, bool isLastTask = false)
	{
		base.OnTaskFinish(taskId, isLastTask);
		int tutorialCardId = 0;
		switch (_subProcessIndex)
		{
		case 2:
			ShowTutorialButtonHint("ActorSwitch1", isShow: false);
			ShowTutorialButtonHint("ActorSwitch2", isShow: false);
			tutorialCardId = tutorialCardId_SupportUltraSkill;
			break;
		case 4:
			ShowTutorialButtonHint("SwitchWithUltra1", isShow: false);
			ShowTutorialButtonHint("SwitchWithUltra2", isShow: false);
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
