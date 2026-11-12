using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Earth._50181ShunYiGuai;

public class Earth_Attack04 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack04 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey._1
	};

	protected override void OnInterrupt(int comboIndex)
	{
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(1);
		ClearActors(targetByTeammateIndex);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack04, flushInputedKeys: true, forceInterruptAttack: true);
		LogicEntity currentPlayer = GetCurrentPlayer();
		BeginLookAt_NotWait(currentPlayer, 1.2, 240);
		yield return WaitCustomEvent("Fire");
		DoSpawn();
		yield return WaitTime(4);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void DoSpawn()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(currentPlayer);
		FP radius = 4;
		FP innerRadius = 3;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, radius, innerRadius);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		TSVector2 spawnDirection = GetEntityPositionObsoleted(GetCurrentPlayer()) - shapeRandomPoint;
		SummonTeammate(1, shapeRandomPoint, spawnDirection);
	}
}
