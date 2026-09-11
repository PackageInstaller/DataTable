namespace UnityEngine.Experimental.GlobalIllumination;

public struct RectangleLight
{
	public int instanceID;

	public bool shadow;

	public LightMode mode;

	public Vector3 position;

	public Quaternion orientation;

	public LinearColor color;

	public LinearColor indirectColor;

	public float range;

	public float width;

	public float height;

	public FalloffType falloff;
}
