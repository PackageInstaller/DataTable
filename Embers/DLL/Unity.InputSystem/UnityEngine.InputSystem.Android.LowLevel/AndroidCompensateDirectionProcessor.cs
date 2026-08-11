using System.ComponentModel;
using UnityEngine.InputSystem.Processors;

namespace UnityEngine.InputSystem.Android.LowLevel;

[DesignTimeVisible(false)]
internal class AndroidCompensateDirectionProcessor : CompensateDirectionProcessor
{
	private const float kSensorStandardGravity = 9.80665f;

	private const float kAccelerationMultiplier = -0.10197162f;

	public override Vector3 Process(Vector3 vector, InputControl control)
	{
		return base.Process(vector * -0.10197162f, control);
	}
}
