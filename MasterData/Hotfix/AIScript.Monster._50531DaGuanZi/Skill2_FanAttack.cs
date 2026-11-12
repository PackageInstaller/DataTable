using System.Collections;

namespace AIScript.Monster._50531DaGuanZi;

public class Skill2_FanAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private LogicEntity attackTarget;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ResetBlockPriority();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			attackTarget = GetAttackTarget();
		}
		else
		{
			attackTarget = GetCurrentPlayer();
		}
		SetBlockPriorityToStatic();
		yield return BeginLookAt(attackTarget, 0.3, 600);
		BeginAttack(1, startKey, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
