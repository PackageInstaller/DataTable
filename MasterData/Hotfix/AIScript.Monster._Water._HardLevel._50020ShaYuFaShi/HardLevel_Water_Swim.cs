using System.Collections;
using TrueSync;

namespace AIScript.Monster._Water._HardLevel._50020ShaYuFaShi;

public class HardLevel_Water_Swim : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private TSVector2 PosRandom01;

	private TSVector2 PosRandom02;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true);
		FP tSVectToAngle = GetTSVectToAngle(GetForward(), 0);
		HardLevel_Water_Swim hardLevel_Water_Swim = this;
		TSVector2 position = GetPosition();
		FP radius = 10;
		FP innerRadius = 8;
		FP angle = 360;
		FP rotation = tSVectToAngle;
		DeterministicShape shapeData = hardLevel_Water_Swim.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
		PosRandom01 = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		while (Distance(GetEntityPositionObsoleted(GetAttackTarget()), PosRandom01) < 6)
		{
			PosRandom01 = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		}
		HardLevel_Water_Swim hardLevel_Water_Swim2 = this;
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetAttackTarget());
		rotation = 12;
		angle = 10;
		innerRadius = 360;
		radius = 0;
		DeterministicShape shapeData2 = hardLevel_Water_Swim2.GetShapeData(DeterministicShape.ShapeType.Fan, entityPositionObsoleted, default, default, rotation, angle, innerRadius, radius);
		PosRandom02 = GetShapeRandomPoint(shapeData2, _actor, isReachable: true);
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) > 5)
		{
			MoveToPosition(PosRandom01, 0);
			SetCloseBlockEnable();
			AddBuffToTarget(_actor, 500210010);
			yield return WaitMoveStatus();
			SetCloseBlockDisable();
			RemoveBuffFromTarget(_actor, 500210010);
			CancelAttack();
			BeginLookAt_NotWait(GetAttackTarget(), 0.3, 360);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			MoveToPosition(PosRandom02, 0);
			SetCloseBlockEnable();
			AddBuffToTarget(_actor, 500210010);
			yield return WaitMoveStatus();
			SetCloseBlockDisable();
			RemoveBuffFromTarget(_actor, 500210010);
			CancelAttack();
			BeginLookAt_NotWait(GetAttackTarget(), 0.3, 360);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}
}
