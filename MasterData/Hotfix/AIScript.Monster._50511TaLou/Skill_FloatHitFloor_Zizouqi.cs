using System.Collections;
using TrueSync;

namespace AIScript.Monster._50511TaLou;

public class Skill_FloatHitFloor_Zizouqi : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Fly = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly ComboInputBuffer.ActionKey[] Fly_Plus = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly FP TraceTime = 4;

	private static readonly int FireBallAmount = 10;

	private ComboInputBuffer.ActionKey[] Fly_Combo;

	private bool IsUpgrade = true;

	private long UpgradeAreaEffect;

	private FP TraceTimeCount;

	private LogicEntity TraceTarget;

	private CoroutineNode CheckTraceFinishNode;

	private FP Difficulty;

	private int FireBallCount;

	protected override void OnSkillEnable()
	{
		FireBallCount = 0;
	}

	protected override void OnSkillDisable()
	{
		StopAreaEffect(UpgradeAreaEffect);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Fly_Plus, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.5);
		if (IsUpgrade)
		{
			UpgradeAreaEffect = PlayAreaEffect("AreaEffect_FireAreaWhenFlying", GetPosition());
		}
		yield return WaitTime(0.5);
		TraceTarget = GetAttackTarget(isUpToDate: true);
		BeginTrace(TraceTarget, 1, -1, TraceTime);
		TraceTimeCount = TraceTime;
		StartCor(ref CheckTraceFinishNode, CheckTraceFinish());
		while (TraceTimeCount > 0)
		{
			if (!CheckTargetIsValid(TraceTarget))
			{
				TraceTimeCount = 0;
			}
			else if (TraceTarget != GetAttackTarget(isUpToDate: true))
			{
				TraceTarget = GetAttackTarget();
				StopTrace();
				BeginTrace(TraceTarget, 1, -1, TraceTimeCount);
			}
			yield return WaitTime(0.03);
			TraceTimeCount -= (FP)0.03;
		}
		Skill_FloatHitFloor_Zizouqi skill_FloatHitFloor_Zizouqi = this;
		TSVector2 position = GetPosition();
		skill_FloatHitFloor_Zizouqi.PlayEarlyWarningEffect("FireEarlyWarning_5m", 1f, default, position, default, 0.95f);
		yield return WaitTime(0.5);
		StopCor(CheckTraceFinishNode);
		StopTrace();
		StopAreaEffect(UpgradeAreaEffect);
		CancelAttack();
		if (IsUpgrade)
		{
			yield return WaitCustomEvent("HitFloorFrame");
			FireBallShoot();
		}
		yield return WaitTime(0.5);
		BeginAttack(2, "FlyRest", flushInputedKeys: true, forceInterruptAttack: true);
		PlayWwiseSound("mon_50511_hover");
		yield return WaitTime(1);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator CheckTraceFinish()
	{
		yield return WaitTraceFinish();
		TraceTimeCount = 0;
	}

	private void FireBallShoot()
	{
		while (FireBallCount < FireBallAmount)
		{
			int num = 360 / FireBallAmount / 2 + 360 / FireBallAmount * FireBallCount;
			TSVector2 position = GetPosition();
			FP radius = 9;
			FP innerRadius = 5;
			FP angle = 360 / FireBallAmount;
			FP rotation = num;
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
			if (GetShapeRandomPoint(shapeData, _actor, isReachable: true) != GetPosition())
			{
				FanMultipleShoot("Mine_Throw_Slow", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 0, RotateTo(GetForward(), num), 0, AimType.Position, BulletDirectionType.BulletToTarget, 15, 0, 2.5, GetShapeRandomPoint(shapeData, _actor, isReachable: true));
			}
			FireBallCount++;
		}
	}
}
