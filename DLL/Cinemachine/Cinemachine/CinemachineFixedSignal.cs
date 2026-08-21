using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachineImpulseFixedSignals.html")]
public class CinemachineFixedSignal : SignalSourceAsset
{
	[Tooltip("The raw signal shape along the X axis")]
	public AnimationCurve m_XCurve;

	[Tooltip("The raw signal shape along the Y axis")]
	public AnimationCurve m_YCurve;

	[Tooltip("The raw signal shape along the Z axis")]
	public AnimationCurve m_ZCurve;

	public override float SignalDuration => Mathf.Max(AxisDuration(m_XCurve), Mathf.Max(AxisDuration(m_YCurve), AxisDuration(m_ZCurve)));

	private float AxisDuration(AnimationCurve axis)
	{
		float result = 0f;
		if (axis != null && axis.length > 1)
		{
			float time = axis[0].time;
			result = axis[axis.length - 1].time - time;
		}
		return result;
	}

	public override void GetSignal(float timeSinceSignalStart, out Vector3 pos, out Quaternion rot)
	{
		rot = Quaternion.identity;
		pos = new Vector3(AxisValue(m_XCurve, timeSinceSignalStart), AxisValue(m_YCurve, timeSinceSignalStart), AxisValue(m_ZCurve, timeSinceSignalStart));
	}

	private float AxisValue(AnimationCurve axis, float time)
	{
		if (axis == null || axis.length == 0)
		{
			return 0f;
		}
		return axis.Evaluate(time);
	}
}
