namespace LuaInterface;

public static class LuaValueTypeName
{
	public static string[] names;

	static LuaValueTypeName()
	{
		names = new string[64];
		names[0] = "None";
		names[1] = "Vector3";
		names[2] = "Quaternion";
		names[3] = "Vector2";
		names[4] = "Color";
		names[5] = "Vector4";
		names[6] = "Ray";
		names[7] = "Bounds";
		names[8] = "Touch";
		names[9] = "LayerMask";
		names[10] = "RaycastHit";
	}

	public static string Get(int type)
	{
		if (type >= 0 && type < 64)
		{
			return names[type];
		}
		return "UnKnownType:" + ConstStringTable.GetNumIntern(type);
	}
}
