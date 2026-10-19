namespace UnityEngine.InputSystem.Processors;

public class NormalizeVector2Processor : InputProcessor<Vector2>
{
	public override Vector2 Process(Vector2 value, InputControl control)
	{
		return value.normalized;
	}

	public override string ToString()
	{
		return "NormalizeVector2()";
	}
}
