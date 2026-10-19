using System.ComponentModel;
using UnityEngine.InputSystem.LowLevel;

namespace UnityEngine.InputSystem.Processors;

[DesignTimeVisible(false)]
internal class CompensateDirectionProcessor : InputProcessor<Vector3>
{
	public override CachingPolicy cachingPolicy => CachingPolicy.EvaluateOnEveryRead;

	public override Vector3 Process(Vector3 value, InputControl control)
	{
		if (!InputSystem.settings.compensateForScreenOrientation)
		{
			return value;
		}
		Quaternion quaternion = Quaternion.identity;
		switch (InputRuntime.s_Instance.screenOrientation)
		{
		case ScreenOrientation.PortraitUpsideDown:
			quaternion = Quaternion.Euler(0f, 0f, 180f);
			break;
		case ScreenOrientation.LandscapeLeft:
			quaternion = Quaternion.Euler(0f, 0f, 90f);
			break;
		case ScreenOrientation.LandscapeRight:
			quaternion = Quaternion.Euler(0f, 0f, 270f);
			break;
		}
		return quaternion * value;
	}

	public override string ToString()
	{
		return "CompensateDirection()";
	}
}
