namespace UnityEngine.InputSystem.Processors;

public class ScaleProcessor : InputProcessor<float>
{
	[Tooltip("Scale factor to multiply incoming float values by.")]
	public float factor = 1f;

	public override float Process(float value, InputControl control)
	{
		return value * factor;
	}

	public override string ToString()
	{
		return $"Scale(factor={factor})";
	}
}
