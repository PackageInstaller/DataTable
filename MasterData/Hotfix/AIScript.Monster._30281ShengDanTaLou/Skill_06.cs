using System.Collections;
using TrueSync;

namespace AIScript.Monster._30281ShengDanTaLou;

public class Skill_06 : SkillSimpleBase
{
	private string Attack = "Skill06";

	private readonly TSVector2 BulletStartRight = new TSVector2(2, 0.55);

	private readonly TSVector2 BulletStartLeft = new TSVector2(-2.8, 1);

	private readonly FP BulletPositionY = 7.2;

	private readonly int ShootTimes = 2;

	private int ShootCount;

	private int BulletNum;

	private string BulletName;

	private TSVector2 ShootPosition;

	private TSVector2 TargetPosition;

	private DeterministicShape ShootShape;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ShootCount = 0;
		if (GetMonsterTagValue(_actor, 1) == "Lv3")
		{
			BulletName = "Bullet_30281_Skill06_Large";
			BulletNum = 3;
		}
		else if (GetMonsterTagValue(_actor, 1) == "Lv2")
		{
			BulletName = "Bullet_30281_Skill06_Small";
			BulletNum = 3;
		}
		else
		{
			BulletName = "Bullet_30281_Skill06_Small";
			BulletNum = 2;
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true, forceInterruptAttack: true);
		while (ShootCount < ShootTimes)
		{
			yield return null;
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "ThrowR")
		{
			ShootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), BulletStartRight);
			Shoot();
		}
		else if (eventName == "ThrowL")
		{
			ShootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), BulletStartLeft);
			Shoot();
		}
	}

	private void Shoot()
	{
		ShootShape = GetShapeData(DeterministicShape.ShapeType.Rectangle, new TSVector2(0, 0), 13, 28);
		for (int i = 0; i < BulletNum; i++)
		{
			TargetPosition = GetShapeRandomPoint(ShootShape, GetCurrentPlayer(), isReachable: true);
			CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.RandomDirection, alignShoot: true, 0, 1, 0, ShootPosition, BulletPositionY, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 0, 0, TargetPosition);
		}
		ShootCount++;
	}
}
