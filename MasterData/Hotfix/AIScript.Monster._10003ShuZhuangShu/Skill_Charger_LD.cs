#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._10003ShuZhuangShu;

public class Skill_Charger_LD : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _ChargerCombo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private readonly ComboInputBuffer.ActionKey[] _AttackCombo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._0 };

	private readonly ComboInputBuffer.ActionKey[] _JumpCombo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._1 };

	private readonly FP StopDistance = 4.5;

	private readonly FP Inr = 0.2;

	private readonly FP TurnTime = 0.5;

	private readonly FP Speed = 22;

	private FP SpaceBetween;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _ChargerCombo);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		BeginTrace(GetAttackTarget(), 3, -1, 99);
		for (FP i = Inr; i < 3; i += Inr)
		{
			SpaceBetween = Distance(GetPosition(), GetEntityPositionObsoleted(GetAttackTarget()));
			if (GetAttackTarget() == null || SpaceBetween <= StopDistance)
			{
				CancelAttack();
				yield return WaitCombo(ComboAttackType.isRecoveryBegin);
				BeginAttack(3, _AttackCombo, flushInputedKeys: true, forceInterruptAttack: true);
				NovaLogger.Debug("停止冲锋");
				StopTrace();
				yield return WaitCombo(ComboAttackType.isComboFinish);
				InterruptSkill();
			}
			yield return WaitTime(Inr);
		}
		CancelAttack();
		yield return WaitTime(0.3);
		StopTrace();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(4, _JumpCombo, flushInputedKeys: true);
		BeginLookAt(GetAttackTarget(), TurnTime, 720);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StopLookAt();
		SpaceBetween = Distance(GetPosition(), GetEntityPositionObsoleted(GetAttackTarget()));
		if (SpaceBetween / Speed > 0.5f)
		{
			SpaceBetween = 0.5f * Speed;
			BeginDashActorForward(4, Speed, SpaceBetween, 360, comboWithAttack: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			InterruptSkill();
		}
		else
		{
			BeginDashActorForward(4, Speed, SpaceBetween, 360, comboWithAttack: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			InterruptSkill();
		}
		yield return WaitTime(1);
	}
}
