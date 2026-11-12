using System.Collections;
using TrueSync;

namespace AIScript.Monster._50571FengShanJi;

public class Skill_WindBlast_Lv3 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] WindBlast_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.K };

	private static readonly float ZoneFXSizeP1 = 1f;

	private static readonly float ZoneFXSizeP2 = 1.2f;

	private static readonly float GroundFXSizeP1 = 1.2f;

	private static readonly float GroundFXSizeP2 = 1.44f;

	private static readonly FP LoopWaitTimeP1 = 0.5;

	private static readonly FP LoopWaitTimeP2 = 1.5;

	private static readonly int BallonAmout = 5;

	private FP Phase;

	private long ZoneFX;

	private long WindBallFX;

	private long WindBallArea;

	private float ZoneFXSize;

	private float GroundFXSize;

	private FP LoopWaitTime;

	private FP WindBallGroundFXPosition;

	private string WindBallGroundAreaEffectName;

	private int BallonCount;

	protected override void OnSkillEnable()
	{
		BallonCount = 0;
		Phase = GetLogicTagFpValue(_actor, "Phase");
		if (Phase == 1)
		{
			ZoneFXSize = ZoneFXSizeP1;
			GroundFXSize = GroundFXSizeP1;
			LoopWaitTime = LoopWaitTimeP1;
			WindBallGroundFXPosition = 1;
			WindBallGroundAreaEffectName = "AreaEffect_WindBall_GroundAttack_1";
		}
		else
		{
			ZoneFXSize = ZoneFXSizeP2;
			GroundFXSize = GroundFXSizeP2;
			LoopWaitTime = LoopWaitTimeP2;
			WindBallGroundFXPosition = 1.2;
			WindBallGroundAreaEffectName = "AreaEffect_WindBall_GroundAttack_2";
		}
	}

	protected override void OnSkillDisable()
	{
		StopEffect(WindBallFX);
		StopEffect(ZoneFX);
		StopAreaEffect(WindBallArea);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return BeginLookAt(GetAttackTarget(), 0, 200);
		BeginAttack(1, WindBlast_Combo, flushInputedKeys: true);
		yield return WaitCustomEvent("ZoneFXStart");
		WaitLookAt_NoWait(GetAttackTarget(isUpToDate: true), 999, 60);
		TSVector2 position;
		float zoneFXSize;
		if (Phase == 2)
		{
			Skill_WindBlast_Lv3 skill_WindBlast_Lv = this;
			Skill_WindBlast_Lv3 skill_WindBlast_Lv2 = this;
			position = GetPosition();
			zoneFXSize = ZoneFXSize;
			skill_WindBlast_Lv.ZoneFX = skill_WindBlast_Lv2.PlayEffect("ZoneFX", 1f, default, position, default, zoneFXSize);
			WindBallArea = PlayAreaEffect("AreaEffect_WindBall_Plus", GetPosition(), GetRotation());
		}
		yield return WaitCustomEvent("BallFXStart");
		Skill_WindBlast_Lv3 skill_WindBlast_Lv3 = this;
		Skill_WindBlast_Lv3 skill_WindBlast_Lv4 = this;
		position = GetPosition();
		FP rotation = GetRotation();
		skill_WindBlast_Lv3.WindBallFX = skill_WindBlast_Lv4.PlayEffect("WindBallFX", 1f, default, position, rotation);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StopWaitLookAt();
		FP rotation2;
		if (Phase == 2)
		{
			while (BallonCount < BallonAmout)
			{
				TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 3.7));
				Skill_WindBlast_Lv3 skill_WindBlast_Lv5 = this;
				rotation = 5;
				FP innerRadius = 4;
				FP angle = 360 / BallonAmout;
				rotation2 = 360 * BallonCount / BallonAmout;
				DeterministicShape shapeData = skill_WindBlast_Lv5.GetShapeData(DeterministicShape.ShapeType.Fan, tSVector, default, default, rotation, innerRadius, angle, rotation2);
				TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
				if (shapeRandomPoint != tSVector)
				{
					SummonTeammate(2, shapeRandomPoint, shapeRandomPoint - GetPosition());
				}
				BallonCount++;
			}
		}
		yield return WaitTime(LoopWaitTime);
		PlayAreaEffect(WindBallGroundAreaEffectName, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 3.7)));
		yield return WaitTime(0.32);
		CancelAttack();
		if (Phase == 2)
		{
			yield return WaitCustomEvent("ZoneEndFX");
			Skill_WindBlast_Lv3 skill_WindBlast_Lv6 = this;
			position = GetPosition();
			zoneFXSize = ZoneFXSize;
			skill_WindBlast_Lv6.PlayEffect("ZoneEndFX", 1f, default, position, default, zoneFXSize);
		}
		yield return WaitCustomEvent("StopFX");
		StopEffect(WindBallFX);
		StopEffect(ZoneFX);
		StopAreaEffect(WindBallArea);
		yield return WaitCustomEvent("WindBallGroundFX");
		Skill_WindBlast_Lv3 skill_WindBlast_Lv7 = this;
		position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, -2 * WindBallGroundFXPosition));
		rotation2 = GetRotation();
		zoneFXSize = GroundFXSize;
		skill_WindBlast_Lv7.PlayEffect("WindBallGroundFX", 1f, default, position, rotation2, zoneFXSize);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
