using System.Collections;
using TrueSync;

namespace AIScript.Monster._10012FanRongZhiShiTi;

public class Skill_Linger : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Walk = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.W };

	private TSVector2 PosRandom01;

	private TSVector2 PosRandom02;

	private int TimesEnd;

	private FP PointY;

	protected override void OnSkillEnable()
	{
		TimesEnd = 0;
	}

	protected override void OnSkillDisable()
	{
		CancelAim();
		StopMove();
		CancelBezierPathMove();
	}

	protected override IEnumerator DoMainLogic()
	{
		FP CharacterAngle = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		if (Distance(GetPosition(), new TSVector2(0, 0)) > 7)
		{
			StartCor(TimeCal());
			while (TimesEnd != 1)
			{
				if (CharacterAngle >= 0 && CharacterAngle <= 180)
				{
					PointY = 1;
				}
				else
				{
					PointY = -1;
				}
				BeginBezierPathMove(1, new TSVector2(0, 0), 0.5, PointY, comboWithAttack: false, default, AdventureActor.MovementMode.Walk, 40, 20);
				AimAtTarget(GetCurrentPlayer(), 60);
				yield return WaitBezierPathMoveFinish();
			}
			yield break;
		}
		if ((CharacterAngle > 120 || CharacterAngle < -120) && Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer())) > 6)
		{
			StartCor(TimeCal());
			while (TimesEnd != 1)
			{
				PosRandom01 = GetEntityPositionObsoleted(GetCurrentPlayer());
				if (CharacterAngle > 120 && CharacterAngle <= 180)
				{
					PointY = 1;
				}
				else
				{
					PointY = -1;
				}
				BeginBezierPathMove(1, PosRandom01, 0.5, PointY, comboWithAttack: false, default, AdventureActor.MovementMode.Walk, 40, 20);
				AimAtPosition(PosRandom01, 60);
				yield return WaitBezierPathMoveFinish();
			}
			yield break;
		}
		StartCor(TimeCal());
		while (TimesEnd != 1)
		{
			Skill_Linger skill_Linger = this;
			TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
			FP radius = 10;
			FP innerRadius = 6;
			DeterministicShape shapeData = skill_Linger.GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, radius, innerRadius);
			int num = 0;
			PosRandom02 = GetShapeRandomPoint(shapeData, GetCurrentPlayer(), isReachable: true);
			while (Distance(PosRandom02, GetPosition()) < 6 && num < 5)
			{
				PosRandom02 = GetShapeRandomPoint(shapeData, GetCurrentPlayer(), isReachable: true);
				num++;
			}
			MoveToPosition(PosRandom02, 1, AdventureActor.MovementMode.Walk, 3);
			AimAtTarget(GetCurrentPlayer(), 60);
			yield return WaitMoveStatus();
		}
	}

	protected IEnumerator TimeCal()
	{
		int Timesint = 0;
		while (Timesint <= 2)
		{
			Timesint++;
			yield return WaitFrame(30);
		}
		TimesEnd = 1;
	}
}
