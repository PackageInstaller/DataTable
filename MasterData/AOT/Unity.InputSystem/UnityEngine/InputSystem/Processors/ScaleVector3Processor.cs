namespace UnityEngine.InputSystem.Processors;

public class ScaleVector3Processor : InputProcessor<Vector3>
{
	[Tooltip("Scale factor to multiply the incoming Vector3's X component by.")]
	public float x = 1f;

	[Tooltip("Scale factor to multiply the incoming Vector3's Y component by.")]
	public float y = 1f;

	[Tooltip("Scale factor to multiply the incoming Vector3's Z component by.")]
	public float z = 1f;

	public override Vector3 Process(Vector3 value, InputControl control)
	{
		return new Vector3(value.x * x, value.y * y, value.z * z);
	}

	public override string ToString()
	{
		return $"ScaleVector3(x={x},y={y},z={z})";
	}
}
