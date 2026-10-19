using System;

namespace UnityEngine;

public struct HumanPose
{
	public Vector3 bodyPosition;

	public Quaternion bodyRotation;

	public float[] muscles;

	internal void Init()
	{
		if (muscles != null && muscles.Length != HumanTrait.MuscleCount)
		{
			throw new InvalidOperationException("Bad array size for HumanPose.muscles. Size must equal HumanTrait.MuscleCount");
		}
		if (muscles == null)
		{
			muscles = new float[HumanTrait.MuscleCount];
			if (bodyRotation.x == 0f && bodyRotation.y == 0f && bodyRotation.z == 0f && bodyRotation.w == 0f)
			{
				bodyRotation.w = 1f;
			}
		}
	}
}
