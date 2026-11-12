using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._72016KuiLeiJuNu;

public class Skill_ShanShuoWeiYi : SkillSimpleBase
{
	private const string combo_Disappear = "Disappear";

	private const string combo_Appear = "Appear";

	private FP blinkDistance = 6;

	private FP fanAngle = 60;

	private readonly LookAtTarget _lookAtTarget = new LookAtTarget();

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_lookAtTarget.StopLookAt();
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		if (!(target == null))
		{
			bool rotateFinish = false;
			_lookAtTarget.BeginLookAt(_actor, target, 0, 3600, () =>
			{
				rotateFinish = true;
			});
			while (!rotateFinish)
			{
				yield return null;
			}
			BeginAttack(1, "Disappear", flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			TSVector2 position = GetPosition();
			TSVector2 entityPosition = GetEntityPosition(target);
			TSVector2 tSVector = position - entityPosition;
			TSVector2 tSVector2 = ((tSVector != TSVector2.zero) ? tSVector.normalized : TSVector2.up);
			Skill_ShanShuoWeiYi skill_ShanShuoWeiYi = this;
			FP radius = blinkDistance;
			FP innerRadius = blinkDistance;
			FP angle = fanAngle;
			FP angle2 = tSVector2.GetAngle();
			DeterministicShape shapeData = skill_ShanShuoWeiYi.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, angle2);
			TSVector2 tSVector3 = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			if (tSVector3 == position)
			{
				tSVector3 = position + tSVector2 * blinkDistance;
			}
			if (!(TSVector2.Distance(position, tSVector3) < blinkDistance * 0.5f))
			{
				CancelAttack();
				Teleport(tSVector3, checkPositionReachable: false);
				BeginAttack(2, "Appear", flushInputedKeys: true);
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
		}
	}
}
