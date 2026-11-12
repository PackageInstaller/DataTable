using System.Collections;
using TrueSync;

namespace AIScript.Monster._30911NuShou;

public class Skill01_SingleShoot_OneArrow : SkillSimpleBase
{
	private readonly string Shoot_Once = "Shoot_Once";

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginAttack(1, Shoot_Once, flushInputedKeys: true, forceInterruptAttack: true);
		yield return BeginLookAt(Targetenemy, 1.5, 180);
		CancelAttack();
		Shoot1();
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
		Shoot("Bullet_Arrow_Single", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1)), 1.5, 0, GetForward(), AimType.Position);
	}
}
