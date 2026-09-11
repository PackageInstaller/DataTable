namespace UnityEngine.Experimental.GlobalIllumination;

public struct SpotLight
{
	public int instanceID;

	public bool shadow;

	public LightMode mode;

	public Vector3 position;

	public Quaternion orientation;

	public LinearColor color;

	public LinearColor indirectColor;

	public float range;

	public float sphereRadius;

	public float coneAngle;

	public float innerConeAngle;

	public FalloffType falloff;

	public AngularFalloffType angularFalloff;
}
