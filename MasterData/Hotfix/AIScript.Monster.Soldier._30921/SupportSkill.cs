using System.Collections;
using TrueSync;

namespace AIScript.Monster.Soldier._30921;

public class SupportSkill : SkillSimpleBase
{
	private readonly string Shoot_Start = "NormalAttack_Start";

	private readonly string Shoot_Keep = "NormalAttack_Keep";

	private readonly string Support_End = "SupportSkill_End";

	private readonly FP AimTime = 1.5;

	private readonly int shootCount = 4;

	private const int buffSupport_2 = 250106002;

	private readonly FP AimTime_3 = 1;

	private readonly int shootCount_3 = 6;

	private LogicEntity Targetenemy;

	private long AimLine;

	private long FX1;

	private long FX2;

	private long FX3;

	private CoroutineNode Distance1Node;

	private int PotentialLv = 1;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		StopEffect(AimLine);
		StopEffect(FX1);
		StopEffect(FX2);
		StopEffect(FX3);
		StopCor(Distance1Node);
		ReplaceAnimationGroup(1);
		if (PotentialLv >= 2 && _actor.buffComponent.CheckBuffByBuffID(250106002))
		{
			_actor.buffComponent.RemoveBuffByBuffId(250106002);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		_ = _actor.LogicTime;
		FP tmpAimTime = ((PotentialLv >= 3) ? AimTime_3 : AimTime);
		int tmpShootCount = ((PotentialLv >= 3) ? (shootCount_3 - 2) : (shootCount - 2));
		GetEnemy();
		BeginAttack(1, Shoot_Start, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("FX1");
		FX1 = PlayEffect("fx_m30921_loop_atk_wepon_glow");
		yield return WaitCustomEvent("Aim");
		FX2 = PlayEffect("fx_m30921_loop_atk_charge");
		FX3 = PlayEffect("fx_m30921_loop_atk_aim");
		AimLine = PlayEffect("fx_warning_line_1h_15m");
		yield return BeginLookAt(Targetenemy, tmpAimTime, 120);
		ReplaceAnimationGroup();
		CancelAttack();
		StopEffect(AimLine);
		Shoot1();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		AimLine = PlayEffect("fx_warning_line_1h_15m");
		int shootC = 0;
		while (shootC < tmpShootCount)
		{
			shootC++;
			GetEnemy();
			yield return BeginLookAt(Targetenemy, tmpAimTime, 120);
			BeginAttack(2, Shoot_Keep, flushInputedKeys: true, forceInterruptAttack: true);
			StopEffect(AimLine);
			Shoot1();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			AimLine = PlayEffect("fx_warning_line_1h_15m");
		}
		GetEnemy();
		yield return BeginLookAt(Targetenemy, tmpAimTime, 120);
		BeginAttack(3, Support_End, flushInputedKeys: true, forceInterruptAttack: true);
		StopEffect(AimLine);
		Shoot1();
		yield return WaitTime(0.1);
		ReplaceAnimationGroup(1);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetEnemy()
	{
		Targetenemy = ((SoldierActor)_actor).FindNearestConfrontTarget();
	}

	private void Shoot1()
	{
		Shoot("Bullet_Snipe_Support_Soldier", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1.1)), 1, 0, GetForward(), AimType.Position);
	}
}
