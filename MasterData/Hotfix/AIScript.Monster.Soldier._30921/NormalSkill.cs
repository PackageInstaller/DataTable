using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.Soldier._30921;

public class NormalSkill : SkillSimpleBase
{
	private readonly string Shoot_Start = "NormalAttack_Start";

	private readonly string Shoot_Keep = "NormalAttack_Keep";

	private readonly FP AimTime = 1.5;

	private readonly int ShootTimes = 9999;

	private LogicEntity Targetenemy;

	private long AimLine;

	private long FX1;

	private long FX2;

	private long FX3;

	private CoroutineNode Distance1Node;

	private readonly List<LogicEntity> _searchEntities = new List<LogicEntity>();

	protected override void OnSkillDisable()
	{
		StopEffect(AimLine);
		StopEffect(FX1);
		StopEffect(FX2);
		StopEffect(FX3);
		StopCor(Distance1Node);
		ReplaceAnimationGroup(1);
	}

	protected override IEnumerator DoMainLogic()
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
		AimLine = PlayEffect("fx_warning_line_1h_15m");
		for (int i = 0; i < ShootTimes - 2; i++)
		{
			GetEnemy();
			yield return BeginLookAt(Targetenemy, AimTime, 120);
			BeginAttack(2, Shoot_Keep, flushInputedKeys: true, forceInterruptAttack: true);
			StopEffect(AimLine);
			Shoot1();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			AimLine = PlayEffect("fx_warning_line_1h_15m");
		}
	}

	private void GetEnemy()
	{
		Targetenemy = ((SoldierActor)_actor).FindNearestConfrontTarget();
	}

	private void Shoot1()
	{
		Shoot("Bullet_Snipe_NormalAttack_Soldier", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1.1)), 1, 0, GetForward(), AimType.Position);
	}
}
