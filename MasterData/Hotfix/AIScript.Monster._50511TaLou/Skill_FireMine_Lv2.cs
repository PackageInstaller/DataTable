using System.Collections;
using TrueSync;

namespace AIScript.Monster._50511TaLou;

public class Skill_FireMine_Lv2 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Throw_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	private static readonly int ShootTimes = 2;

	private static readonly TSVector2 BulletOffsetRight = new TSVector2(2, 0.55);

	private static readonly TSVector2 BulletOffsetLeft = new TSVector2(-2.8, 1);

	private static readonly FP BulletPositionY = 7.2;

	private static readonly int BulletPerShoot = 4;

	private string BulletName;

	private int ShootCount;

	private TSVector2 ShootPosition;

	private DeterministicShape ShootShape;

	private int BulletPerShootCount;

	private TSVector2 TargetPosition;

	protected override void OnSkillEnable()
	{
		ShootCount = 0;
		BulletName = "Mine";
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Throw_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		while (ShootCount < ShootTimes)
		{
			yield return null;
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		ShootCount++;
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		BulletPerShootCount = 0;
		if (string.Equals(eventName, "ThrowR"))
		{
			ShootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), BulletOffsetRight);
		}
		else if (string.Equals(eventName, "ThrowL"))
		{
			ShootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), BulletOffsetLeft);
		}
		TSVector2 shootPosition = ShootPosition;
		FP radius = 18;
		FP innerRadius = 8;
		for (ShootShape = GetShapeData(DeterministicShape.ShapeType.Circle, shootPosition, default, default, radius, innerRadius); BulletPerShootCount < BulletPerShoot; BulletPerShootCount++)
		{
			TargetPosition = GetShapeRandomPoint(ShootShape, GetCurrentPlayer(), isReachable: true);
			CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.RandomDirection, alignShoot: true, 0, 1, 0, ShootPosition, BulletPositionY, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 0, 0, TargetPosition);
		}
	}
}
