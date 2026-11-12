using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Summon_Born_Phase_2 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Born = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	protected TSVector2 TargetPosition;

	protected string HardLv;

	private Dictionary<string, int> Buffvalue = new Dictionary<string, int>
	{
		["Lv1"] = 40,
		["Lv2"] = 40,
		["Lv3"] = 60,
		["Lv4"] = 80,
		["Lv5"] = 99
	};

	private Dictionary<string, int> BuffId = new Dictionary<string, int>
	{
		["Lv1"] = 700010030,
		["Lv2"] = 700010030,
		["Lv3"] = 700010031,
		["Lv4"] = 700010032,
		["Lv5"] = 700010033
	};

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
		SetUnparalleledEnable();
		SetImmuneControlEnable(autoDisableWhenSkillDisable: false);
		SetSuperArmorEnable(autoDisableWhenSkillDisable: false);
		_actor.PauseMovementBlock();
		_actor.PauseMovementAvoidance();
		HardLv = GetMonsterTagValue((_actor as MonsterAdventureActor).monsterSummonInfo.SummonActor, 1);
		AddBuffToTarget(_actor, BuffId.get_Item(HardLv));
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Born, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		SetBattleOutDisable();
		ShowCenterHpBar();
	}
}
