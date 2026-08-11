using Ase.ECS;
using UnityEngine;

namespace Ase;

public class SkillRangeIndicatorView : SkillIndicatorView
{
	protected override string shaderColorName => "_BaseColor";

	public override void Init(Vector3 point, Vector3 direction, Transform bingTrans)
	{
		base.Init(point, direction, bingTrans);
	}

	public override void InitScale(SkillIndicatorData indicatorData)
	{
		base.transform.localScale = new Vector3(indicatorData.SkillRange, 1f, indicatorData.SkillRange);
	}

	public override void OnUpdate(Vector3 point, float deltaTime, ChangeIndicatorData data)
	{
		UpdateIndicatorPoint(point, deltaTime);
	}

	public override void OnFixedUpdate(float deltaTime, ChangeIndicatorData indicatorData)
	{
		if (indicatorData.ChangeRangeTime > 0f)
		{
			Vector3 localScale = base.transform.localScale;
			localScale.x += indicatorData.SkillRangeIncreaseValue;
			localScale.z += indicatorData.SkillRangeIncreaseValue;
			base.transform.localScale = localScale;
		}
	}
}
