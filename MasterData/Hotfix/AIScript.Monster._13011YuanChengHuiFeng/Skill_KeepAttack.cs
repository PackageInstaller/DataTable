using System.Collections;
using TrueSync;

namespace AIScript.Monster._13011YuanChengHuiFeng;

public class Skill_KeepAttack : SkillSimpleBase
{
	protected readonly FP disWithPlayer = 4;

	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	protected TSVector2 TargetPosition;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		LogicEntity attackTarget = GetAttackTarget();
		if (attackTarget != null)
		{
			TargetPosition = GetEntityPositionObsoleted(attackTarget);
		}
		while (Distance(TargetPosition, GetPosition()) >= disWithPlayer)
		{
			yield return WaitFrame(1);
			attackTarget = GetAttackTarget();
			if (attackTarget != null)
			{
				TargetPosition = GetEntityPositionObsoleted(attackTarget);
			}
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
