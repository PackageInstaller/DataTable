using System.Collections;
using TrueSync;

namespace AIScript.Monster._Fire._50181ShunYiGuai;

public class Fire_Teleport : SkillSimpleBase
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
		if (Distance(GetPosition(), GetEntityPosition(currentPlayer)) <= 6)
		{
			Fire_Teleport fire_Teleport = this;
			TSVector2 entityPosition = GetEntityPosition(currentPlayer);
			FP radius = 7;
			FP innerRadius = 5;
			DeterministicShape shapeData = fire_Teleport.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			int num = 0;
			while (Distance(shapeRandomPoint, GetPosition()) < 5 && num < 50)
			{
				shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
				num++;
			}
			SkillPos = shapeRandomPoint;
			Teleport(SkillPos);
			BeginLookAt_NotWait(currentPlayer, 0.1, 3600);
		}
		else
		{
			Fire_Teleport fire_Teleport2 = this;
			TSVector2 entityPosition2 = GetEntityPosition(currentPlayer);
			FP innerRadius = 6;
			FP radius = 4;
			DeterministicShape shapeData2 = fire_Teleport2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition2, default, default, innerRadius, radius);
			TSVector2 shapeRandomPoint2 = GetShapeRandomPoint(shapeData2, _actor, isReachable: true);
			int num2 = 0;
			while (Distance(shapeRandomPoint2, GetPosition()) < 5 && num2 < 50)
			{
				shapeRandomPoint2 = GetShapeRandomPoint(shapeData2, _actor, isReachable: true);
				num2++;
			}
			SkillPos = shapeRandomPoint2;
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
