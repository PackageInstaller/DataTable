using System.Collections;
using TrueSync;

namespace AIScript.Monster._Wind._50301MaoDa;

public class Wind_Attack02_Nuji_Atk02 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey._1
	};

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.1);
		DoWave();
		yield return WaitTime(1.05);
		CancelAttack();
		yield return WaitCustomEvent("Shoot");
		if (GetBuffNum(_actor, 503010001) == 3 || GetBuffNum(_actor, 503010001) == 6)
		{
			_actor.buffComponent.RemoveBuffByBuffId(503010001, 3);
			DoShoot();
			yield return WaitTime(0.3);
			DoShoot();
			yield return WaitTime(0.3);
			DoShoot();
		}
		else
		{
			_actor.buffComponent.RemoveBuffByBuffId(503010001, 1);
			DoShoot();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void DoShoot()
	{
		TSVector2 position = GetPosition();
		TSVector2 forward = GetForward();
		CircleMultipleShoot("Bullet_50301_MaoDa_Skill02_Nuji_Atk02", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, position, 1, forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0.2);
	}

	protected void DoWave()
	{
		TSVector2 position = GetPosition();
		TSVector2 forward = GetForward();
		CircleMultipleShoot("Bullet_50301_MaoDa_Skill02_Nuji_Atk02_Wave", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, position, 0, forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
	}
}
