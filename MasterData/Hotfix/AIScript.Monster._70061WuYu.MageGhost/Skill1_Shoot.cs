using System.Collections;

namespace AIScript.Monster._70061WuYu.MageGhost;

public class Skill1_Shoot : SkillSimpleBase
{
	private const string ComboKey_P1 = "Shoot";

	private const string ComboKey_P2 = "Shoot_Plus";

	protected override IEnumerator DoMainLogic()
	{
		int num = GetSummonerPhase();
		AdventureActor entity = _actor.GetLogicComponent<MonsterSummonInfo>()?.SummonActor;
		if (num < 2 && GetLogicTagToggleValue(entity, "FastExplodeTagId"))
		{
			num = 2;
		}
		string actionKey = ((num >= 2) ? "Shoot_Plus" : "Shoot");
		LogicEntity attackTarget = GetAttackTarget();
		if (attackTarget != null)
		{
			BeginLookAt_NotWait(attackTarget, 0.1, 360);
		}
		BeginAttack(0, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private int GetSummonerPhase()
	{
		AdventureActor adventureActor = _actor.GetLogicComponent<MonsterSummonInfo>()?.SummonActor;
		if (adventureActor == null)
		{
			return 1;
		}
		int num = GetLogicTagFpValue(adventureActor, "Phase").AsInt();
		if (num < 1)
		{
			num = 1;
		}
		return num;
	}
}
