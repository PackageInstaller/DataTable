using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Scripting;

namespace AOT.Animation;

[Preserve]
public struct YCurveScaleJob : IAnimationJob
{
	public TransformStreamHandle target;

	public float originalYDis;

	public float yScale;

	public float baseLocalY;

	public byte hasInit;

	public void ProcessRootMotion(AnimationStream stream)
	{
	}

	public void ProcessAnimation(AnimationStream stream)
	{
		if (!target.IsValid(stream))
		{
			return;
		}
		Vector3 localPosition = target.GetLocalPosition(stream);
		if (hasInit == 0)
		{
			baseLocalY = localPosition.y;
			hasInit = 1;
		}
		if (target.IsValid(stream))
		{
			if (localPosition.y > 1f)
			{
				localPosition.y = Mathf.Max(localPosition.y * Mathf.Min(yScale, 1f), baseLocalY);
			}
			target.SetLocalPosition(stream, localPosition);
		}
	}
}
