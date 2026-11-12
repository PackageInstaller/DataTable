using System.Collections;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_LaserStrafe : SimpleAPI_FengNiao
{
	private static readonly ComboInputBuffer.ActionKey[] Shoot_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	private static readonly FP StrafeAngle = 120;

	private static readonly FP StrafeRotateSpeedP1 = 300;

	private static readonly FP StrafeRotateSpeedP2_Initial = 30;

	private static readonly FP StrafeRotateAngle_Initial = 20;

	private static readonly FP StrafeRotateSpeedP2 = 500;

	private LogicEntity AttackTarget;

	private TSVector2 LookAtPosition1;

	private TSVector2 LookAtPosition2;

	private TSVector2 LookAtPosition3;

	private TSVector2 FXPosition;

	private bool AimEnd;

	private bool TurnEnd;

	private bool IsTurnClockwise;

	private FP Phase;

	private FP Difficulty;

	private string StrafeMode;

	private FP StrafeRotateSpeed;

	private long LaserLaunch_Collect_HeadFX;

	private long AimFX;

	private long LaserFX;

	private long LaserDecoration1FX;

	private long LaserDecoration2FX;

	private bool IsBossRush;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget();
		TurnEnd = false;
		AimEnd = false;
		Phase = GetLogicTagFpValue(_actor, "BattleStage");
		Difficulty = GetLogicTagFpValue(_actor, "Difficulty");
		IsBossRush = GetLogicTagToggleValue(_actor, "IsBossRush");
		if (IsBossRush)
		{
			if (Phase == 2)
			{
				StrafeMode = "120";
			}
			else
			{
				StrafeMode = "360";
			}
		}
		else if (Difficulty == 1)
		{
			StrafeMode = "120";
		}
		else if (Phase == 2)
		{
			StrafeMode = "360";
		}
		else
		{
			StrafeMode = "120";
		}
		if (StrafeMode == "120")
		{
			StrafeRotateSpeed = StrafeRotateSpeedP1;
		}
		else
		{
			StrafeRotateSpeed = StrafeRotateSpeedP2_Initial;
		}
	}

	protected override void OnSkillDisable()
	{
		StopEffect(LaserFX);
		StopEffect(LaserDecoration1FX);
		StopEffect(LaserDecoration2FX);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitLookAt(AttackTarget, 0.25, 720);
		yield return StartCor(FlashBeforeAttackForFengNiaoToFixedPosition(TSVector2.zero));
		yield return WaitLookAt(AttackTarget, 0.25, 1800);
		if (GetRandomValue(0, 1) >= 0.5)
		{
			LookAtPosition1 = GetPosition() + RotateTo(GetForward(), StrafeAngle / 2).normalized * 50;
			LookAtPosition2 = GetPosition() + RotateTo(GetForward(), -StrafeAngle / 2).normalized * 50;
			IsTurnClockwise = true;
		}
		else
		{
			LookAtPosition2 = GetPosition() + RotateTo(GetForward(), StrafeAngle / 2).normalized * 50;
			LookAtPosition1 = GetPosition() + RotateTo(GetForward(), -StrafeAngle / 2).normalized * 50;
			IsTurnClockwise = false;
		}
		yield return BeginLookAtByPos(LookAtPosition1, 0.1, 1800);
		BeginAttack(1, Shoot_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		LaserLaunch_Collect_HeadFX = PlayEffect("LaserLaunch_Collect_Head_lv2FX");
		yield return WaitCustomEvent("Aimeline");
		Skill_LaserStrafe skill_LaserStrafe = this;
		Skill_LaserStrafe skill_LaserStrafe2 = this;
		FP rotation = GetRotation();
		skill_LaserStrafe.AimFX = skill_LaserStrafe2.PlayEffect("Laser_AimFX", 1f, default, default, rotation);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StartCor(LaserAttackCor(10));
		while (!AimEnd)
		{
			yield return null;
		}
		if (StrafeMode == "120")
		{
			FXPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1.1));
			PlayEffect("YuJingFlash", 1f, 2, FXPosition, default, 1.5f);
			yield return WaitTime(0.5);
			yield return BeginLookAtByPos(LookAtPosition2, StrafeAngle / StrafeRotateSpeed, StrafeRotateSpeed);
		}
		else
		{
			yield return WaitTime(0.3);
			FP StrafeRotateAngle = (360 - StrafeRotateAngle_Initial) / 2;
			int TurnAngleOffset = 1;
			if (IsTurnClockwise)
			{
				TurnAngleOffset = -1;
			}
			LookAtPosition3 = GetPosition() + RotateTo(GetForward(), StrafeRotateAngle_Initial * TurnAngleOffset).normalized * 50;
			BeginLookAtByPos_NotWait(LookAtPosition3, StrafeRotateAngle_Initial / StrafeRotateSpeedP2_Initial, StrafeRotateSpeedP2_Initial);
			yield return WaitTime(StrafeRotateAngle_Initial / StrafeRotateSpeedP2_Initial - 0.6);
			FXPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1.1));
			PlayEffect("YuJingFlash", 1f, 2, FXPosition, default, 1.5f);
			yield return WaitTime(0.5);
			LookAtPosition3 = GetPosition() + RotateTo(GetForward(), StrafeRotateAngle * TurnAngleOffset).normalized * 50;
			yield return BeginLookAtByPos(LookAtPosition3, StrafeRotateAngle / StrafeRotateSpeedP2, StrafeRotateSpeedP2);
			LookAtPosition3 = GetPosition() + RotateTo(GetForward(), StrafeRotateAngle * TurnAngleOffset).normalized * 50;
			yield return BeginLookAtByPos(LookAtPosition3, StrafeRotateAngle / StrafeRotateSpeedP2, StrafeRotateSpeedP2);
		}
		TurnEnd = true;
		CancelAttack();
		FlowerShootStart();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator LaserAttackCor(int AimDurationFrame)
	{
		yield return WaitFrame(AimDurationFrame);
		StopEffect(LaserLaunch_Collect_HeadFX);
		StopEffect(AimFX);
		PlayEffect("Laser_ReadyFX");
		StopWaitLookAt();
		yield return WaitFrame(10);
		LaserDecoration1FX = PlayEffect("LaserDecorationFX1");
		yield return WaitFrame(1);
		LaserDecoration2FX = PlayEffect("LaserDecorationFX2");
		yield return WaitFrame(4);
		LaserFX = PlayEffect("LaserFX");
		AimEnd = true;
		while (!TurnEnd)
		{
			Skill_LaserStrafe skill_LaserStrafe = this;
			TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 26.7));
			FP width = 1.5;
			FP length = 50;
			FP rotation = GetRotation();
			DeterministicShape shapeData = skill_LaserStrafe.GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation);
			HitFeatureData hitFeatureData = GetHitFeatureData();
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 155100601, 0.5, HitBox.HurtAnimType.Large, "HittedFX_Magic");
			yield return null;
		}
		StopEffect(LaserFX);
		StopEffect(LaserDecoration1FX);
		StopEffect(LaserDecoration2FX);
		PlayEffect("LaserEndFX");
	}
}
