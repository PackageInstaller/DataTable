using System.ComponentModel;
using UnityEngine.InputSystem.Processors;

namespace UnityEngine.InputSystem.Android.LowLevel;

[DesignTimeVisible(false)]
internal class AndroidCompensateRotationProcessor : CompensateRotationProcessor
{
	public override Quaternion Process(Quaternion value, InputControl control)
	{
		float num = value.x * value.x + value.y * value.y + value.z * value.z;
		value.w = ((num < 1f) ? Mathf.Sqrt(1f - num) : 0f);
		return base.Process(value, control);
	}
}
