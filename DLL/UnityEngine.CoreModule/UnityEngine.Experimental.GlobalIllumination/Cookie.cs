namespace UnityEngine.Experimental.GlobalIllumination;

public struct Cookie
{
	public int instanceID;

	public float scale;

	public Vector2 sizes;

	public static Cookie Defaults()
	{
		Cookie result = default(Cookie);
		result.instanceID = 0;
		result.scale = 1f;
		result.sizes = new Vector2(1f, 1f);
		return result;
	}
}
