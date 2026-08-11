using Ase.ECS;
using UnityEngine;
using UnityEngine.Animations;

namespace Ase;

public class SkillAreaIndicatorView : SkillIndicatorView
{
	private float skillRange = 1f;

	private Vector3 lastDirection;

	protected override string shaderColorName => "_BaseColor";

	public override void Init(Vector3 point, Vector3 direction, Transform bingTrans)
	{
		base.Init(point, direction, bingTrans);
	}

	public override void InitScale(SkillIndicatorData indicatorData)
	{
		skillRange = indicatorData.SkillRange / 2f;
		base.transform.localScale = new Vector3(indicatorData.SkillWidth, 1f, indicatorData.SkillWidth);
	}

	public override void OnUpdate(Vector3 point, float deltaTime, ChangeIndicatorData data)
	{
		UpdateIndicatorPoint(point, deltaTime);
		if (((ConstraintSource)(ref constraintSource)).sourceTransform != null)
		{
			Vector3 position = ((ConstraintSource)(ref constraintSource)).sourceTransform.position + lastDirection * skillRange;
			Vector3 vector = ((ConstraintSource)(ref constraintSource)).sourceTransform.InverseTransformPoint(position);
			ParentConstraintComp.SetTranslationOffset(0, vector);
		}
	}

	public override void OnFixedUpdate(float deltaTime, ChangeIndicatorData indicatorData)
	{
		if (indicatorData.ChangeWidthTime > 0f)
		{
			Vector3 localScale = base.transform.localScale;
			localScale.x += indicatorData.SkillWidthInCreaseValue;
			localScale.z += indicatorData.SkillWidthInCreaseValue;
			base.transform.localScale = localScale;
		}
	}

	public override void UpdateIndicatorPoint(Vector3 point, float deltaTime)
	{
		lastPosition = point;
	}

	public override void UpdateIndicatorDirection()
	{
	}

	public override void UpdateIndicatorDirection(Vector3 direction)
	{
		Vector3 position = lastPosition + direction * skillRange;
		lastDirection = direction;
		Vector3 vector = ((ConstraintSource)(ref constraintSource)).sourceTransform.InverseTransformPoint(position);
		ParentConstraintComp.SetTranslationOffset(0, vector);
	}
}
