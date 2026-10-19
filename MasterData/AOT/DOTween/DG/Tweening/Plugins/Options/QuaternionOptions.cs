using UnityEngine;

namespace DG.Tweening.Plugins.Options;

public struct QuaternionOptions : IPlugOptions
{
	public RotateMode rotateMode;

	public AxisConstraint axisConstraint;

	public Vector3 up;

	public bool dynamicLookAt;

	public Vector3 dynamicLookAtWorldPosition;

	public void Reset()
	{
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		rotateMode = RotateMode.Fast;
		axisConstraint = AxisConstraint.None;
		up = Vector3.zero;
		dynamicLookAt = false;
		dynamicLookAtWorldPosition = Vector3.zero;
	}
}
