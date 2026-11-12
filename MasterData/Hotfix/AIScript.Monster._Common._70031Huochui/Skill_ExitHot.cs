using System.Collections;

namespace AIScript.Monster._Common._70031Huochui;

public class Skill_ExitHot : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.Y,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] _actionKey2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.Y,
		ComboInputBuffer.ActionKey._2
	};

	private LogicEntity AttackTarget;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey1);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(2, _actionKey2);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
