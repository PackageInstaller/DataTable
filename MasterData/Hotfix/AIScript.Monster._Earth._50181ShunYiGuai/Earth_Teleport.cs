using System.Collections;
using TrueSync;

namespace AIScript.Monster._Earth._50181ShunYiGuai;

public class Earth_Teleport : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Teleport01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.T,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly ComboInputBuffer.ActionKey[] Teleport02 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.T,
		ComboInputBuffer.ActionKey._2
	};

	private TSVector2 SkillPos;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Teleport01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Disappear");
		SetHideModelEnable();
		SetUnparalleledEnable();
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (Distance(GetPosition(), GetEntityPositionObsoleted(currentPlayer)) <= 6)
		{
			Earth_Teleport earth_Teleport = this;
			TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(currentPlayer);
			FP radius = 12;
			FP innerRadius = 10;
			DeterministicShape shapeData = earth_Teleport.GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, radius, innerRadius);
			SkillPos = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			Teleport(SkillPos);
			BeginLookAt_NotWait(currentPlayer, 0.1, 3600);
		}
		else
		{
			Earth_Teleport earth_Teleport2 = this;
			TSVector2 entityPositionObsoleted2 = GetEntityPositionObsoleted(currentPlayer);
			FP innerRadius = 12;
			FP radius = 10;
			DeterministicShape shapeData2 = earth_Teleport2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted2, default, default, innerRadius, radius);
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData2, _actor, isReachable: true);
			int num = 0;
			while (Distance(shapeRandomPoint, GetPosition()) < 5 && num < 50)
			{
				shapeRandomPoint = GetShapeRandomPoint(shapeData2, _actor, isReachable: true);
				num++;
			}
			SkillPos = shapeRandomPoint;
			Teleport(SkillPos);
			BeginLookAt_NotWait(currentPlayer, 0.1, 3600);
		}
		yield return WaitTime(0.15);
		BeginAttack(1, Teleport02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Appear");
		SetUnparalleledDisable();
		SetHideModelDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
