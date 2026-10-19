namespace UnityEngine.Experimental.GlobalIllumination;

public struct DiscLight
{
	public int instanceID;

	public bool shadow;

	public LightMode mode;

	public Vector3 position;

	public Quaternion orientation;

	public LinearColor color;

	public LinearColor indirectColor;

	public float range;

	public float radius;

	public FalloffType falloff;
}
