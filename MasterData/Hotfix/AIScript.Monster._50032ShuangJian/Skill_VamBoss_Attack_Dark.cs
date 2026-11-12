using System.Collections;

namespace AIScript.Monster._50032ShuangJian;

public class Skill_VamBoss_Attack_Dark : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] BlackAttack01 = new ComboInputBuffer.ActionKey[1];

	private static readonly string TurnToTargetStart = "Start";

	private static readonly string TurnToTargetEnd = "End";

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		BeginLookAt_NotWait(logicEntity, 0.3, 720);
		yield return WaitTime(0.3);
		BeginAttack(1, BlackAttack01, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
