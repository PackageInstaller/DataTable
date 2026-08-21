namespace UnityEngine.InputSystem.Processors;

public class InvertProcessor : InputProcessor<float>
{
	public override float Process(float value, InputControl control)
	{
		return value * -1f;
	}

	public override string ToString()
	{
		return "Invert()";
	}
}
