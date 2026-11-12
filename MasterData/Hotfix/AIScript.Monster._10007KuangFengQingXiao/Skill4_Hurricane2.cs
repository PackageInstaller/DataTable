using System.Collections;
using TrueSync;

namespace AIScript.Monster._10007KuangFengQingXiao;

public class Skill4_Hurricane2 : SkillSimpleBase
{
	private readonly FP _rotateSpeed = 300;

	private readonly FP _duration = 0.8;

	private readonly FP _waitSeconds = 0;

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	private readonly ComboInputBuffer.ActionKey[] _actionKeys2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.I };

	private readonly string bullet1 = "Weapon_10007KuangFengQingXiao_Hurricane";

	private readonly string bullet2 = "Weapon_10007KuangFengQingXiao_StormShoot";

	private readonly string bullet3 = "Weapon_10007KuangFengQingXiao_GuideShootPlus2";

	private TSVector2 Shootdir;

	private FP rotation2 = 0;

	private long area1;

	protected override void OnSkillDisable()
	{
		if (area1 != 0L)
		{
			StopAreaEffect(area1);
			area1 = 0L;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitCustomEvent("TP_Start");
		HideSelf();
		Teleport(new TSVector2(0, 0));
		yield return WaitTime(0.2);
		CancelAttack();
		yield return WaitTime(0.1);
		ShowSelf();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginLookAtCameraDir(DirectionType.Down, default, 800);
		yield return WaitTime(0.1);
		BeginAttack(2, _actionKeys2);
		yield return WaitCustomEvent("Area_Start");
		area1 = PlayAreaEffect("AreaEffect_Skill4_Hurricane", GetPosition());
		FP t = 8;
		Shootdir = GetForward();
		for (FP intervaltime = 3; t >= 0; t -= intervaltime)
		{
			DoShoot(Shootdir, rotation2);
			yield return WaitTime(intervaltime);
			rotation2 += (FP)90;
		}
		yield return WaitTime(0);
		CancelAttack();
		StopAreaEffect(area1);
		area1 = 0L;
		yield return WaitTime(2);
	}

	private void DoShoot(TSVector2 Shootdir, FP rotation2)
	{
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		TSVector2 position = GetPosition();
		FP radius = 7;
		FP innerRadius = 6;
		FP angle = 5;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation2);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		GetEntityPosition(attackTarget);
		FanMultipleShoot(bullet2, AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 20, 1, shapeRandomPoint, 1.8, Shootdir, 0, AimType.Position, BulletDirectionType.BulletToTarget, 360, 3, 20, shapeRandomPoint);
	}
}
