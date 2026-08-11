using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class AnimationCurveQuaternionData : AnimationCurveRotateDataBase
{
	private AnimationCurve curveRotX;

	private AnimationCurve curveRotY;

	private AnimationCurve curveRotZ;

	private AnimationCurve curveRotW;

	public static AnimationCurveQuaternionData Create(float timeLength, AnimationCurve curveRotX, AnimationCurve curveRotY, AnimationCurve curveRotZ, AnimationCurve curveRotW)
	{
		AnimationCurveQuaternionData animationCurveQuaternionData = ReferencePool.Acquire<AnimationCurveQuaternionData>();
		animationCurveQuaternionData.timeLength = timeLength;
		animationCurveQuaternionData.curveRotX = curveRotX;
		animationCurveQuaternionData.curveRotY = curveRotY;
		animationCurveQuaternionData.curveRotZ = curveRotZ;
		animationCurveQuaternionData.curveRotW = curveRotW;
		return animationCurveQuaternionData;
	}

	public override Quaternion GetQuaternion(float curvePercent)
	{
		float x = curveRotX.Evaluate(curvePercent);
		float y = curveRotY.Evaluate(curvePercent);
		float z = curveRotZ.Evaluate(curvePercent);
		float w = curveRotW.Evaluate(curvePercent);
		Quaternion q = new Quaternion(x, y, z, w);
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
		curveRotW = null;
	}
}
