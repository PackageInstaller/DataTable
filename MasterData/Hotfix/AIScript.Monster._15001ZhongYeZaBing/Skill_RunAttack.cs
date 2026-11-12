#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._15001ZhongYeZaBing;

public class Skill_RunAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Start_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] End_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private static readonly ComboInputBuffer.ActionKey[] Daze_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	protected readonly FP dash_spd = 4;

	protected readonly FP dash_angleLimit = 60;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		BeginLookAt_NotWait(target, 0.4, 300);
		yield return WaitTime(0.4);
		BeginAttack(1, Start_Combo, flushInputedKeys: true);
		FP fP = _actor.DistanceWithRadius(target);
		fP -= (FP)1;
		AddBuffToTarget(_actor, 150010110);
		FP time = fP / 4;
		FP tracetime = time + 1;
		yield return WaitTime(0.3);
		BeginTrace(target, 1, -1, tracetime);
		while (_actor.DistanceWithRadius(target) >= 2 && time > 0)
		{
			time -= (FP)0.1f;
			yield return WaitTime(0.1);
		}
		CancelAttack();
		RemoveBuffFromTarget(_actor, 150010110);
		FP distance = _actor.DistanceWithRadius(target);
		StartCoroutine(doCombo(distance));
		yield return WaitTime(4);
	}

	private IEnumerator doCombo(FP distance2)
	{
		LogicEntity attackTarget = GetAttackTarget();
		if (_actor.DistanceWithRadius(attackTarget) >= 2.1f)
		{
			BeginAttack(2, End_Combo, flushInputedKeys: true, forceInterruptAttack: true);
			NovaLogger.Debug("没追到玩家");
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return WaitTime(2);
		}
		else
		{
			NovaLogger.Debug("追击成功");
			BeginAttack(3, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
			BeginLookAt_NotWait(attackTarget, 0.4, 120);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return WaitTime(2);
		}
	}
}
