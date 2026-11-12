using System.Collections;
using TrueSync;

namespace AIScript.Monster._Boss._Dark._50251ShanDianLieQuan;

public class MiniBoss_Dark_ShadowDash : SkillSimpleBase
{
	private readonly string ShadowDash = "ShadowDash";

	private readonly FP ShadowDistance = 10;

	private readonly FP DashGap = 0.9;

	private TSVector2 HomePos;

	private DeterministicShape ShadowShape;

	private TSVector2 LastPoint;

	private TSVector2 Point1;

	private TSVector2 Point2;

	private TSVector2 Point3;

	protected override void OnSkillEnable()
	{
		HomePos = new TSVector2(0, 0);
		TSVector2 homePos = HomePos;
		FP radius = 14;
		FP innerRadius = 13;
		ShadowShape = GetShapeData(DeterministicShape.ShapeType.Circle, homePos, default, default, radius, innerRadius);
		LastPoint = new TSVector2(0, 0);
	}

	protected override IEnumerator DoMainLogic()
	{
		AddBuffToTarget(_actor, 990020140);
		BeginAttack(1, ShadowDash, flushInputedKeys: true, forceInterruptAttack: true);
		SetSuperArmorEnable();
		SetLockToughnessEnable();
		yield return WaitCustomEvent("Fire");
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			for (int i = 0; i < 2; i++)
			{
				SummonShadow1();
				yield return WaitTime(DashGap);
				DispatchCustomEvent("CastDashSkill", isSelfEvent: false);
				yield return WaitTime(DashGap);
			}
			for (int i = 0; i < 2; i++)
			{
				SummonShadow2();
				yield return WaitTime(DashGap);
				DispatchCustomEvent("CastDashSkill", isSelfEvent: false);
				yield return WaitTime(DashGap);
			}
			SummonShadow3();
			yield return WaitTime(DashGap);
			DispatchCustomEvent("CastDashSkill", isSelfEvent: false);
			yield return WaitTime(DashGap);
		}
		else
		{
			for (int i = 0; i < 5; i++)
			{
				SummonShadow1();
				yield return WaitTime(DashGap);
				DispatchCustomEvent("CastDashSkill", isSelfEvent: false);
				yield return WaitTime(DashGap);
			}
		}
		yield return WaitTime(1);
		CancelAttack();
		AddBuffToTarget(_actor, 502510010);
		SetSuperArmorDisable();
		SetLockToughnessDisable();
		RemoveBuffFromTarget(_actor, 990020140);
		BeginLookAt_NotWait(GetCurrentPlayer(), 3, 150);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopLookAt();
	}

	private void SummonShadow1()
	{
		Point1 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
		for (int i = 0; i <= 100; i++)
		{
			if (!(Distance(Point1, LastPoint) <= ShadowDistance))
			{
				break;
			}
			Point1 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
		}
		SummonTeammate(1, Point1, GetPosition() - Point1);
		LastPoint = Point1;
	}

	private void SummonShadow2()
	{
		Point1 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
		Point2 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
		for (int i = 0; i <= 100; i++)
		{
			if (!(Distance(Point1, Point2) <= ShadowDistance))
			{
				break;
			}
			Point2 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
		}
		SummonTeammate(1, Point1, GetPosition() - Point1);
		SummonTeammate(1, Point2, GetPosition() - Point2);
	}

	private void SummonShadow3()
	{
		Point1 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
		Point2 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
		for (int i = 0; i <= 100; i++)
		{
			if (!(Distance(Point1, Point2) <= ShadowDistance))
			{
				break;
			}
			Point2 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
		}
		Point3 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
		for (int j = 0; j <= 100; j++)
		{
			if (!(Distance(Point3, Point1) <= ShadowDistance) && !(Distance(Point3, Point2) <= ShadowDistance))
			{
				break;
			}
			Point3 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
		}
		SummonTeammate(1, Point1, GetPosition() - Point1);
		SummonTeammate(1, Point2, GetPosition() - Point2);
		SummonTeammate(1, Point3, GetPosition() - Point3);
	}
}
