using Ase.ECS;
using UnityEngine;

namespace Ase;

public class SkillArrowIndicatorView : SkillIndicatorView
{
	protected override string shaderColorName => "_BaseColor";

	public override void Init(Vector3 point, Vector3 direction, Transform bingTrans)
	{
		base.Init(point, direction, bingTrans);
	}

	public override void InitScale(SkillIndicatorData indicatorData)
	{
		base.transform.localScale = new Vector3(indicatorData.SkillWidth, 1f, indicatorData.SkillRange / 2f);
	}

	public override void OnUpdate(Vector3 point, float deltaTime, ChangeIndicatorData data)
	{
		UpdateIndicatorPoint(point, deltaTime);
	}

	public override void OnFixedUpdate(float deltaTime, ChangeIndicatorData indicatorData)
	{
		if (!(indicatorData.ChangeWidthTime <= 0f) || !(indicatorData.ChangeRangeTime <= 0f))
		{
			Vector3 localScale = base.transform.localScale;
			if (indicatorData.ChangeWidthTime > 0f)
			{
				localScale.x += indicatorData.SkillWidthInCreaseValue;
			}
			if (indicatorData.ChangeRangeTime > 0f)
			{
				localScale.z += indicatorData.SkillRangeIncreaseValue / 2f;
			}
			base.transform.localScale = localScale;
		}
	}

	public override void UpdateIndicatorDirection(Vector3 direction)
	{
		float y = TSUtil.Vector2Angle(direction.ToVector2().normalized);
		base.transform.rotation = Quaternion.Euler(0f, y, 0f);
	}
}
