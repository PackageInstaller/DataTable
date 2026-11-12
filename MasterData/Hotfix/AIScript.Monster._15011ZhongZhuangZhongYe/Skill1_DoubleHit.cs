using System.Collections;
using TrueSync;

namespace AIScript.Monster._15011ZhongZhuangZhongYe;

public class Skill1_DoubleHit : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack1_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] Attack2_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		BeginLookAt_NotWait(target, 0.4, 300);
		yield return WaitTime(0.4);
		BeginAttack(1, Attack1_Combo, flushInputedKeys: true);
		BeginLookAt_NotWait(target, 0.4, 300);
		yield return WaitTime(2.5);
		AimAtTarget(target, 60);
		yield return WaitTime(1.2);
		CancelAim();
		FP fP = CalcAngleBetweenSelfAndAttackTarget();
		if (_actor.DistanceWithRadius(target) <= 3.5f && fP <= 80)
		{
			BeginAttack(2, Attack2_Combo, flushInputedKeys: true, forceInterruptAttack: true);
			AddBuffToTarget(_actor, 990031100);
			yield return WaitTime(0.9);
			RemoveBuffFromTarget(_actor, 990031100);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
