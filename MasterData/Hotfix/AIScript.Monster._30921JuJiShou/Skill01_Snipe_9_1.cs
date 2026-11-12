using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._30921JuJiShou;

public class Skill01_Snipe_9_1 : SkillSimpleBase
{
	private readonly string Shoot_Keep = "Shoot_Keep";

	private readonly FP AimTime = 2;

	private readonly string ShootLine = "FX/Warning/fx_warning_line_0_5h_45m_2w";

	private LogicEntity Targetenemy;

	private long AimLine;

	private CoroutineNode Distance1Node;

	private FP FarDistance;

	private FP CloseDistance;

	private FP IntervalTime;

	protected override void OnSkillEnable()
	{
		StartCor(CheckShootDistance());
		FarDistance = CommonUtils.ParseStringParamToFP(GetMonsterTagValue(_actor, 2));
		CloseDistance = CommonUtils.ParseStringParamToFP(GetMonsterTagValue(_actor, 3));
		IntervalTime = CommonUtils.ParseStringParamToFP(GetMonsterTagValue(_actor, 4));
		TSVector2 position = GetPosition();
		PlayEffect("fx_m30921_base_FlashBomb_hide_start", 1f, default, position, default, 1.25f);
	}

	protected override void OnSkillDisable()
	{
		StopEffect(AimLine);
		StopCor(Distance1Node);
		TSVector2 position = GetPosition();
		PlayEffect("fx_m30921_base_FlashBomb_hide_start", 1f, default, position, default, 1.25f);
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginAttack(1, "Shoot_Start_9_1", flushInputedKeys: true, forceInterruptAttack: true);
		while (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) >= 30)
		{
			yield return null;
		}
		AimLine = PlayEffect(ShootLine);
		yield return BeginLookAtMonsterTarget(AimTime, 75);
		ReplaceAnimationGroup();
		CancelAttack();
		StopEffect(AimLine);
		Shoot1();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(IntervalTime);
		yield return BeginLookAtMonsterTarget(0.1, 9999);
		while (true)
		{
			AimLine = PlayEffect(ShootLine);
			GetEnemy();
			yield return BeginLookAtMonsterTarget(AimTime, 75);
			BeginAttack(2, Shoot_Keep, flushInputedKeys: true, forceInterruptAttack: true);
			StopEffect(AimLine);
			Shoot1();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return WaitTime(IntervalTime);
			yield return BeginLookAtMonsterTarget(0.1, 9999);
		}
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	private void Shoot1()
	{
		Shoot("Bullet_Snipe_9_1", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1.1)), 1, 0, GetForward(), AimType.Position);
	}

	private IEnumerator CheckShootDistance()
	{
		while (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) < FarDistance && GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) > CloseDistance)
		{
			yield return null;
		}
		InterruptAttack();
		InterruptSkill();
	}
}
