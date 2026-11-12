using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._16011YuanChengFengCao;

public class Skill_WindBlow : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected void OnInterrupt()
	{
		RemoveBuffFromTarget(_actor, 160110110);
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		BeginLookAt_NotWait(target, 0.6, 240);
		yield return WaitTime(0.6);
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(target, 0.6, 120);
		yield return WaitTime(1.2);
		AddBuffToTarget(_actor, 160110110);
		float time = 4f;
		while (time > 0f)
		{
			TSVector2 pushaim = GetPosition() + TSVector2.Rotate(new TSVector2(0, 9.5f), _actor.tsTransform.Rotation);
			LogicEntity attackTarget = GetAttackTarget();
			time -= 0.1f;
			BeginTrace(target, 3, -1, 0.1);
			Push(attackTarget, pushaim);
			yield return WaitTime(0.1);
		}
		RemoveBuffFromTarget(_actor, 160110110);
		yield return WaitTime(0.2);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void Push(LogicEntity _pushTarget, TSVector2 pushaim)
	{
		if (!(_pushTarget == null))
		{
			FP fP = CalcAngleBetweenSelfAndAttackTarget();
			if (_actor.DistanceWithRadius(GetAttackTarget()) <= 4.5f && fP <= 60)
			{
				ILRuntimeAPI.ForceMoveByDistanceToPosition(_actor, pushaim, _pushTarget, 0.3f, 3, 4, 99, isPull: true, withRadius: true, isCoExist: true, isChangeForward: false);
			}
		}
	}
}
