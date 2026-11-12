using System.Collections.Generic;
using TrueSync;

namespace AIScript.DynamicLevel;

public class TutorialLevelProcess_BasicOperation : TutorialLevelProcessBase
{
	private readonly int buffId_Room = 911210110;

	private readonly Dictionary<int, string> operationTipsDic = new Dictionary<int, string>
	{
		[1210101] = "Tutorial_Attack",
		[1210102] = "Tutorial_Skill",
		[1210103] = "Tutorial_Charge",
		[1210104] = "Tutorial_UltraSkill",
		[1210105] = "Tutorial_GuideEnd"
	};

	private readonly Dictionary<int, FP> waitTimeDic = new Dictionary<int, FP>
	{
		[1210101] = 2.5,
		[1210102] = 2.5,
		[1210103] = 0,
		[1210104] = 0
	};

	private readonly int tutorialCardId_NormalAttack = 300105;

	private readonly string monsterSpawnWave_NormalAttack_1 = "Wave_1_1";

	private readonly string monsterSpawnWave_NormalAttack_2 = "Wave_1_2";

	private readonly int tutorialCardId_Skill = 300106;

	private readonly string monsterSpawnWave_Skill = "Wave_2_1";

	private readonly int tutorialCardId_Charge = 300107;

	private readonly int buffId_Charge = 911210120;

	private readonly string monsterSpawnWave_Charge = "Wave_3_1";

	private readonly int buffId_UltraSkill = 911210130;

	public override void OnLevelStart()
	{
		base.OnLevelStart();
		EnableButtonControl("ActorSwitch1", isEnable: false);
		EnableButtonControl("ActorSwitch2", isEnable: false);
		EnableButtonControl("SwitchWithUltra1", isEnable: false);
		EnableButtonControl("SwitchWithUltra2", isEnable: false);
		AddRoomBuff(buffId_Room);
		StartWaitTime(0.5, () =>
		{
			TriggerNextTask(tutorialCardId_NormalAttack, isLevelStart: true);
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
			ActiveMonsterSpawnWave(monsterSpawnWave_NormalAttack_1);
			break;
		case 2:
			ActiveMonsterSpawnWave(monsterSpawnWave_Skill);
			ShowTutorialButtonHint("Fire2", isShow: true);
			break;
		case 3:
			_actor?.buffComponent.AddBuff(buffId_Charge, _actor);
			ActiveMonsterSpawnWave(monsterSpawnWave_Charge);
			break;
		case 4:
			_actor?.buffComponent.AddBuff(buffId_UltraSkill, _actor);
			ShowTutorialButtonHint("Fire4", isShow: true);
			break;
		case 5:
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
		if (_subProcessIndex == 1 && string.Equals(waveClearEvent.wave, monsterSpawnWave_NormalAttack_1))
		{
			ActiveMonsterSpawnWave(monsterSpawnWave_NormalAttack_2);
		}
	}

	public override void OnTaskFinish(int taskId, bool isLastTask = false)
	{
		base.OnTaskFinish(taskId, isLastTask);
		int tutorialCardId = 0;
		switch (_subProcessIndex)
		{
		case 1:
			tutorialCardId = tutorialCardId_Skill;
			break;
		case 2:
			ShowTutorialButtonHint("Fire2", isShow: false);
			tutorialCardId = tutorialCardId_Charge;
			break;
		case 4:
			ShowTutorialButtonHint("Fire4", isShow: false);
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
