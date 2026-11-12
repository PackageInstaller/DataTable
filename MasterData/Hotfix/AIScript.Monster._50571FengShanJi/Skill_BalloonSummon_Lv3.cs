using System.Collections;
using TrueSync;

namespace AIScript.Monster._50571FengShanJi;

public class Skill_BalloonSummon_Lv3 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Summon_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly FP MaxDistanceP1 = 8;

	private static readonly FP MinDistanceP1 = 3;

	private static readonly int BalloonAmountP1 = 4;

	private static readonly FP MaxDistanceP2 = 11;

	private static readonly FP MinDistanceP2 = 5;

	private static readonly int BalloonAmountP2 = 8;

	private TSVector2 CenterPosition;

	private FP Phase;

	private FP MaxDistance;

	private FP MinDistance;

	private int BalloonCount;

	private int BalloonAmount;

	private FP CurrentRotation;

	private long Summon_LeftHandFX;

	private long Summon_RightHandFX;

	protected override void OnSkillEnable()
	{
		CenterPosition = GetPlaceHolderPosition("CenterPoint");
		Phase = GetLogicTagFpValue(_actor, "Phase");
		BalloonCount = 0;
		if (Phase == 1)
		{
			MaxDistance = MaxDistanceP1;
			MinDistance = MinDistanceP1;
			BalloonAmount = BalloonAmountP1;
		}
		else
		{
			MaxDistance = MaxDistanceP2;
			MinDistance = MinDistanceP2;
			BalloonAmount = BalloonAmountP2;
		}
		CurrentRotation = 180f / (float)BalloonAmount;
	}

	protected override void OnSkillDisable()
	{
		StopEffect(Summon_LeftHandFX);
		StopEffect(Summon_RightHandFX);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return BeginLookAtByDir(new TSVector2(0, -1), 0, 300);
		BeginAttack(1, Summon_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		Summon_LeftHandFX = PlayEffect("Summon_LeftHandFX");
		Summon_RightHandFX = PlayEffect("Summon_RightHandFX");
		while (BalloonCount < BalloonAmount)
		{
			yield return null;
		}
		yield return WaitCustomEvent("LoopEnd");
		CancelAttack();
		StopEffect(Summon_LeftHandFX);
		StopEffect(Summon_RightHandFX);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		StartCor(Summon());
	}

	private IEnumerator Summon()
	{
		SummonAction();
		if (Phase == 2)
		{
			yield return WaitTime(0.15);
			SummonAction();
		}
	}

	private void SummonAction()
	{
		TSVector2 centerPosition = CenterPosition;
		FP maxDistance = MaxDistance;
		FP minDistance = MinDistance;
		FP angle = 360 / BalloonAmount;
		FP currentRotation = CurrentRotation;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, centerPosition, default, default, maxDistance, minDistance, angle, currentRotation);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		SummonTeammate(1, shapeRandomPoint, RotateTo(TSVector2.down, GetRandomValue(0, 180)));
		BalloonCount++;
		CurrentRotation += (FP)(360f / (float)BalloonAmount);
	}
}
