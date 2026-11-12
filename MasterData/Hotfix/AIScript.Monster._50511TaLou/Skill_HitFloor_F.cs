using System.Collections;
using TrueSync;

namespace AIScript.Monster._50511TaLou;

public class Skill_HitFloor_F : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_L = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] Attack_R = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly FP AttackWaitTime = 1;

	private static readonly int FireBallAmount = 3;

	private ComboInputBuffer.ActionKey[] Attack;

	private string StartFxName;

	private string LoopFxName;

	private string EndFxName;

	private TSVector2 FxPosition;

	private TSVector2 FxOffsetPosition;

	private FP RotateSpeed;

	private long LoopFXID;

	private long PlusAreaFXID;

	private long PlusAreaWarningFXID;

	private FP Difficulty;

	private int FireBallCount;

	private FP HitRadius_EndStrike;

	private FP FireBallShootRotation;

	protected override void OnSkillEnable()
	{
		RotateSpeed = 25;
		FireBallCount = 0;
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 0)
		{
			Attack = Attack_R;
			StartFxName = "Attack_R_Start";
			LoopFxName = "Attack_R_Loop";
			EndFxName = "Attack_R_End";
			FxOffsetPosition = new TSVector2(2.2, 2.8);
			FireBallShootRotation = -60;
		}
		else
		{
			Attack = Attack_L;
			StartFxName = "Attack_L_Start";
			LoopFxName = "Attack_L_Loop";
			EndFxName = "Attack_L_End";
			FxOffsetPosition = new TSVector2(-2.2, 2.8);
			FireBallShootRotation = 60;
		}
		SetLogicTagFpValue(_actor, "HitRadiusForAchievement", 3);
		Difficulty = GetLogicTagFpValue(_actor, "Difficulty");
		if (Difficulty == 1)
		{
			HitRadius_EndStrike = 3;
		}
		else
		{
			HitRadius_EndStrike = 5;
		}
	}

	protected override void OnSkillDisable()
	{
		StopEffect(LoopFXID);
		SetLogicTagToggleValue(_actor, "taLouSkillEnd", value: true);
		SetLogicTagToggleValue(_actor, "Achievement", value: false);
		ResetBlockPriority();
		if (Difficulty != 1)
		{
			StopEffect(PlusAreaFXID);
			StopEffect(PlusAreaWarningFXID);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true, forceInterruptAttack: true);
		WaitLookAt(GetAttackTarget(), 999, RotateSpeed);
		yield return WaitCustomEvent("TurnEnd");
		StopWaitLookAt();
		FxPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), FxOffsetPosition);
		Skill_HitFloor_F skill_HitFloor_F = this;
		TSVector2 fxPosition = FxPosition;
		skill_HitFloor_F.PlayEarlyWarningEffect("FireEarlyWarning", 0.8f, default, fxPosition, default, 1.5f);
		yield return WaitCustomEvent("AchivementLabel");
		SetLogicTagToggleValue(_actor, "Achievement", value: true);
		SetLogicTagTSVector2Value(_actor, "HitPosition", TransLocalPosToWorldPos(GetPosition(), GetForward(), FxOffsetPosition));
		yield return WaitCustomEvent("StartFXPlay");
		SetBlockPriorityToStatic();
		Skill_HitFloor_F skill_HitFloor_F2 = this;
		string startFxName = StartFxName;
		fxPosition = FxPosition;
		skill_HitFloor_F2.PlayEffect(startFxName, 1f, default, fxPosition, default, 1.5f);
		yield return WaitCustomEvent("HitFrame1");
		SetLogicTagToggleValue(_actor, "Achievement", value: false);
		yield return WaitTime(0.1);
		if (Difficulty != 1)
		{
			Skill_HitFloor_F skill_HitFloor_F3 = this;
			Skill_HitFloor_F skill_HitFloor_F4 = this;
			fxPosition = FxPosition;
			skill_HitFloor_F3.PlusAreaFXID = skill_HitFloor_F4.PlayEffect("Attack_PlusAreaFX", 1.5f, default, fxPosition, default, 2.75f);
			Skill_HitFloor_F skill_HitFloor_F5 = this;
			Skill_HitFloor_F skill_HitFloor_F6 = this;
			fxPosition = FxPosition;
			skill_HitFloor_F5.PlusAreaWarningFXID = skill_HitFloor_F6.PlayEarlyWarningEffect("FireEarlyWarning", 9f, default, fxPosition, default, 2.75f);
		}
		yield return WaitTime(0.4);
		Skill_HitFloor_F skill_HitFloor_F7 = this;
		Skill_HitFloor_F skill_HitFloor_F8 = this;
		string loopFxName = LoopFxName;
		fxPosition = FxPosition;
		skill_HitFloor_F7.LoopFXID = skill_HitFloor_F8.PlayEffect(loopFxName, 1f, default, fxPosition, default, 1.5f);
		if (Difficulty != 1)
		{
			yield return WaitTime(AttackWaitTime);
			CompleteEarlyWarningEffect(PlusAreaWarningFXID);
		}
		CancelAttack();
		StopEffect(LoopFXID);
		Skill_HitFloor_F skill_HitFloor_F9 = this;
		string endFxName = EndFxName;
		fxPosition = FxPosition;
		skill_HitFloor_F9.PlayEffect(endFxName, 1f, default, fxPosition, default, 1.5f);
		yield return WaitCustomEvent("AchivementLabel2");
		SetLogicTagToggleValue(_actor, "Achievement", value: true);
		yield return WaitCustomEvent("HitFrame_EndStrike");
		SetLogicTagToggleValue(_actor, "Achievement", value: false);
		Skill_HitFloor_F skill_HitFloor_F10 = this;
		AdventureActor actor = _actor;
		Skill_HitFloor_F skill_HitFloor_F11 = this;
		TSVector2 fxPosition2 = FxPosition;
		FP hitRadius_EndStrike = HitRadius_EndStrike;
		DeterministicShape shapeData = skill_HitFloor_F11.GetShapeData(DeterministicShape.ShapeType.Circle, fxPosition2, default, default, hitRadius_EndStrike);
		Skill_HitFloor_F skill_HitFloor_F12 = this;
		FP knockBackForce = 20;
		FP knockBackDistance = 4;
		hitRadius_EndStrike = 0.5;
		FP hitStrenth = 4;
		skill_HitFloor_F10.AreaHit_Simple(actor, shapeData, skill_HitFloor_F12.GetHitFeatureData(HitBox.FeatureFlag.KnockBack | HitBox.FeatureFlag.Stiff, knockBackForce, knockBackDistance, UseAtttackForward: false, default, null, null, hitRadius_EndStrike, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth, UseHitBoxPosition: true), 50511112, 0.5, HitBox.HurtAnimType.Small, "HittedFX_Magic");
		if (Difficulty != 1)
		{
			StopEffect(PlusAreaFXID);
		}
		if (Difficulty == 3)
		{
			FireBallShoot();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void FireBallShoot()
	{
		while (FireBallCount < FireBallAmount)
		{
			TSVector2 fxPosition = FxPosition;
			FP radius = 10;
			FP innerRadius = 7;
			FP angle = 180;
			FP rotation = FireBallShootRotation + GetRotation();
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, fxPosition, default, default, radius, innerRadius, angle, rotation);
			if (GetShapeRandomPoint(shapeData, _actor, isReachable: true) != GetPosition())
			{
				FanMultipleShoot("Mine_Throw_Slow", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, FxPosition, 0, TSVector2.down, 0, AimType.Position, BulletDirectionType.BulletToTarget, 360, 0, 2.5, GetShapeRandomPoint(shapeData, _actor, isReachable: true));
			}
			FireBallCount++;
		}
	}
}
