namespace UnityEngine.InputSystem.Processors;

public class InvertVector2Processor : InputProcessor<Vector2>
{
	public bool invertX = true;

	public bool invertY = true;

	public override Vector2 Process(Vector2 value, InputControl control)
	{
		if (invertX)
		{
			value.x *= -1f;
		}
		if (invertY)
		{
			value.y *= -1f;
		}
		return value;
	}

	public override string ToString()
	{
		return $"InvertVector2(invertX={invertX},invertY={invertY})";
	}
}
