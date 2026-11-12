using System.Collections;

namespace AIScript.Monster._16001JinZhanFengCao;

public class Skill_UnderGround : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private bool hasBuff;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		AddBuffToTarget(_actor, 990013100);
		AddBuffToTarget(_actor, 990021100);
		SetBlockPriorityToStatic();
		StartCoroutine(CheckBuff());
		yield return WaitCombo(ComboAttackType.isComboFinish);
		InterruptSkill();
	}

	private IEnumerator CheckBuff()
	{
		while (true)
		{
			hasBuff = _actor.buffComponent.CheckBuffByBuffID(160210110);
			if (hasBuff)
			{
				CancelAttack();
				RemoveBuffFromTarget(_actor, 990013100);
				RemoveBuffFromTarget(_actor, 990021100);
				ResetBlockPriority();
			}
			yield return WaitTime(0.2);
		}
	}
}
