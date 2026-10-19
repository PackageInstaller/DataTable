namespace UnityEngine.Rendering.Universal.LibTessDotNet;

internal struct ContourVertex
{
	public Vec3 Position;

	public object Data;

	public override string ToString()
	{
		return $"{Position}, {Data}";
	}
}
