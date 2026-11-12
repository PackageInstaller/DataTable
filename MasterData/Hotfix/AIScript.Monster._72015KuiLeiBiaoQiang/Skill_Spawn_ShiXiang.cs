using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72015KuiLeiBiaoQiang;

public class Skill_Spawn_ShiXiang : SkillSimpleBase
{
	private string monsterType;

	protected override void OnSkillDisable()
	{
		RemoveBuffFromTarget(_actor, 990020140);
		ShowBlood(isShow: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return null;
		monsterType = GetMonsterTagValue(_actor, 5);
		ReplaceAnimationGroup();
		SetBlockPriorityToStatic();
		SetSearchedImmunityEnable();
		ShowBlood(isShow: false);
		BeginAttack(0, "ShiXiangIdle", flushInputedKeys: true, forceInterruptAttack: true);
		if (monsterType == "NotTurn")
		{
			while (true)
			{
				yield return null;
			}
		}
		if (monsterType == "Turn")
		{
			while (true)
			{
				if (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) <= 10)
				{
					BeginLookAt(GetCurrentPlayer(), 0.1, 40);
					yield return WaitTime(0.2);
				}
				else
				{
					yield return WaitTime(0.5);
				}
			}
		}
		if (!(monsterType == "Battle"))
		{
			yield break;
		}
		while ((GetBuffNum(_actor, 720140160) > 0 && _actor.actorHealthInfo.hpPercentage == (FP)1) || (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) > 10 && _actor.actorHealthInfo.hpPercentage != (FP)1))
		{
			yield return null;
		}
		List<LogicEntity> list = new List<LogicEntity>();
		list.AddRange(GetTargetsByFaction(isFriend: true));
		foreach (LogicEntity item in list)
		{
			RemoveBuffFromTarget(item, 720140160);
		}
		TriggerOpLisener("Mainline10_2_FinalBattle");
		BeginLookAt(GetCurrentPlayer(), 0.25, 720);
		PlayEffect("fx_common_base_charge_monster_2", 1f, 1.5f, GetPosition(), default, 0.6f);
		yield return WaitTime(0.25);
		RemoveBuffFromTarget(_actor, 720140150);
		PlayWwiseSound("amb_Ruin_stonechange", _actor);
		ReplaceAnimationGroup(1);
		InterruptAttack();
		Action();
	}
}
