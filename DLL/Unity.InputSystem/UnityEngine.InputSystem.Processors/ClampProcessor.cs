namespace UnityEngine.InputSystem.Processors;

public class ClampProcessor : InputProcessor<float>
{
	public float min;

	public float max;

	public override float Process(float value, InputControl control)
	{
		return Mathf.Clamp(value, min, max);
	}

	public override string ToString()
	{
		return $"Clamp(min={min},max={max})";
	}
}
