using System.Collections;
using TrueSync;

namespace AIScript.Monster._50571FengShanJi;

public class Skill_BalloonSummon_BossRush : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Summon_Combo_Common = new ComboInputBuffer.ActionKey[1];

	private readonly ComboInputBuffer.ActionKey[] Summon_Combo_Fast = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private readonly FP MaxDistance = 11;

	private readonly FP MinDistance = 5;

	private readonly int BalloonAmountP1 = 4;

	private readonly int BalloonAmountP2 = 6;

	private TSVector2 CenterPosition;

	private FP Phase;

	private int BalloonCount;

	private FP CurrentRotation;

	private long Summon_LeftHandFX;

	private long Summon_RightHandFX;

	private bool IsUpdate;

	private int BalloonAmount;

	private ComboInputBuffer.ActionKey[] Summon_Combo;

	protected override void OnSkillEnable()
	{
		CenterPosition = GetPlaceHolderPosition("CenterPoint");
		Phase = GetLogicTagFpValue(_actor, "BattleStage");
		BalloonCount = 0;
		if (Phase == 1 || Phase == 2)
		{
			IsUpdate = false;
		}
		else
		{
			IsUpdate = true;
		}
		if (!IsUpdate)
		{
			BalloonAmount = BalloonAmountP1;
			Summon_Combo = Summon_Combo_Common;
		}
		else
		{
			BalloonAmount = BalloonAmountP2;
			Summon_Combo = Summon_Combo_Fast;
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
		if (IsUpdate)
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
