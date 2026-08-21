namespace UnityEngine.InputSystem.Processors;

public class InvertVector3Processor : InputProcessor<Vector3>
{
	public bool invertX = true;

	public bool invertY = true;

	public bool invertZ = true;

	public override Vector3 Process(Vector3 value, InputControl control)
	{
		if (invertX)
		{
			value.x *= -1f;
		}
		if (invertY)
		{
			value.y *= -1f;
		}
		if (invertZ)
		{
			value.z *= -1f;
		}
		return value;
	}

	public override string ToString()
	{
		return $"InvertVector3(invertX={invertX},invertY={invertY},invertZ={invertZ})";
	}
}
