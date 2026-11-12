using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Fire._50181ShunYiGuai;

public class Fire_Attack03 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack03 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected override void OnInterrupt(int comboIndex)
	{
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(1);
		ClearActors(targetByTeammateIndex);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack03, flushInputedKeys: true, forceInterruptAttack: true);
		LogicEntity Enemy = GetAttackTarget();
		yield return BeginLookAt(Enemy, 0.1, 3600);
		DoSpawn();
		yield return WaitTime(0.9);
		Dash();
		BeginLookAt_NotWait(Enemy, 4, 45);
		yield return WaitTime(4);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void DoSpawn()
	{
		LogicEntity attackTarget = GetAttackTarget();
		TSVector2 entityPosition = GetEntityPosition(attackTarget);
		FP radius = 4;
		FP innerRadius = 3;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		TSVector2 spawnDirection = GetEntityPosition(GetCurrentPlayer()) - shapeRandomPoint;
		if (GetBuffNum(_actor, 501810003) >= 1)
		{
			SummonTeammate(1, shapeRandomPoint, spawnDirection);
		}
	}

	private void Dash()
	{
		BeginDashActorForward(1, 2.7, 20, 45, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}
}
