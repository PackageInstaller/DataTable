using System.Collections;
using TrueSync;

namespace AIScript.Monster._30921JuJiShou;

public class Skill01_Snipe : SkillSimpleBase
{
	private readonly string Shoot_Start = "Shoot_Start";

	private readonly string Shoot_Keep = "Shoot_Keep";

	private readonly string Shoot_End = "Shoot_End";

	private readonly FP ShootRange = 20;

	private readonly FP EscapeRange = 5;

	private readonly FP AimTime = 2;

	private readonly int ShootTimes = 99;

	private LogicEntity Targetenemy;

	private long AimLine;

	private long FX1;

	private long FX2;

	private long FX3;

	private CoroutineNode Distance1Node;

	protected override void OnSkillDisable()
	{
		StopEffect(AimLine);
		StopEffect(FX1);
		StopEffect(FX2);
		StopEffect(FX3);
		StopCor(Distance1Node);
		ReplaceAnimationGroup(1);
		SetLogicTagToggleValue(_actor, "FlashBombEnd", value: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		if (GetLogicTagToggleValue(_actor, "FlashBombEnd"))
		{
			ReplaceAnimationGroup();
			FX1 = PlayEffect("fx_m30921_loop_atk_wepon_glow");
			FX2 = PlayEffect("fx_m30921_loop_atk_charge");
			FX3 = PlayEffect("fx_m30921_loop_atk_aim");
		}
		else
		{
			GetEnemy();
			BeginAttack(1, Shoot_Start, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("FX1");
			FX1 = PlayEffect("fx_m30921_loop_atk_wepon_glow");
			yield return WaitCustomEvent("Aim");
			FX2 = PlayEffect("fx_m30921_loop_atk_charge");
			FX3 = PlayEffect("fx_m30921_loop_atk_aim");
			AimLine = PlayEffect("fx_warning_line_1h_15m");
			yield return BeginLookAt(Targetenemy, AimTime, 120);
			ReplaceAnimationGroup();
			CancelAttack();
			StopEffect(AimLine);
			Shoot1();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		AimLine = PlayEffect("fx_warning_line_1h_15m");
		for (int i = 0; i < ShootTimes - 2; i++)
		{
			if (i == 1)
			{
				StartCor(ref Distance1Node, Distance1());
			}
			if (!(GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= ShootRange))
			{
				break;
			}
			GetEnemy();
			yield return BeginLookAt(Targetenemy, AimTime, 120);
			BeginAttack(2, Shoot_Keep, flushInputedKeys: true, forceInterruptAttack: true);
			StopEffect(AimLine);
			Shoot1();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			AimLine = PlayEffect("fx_warning_line_1h_15m");
		}
		StopCor(Distance1Node);
		GetEnemy();
		yield return BeginLookAt(Targetenemy, AimTime, 120);
		BeginAttack(3, Shoot_End, flushInputedKeys: true, forceInterruptAttack: true);
		ReplaceAnimationGroup(1);
		StopEffect(AimLine);
		Shoot1();
		yield return WaitCustomEvent("AimEnd");
		StopEffect(AimLine);
		StopEffect(FX1);
		StopEffect(FX2);
		StopEffect(FX3);
		yield return WaitCombo(ComboAttackType.isComboFinish);
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
		Shoot("Bullet_Snipe", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1.1)), 1, 0, GetForward(), AimType.Position);
	}

	private IEnumerator Distance1()
	{
		for (FP t = 0; t <= 180; t += _actor.LogicDeltaTime)
		{
			if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= EscapeRange && !GetLogicTagToggleValue(_actor, "FlashBomb"))
			{
				InterruptSkill();
				break;
			}
			yield return null;
		}
	}
}
