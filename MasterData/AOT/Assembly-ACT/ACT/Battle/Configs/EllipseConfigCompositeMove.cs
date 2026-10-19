using UnityEngine;

namespace ACT.Battle.Configs;

public class EllipseConfigCompositeMove : ConfigCompositeMove
{
	[Tooltip("半长轴")]
	public ConfigFunction<float> semiMajorAxis;

	[Tooltip("半短轴")]
	public ConfigFunction<float> semiMinorAxis;

	[Tooltip("速度")]
	public AnimationCurve speedCurve;

	[Tooltip("相位")]
	public float phase;

	public override CompositeMoveBase CreateInstance()
	{
		return new EllipseCompositeMove(this);
	}
}
