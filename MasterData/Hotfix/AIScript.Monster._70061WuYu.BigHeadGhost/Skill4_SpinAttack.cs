using System.Collections;
using TrueSync;

namespace AIScript.Monster._70061WuYu.BigHeadGhost;

public class Skill4_SpinAttack : SkillSimpleBase
{
	private const string ComboKeyReady = "Skill4_SpinAttack_Ready";

	private const string ComboKey = "Skill4_SpinAttack";

	private const string ChargeEndFxAlias = "fx_m70061_base_BigHeadGhost_Atk04_chargend";

	private static readonly FP ReadyFxAdvanceTime = 0.2;

	private static readonly FP ReadyDuration = 2;

	private static readonly FP SpinDuration = 3;

	private static readonly FP ChaseTickTime = 0.5;

	private static readonly FP ChaseStopDistance = 2;

	private CoroutineNode _chaseCor;

	protected override void OnSkillDisable()
	{
		StopCor(_chaseCor);
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		SetBlockPriorityToStatic();
		LogicEntity attackTarget = GetAttackTarget();
		if (attackTarget != null)
		{
			BeginLookAt_NotWait(attackTarget, 0.1, 360);
		}
		BeginAttack(0, "Skill4_SpinAttack_Ready", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(ReadyDuration - ReadyFxAdvanceTime);
		Skill4_SpinAttack skill4_SpinAttack = this;
		TSVector2 position = GetPosition();
		skill4_SpinAttack.PlayEffect("fx_m70061_base_BigHeadGhost_Atk04_chargend", 1f, default, position);
		yield return WaitTime(ReadyFxAdvanceTime);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(0, "Skill4_SpinAttack", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StartCor(ref _chaseCor, ChaseLoop());
		yield return WaitTime(SpinDuration);
		StopCor(_chaseCor);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator ChaseLoop()
	{
		while (true)
		{
			LogicEntity logicEntity = GetAttackTarget();
			if (logicEntity == null)
			{
				logicEntity = GetCurrentPlayer();
			}
			if (logicEntity == null)
			{
				yield return WaitTime(ChaseTickTime);
				continue;
			}
			BeginTrace(logicEntity, ChaseStopDistance, -1, ChaseTickTime);
			yield return WaitTraceFinish();
		}
	}
}
