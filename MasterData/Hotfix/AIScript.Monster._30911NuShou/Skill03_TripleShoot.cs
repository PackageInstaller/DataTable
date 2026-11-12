using System.Collections;
using TrueSync;

namespace AIScript.Monster._30911NuShou;

public class Skill03_TripleShoot : SkillSimpleBase
{
	private readonly string Shoot_Triple = "Shoot_Triple";

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginAttack(1, Shoot_Triple, flushInputedKeys: true, forceInterruptAttack: true);
		yield return BeginLookAt(Targetenemy, 1.5, 180);
		CancelAttack();
		Shoot1();
		yield return WaitCustomEvent("Fire2");
		Shoot1();
		yield return WaitCustomEvent("Fire3");
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
		Shoot("Bullet_Arrow_TripleShoot", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1)), 1.5, 0, GetForward(), AimType.Position);
	}
}
