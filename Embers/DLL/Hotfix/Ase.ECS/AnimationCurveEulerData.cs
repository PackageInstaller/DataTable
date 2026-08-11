using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class AnimationCurveEulerData : AnimationCurveRotateDataBase
{
	private AnimationCurve curveRotX;

	private AnimationCurve curveRotY;

	private AnimationCurve curveRotZ;

	public static AnimationCurveEulerData Create(float timeLength, AnimationCurve curveRotX, AnimationCurve curveRotY, AnimationCurve curveRotZ)
	{
		AnimationCurveEulerData animationCurveEulerData = ReferencePool.Acquire<AnimationCurveEulerData>();
		animationCurveEulerData.timeLength = timeLength;
		animationCurveEulerData.curveRotX = curveRotX;
		animationCurveEulerData.curveRotY = curveRotY;
		animationCurveEulerData.curveRotZ = curveRotZ;
		return animationCurveEulerData;
	}

	public override Quaternion GetQuaternion(float curvePercent)
	{
		float x = curveRotX.Evaluate(curvePercent);
		float y = curveRotY.Evaluate(curvePercent);
		float z = curveRotZ.Evaluate(curvePercent);
		Quaternion q = Quaternion.Euler(x, y, z);
		if (isMultidimensional)
		{
			return Quaternion.Normalize(q);
		}
		return Quaternion.Normalize(Quaternion.Euler(0f, q.eulerAngles.y, 0f));
	}

	public override void Clear()
	{
		curveRotX = null;
		curveRotY = null;
		curveRotZ = null;
	}
}
