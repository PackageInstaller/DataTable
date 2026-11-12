using System.Collections;
using TrueSync;

namespace AIScript.Monster._72014KuiLeiShiTi;

public class Skill_PaiDi : SkillSimpleBase
{
	private LogicEntity Targetenemy;

	private readonly string combo_key1 = "Slam";

	private long WarningFX;

	private const int loopCount = 1;

	private int _currentLoopCount;

	private FP _initialRotation;

	private readonly FP rotateBackTime = 0.5;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_initialRotation = GetRotation();
	}

	protected override void OnSkillDisable()
	{
		StopEffect(WarningFX);
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.5, 7200);
		yield return WaitTime(0.5);
		_currentLoopCount = 0;
		BeginAttack(1, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		Skill_PaiDi skill_PaiDi = this;
		Skill_PaiDi skill_PaiDi2 = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_PaiDi.WarningFX = skill_PaiDi2.PlayEarlyWarningEffect("fx_warning_fan_140c_7r", 1.1f, default, position, rotation);
		yield return WaitTime(0.85);
		PlayEffect("fx_m72014_base_Skill3_LHand_ready", 1f, 0, GetPosition(), GetRotation(), 0.8f);
		PlayEffect("fx_m72014_base_Skill3_RHand_ready", 1f, 0, GetPosition(), GetRotation(), 0.8f);
		yield return WaitTime(0.25);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return StartCor(RotateToInitial(rotateBackTime));
	}

	protected override void OnComboLoop(int comboIndex)
	{
		if (comboIndex == 1)
		{
			_currentLoopCount++;
			if (_currentLoopCount >= 1)
			{
				CancelAttack();
			}
		}
	}

	private IEnumerator RotateToInitial(FP duration)
	{
		FP startRotation = GetRotation();
		FP delta;
		for (delta = _initialRotation - startRotation; delta > 180; delta -= (FP)360)
		{
		}
		for (; delta < -180; delta += (FP)360)
		{
		}
		FP elapsed = 0;
		while (elapsed < duration)
		{
			elapsed += LockStepManager.deltaTime;
			FP fP = elapsed / duration;
			if (fP > 1)
			{
				fP = 1;
			}
			_actor.tsTransform.Rotation = startRotation + delta * fP;
			yield return null;
		}
		_actor.tsTransform.Rotation = _initialRotation;
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
