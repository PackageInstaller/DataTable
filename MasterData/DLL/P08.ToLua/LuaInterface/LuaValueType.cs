namespace LuaInterface;

public struct LuaValueType(int value)
{
	public const int None = 0;

	public const int Vector3 = 1;

	public const int Quaternion = 2;

	public const int Vector2 = 3;

	public const int Color = 4;

	public const int Vector4 = 5;

	public const int Ray = 6;

	public const int Bounds = 7;

	public const int Touch = 8;

	public const int LayerMask = 9;

	public const int RaycastHit = 10;

	public const int Int64 = 11;

	public const int UInt64 = 12;

	public const int Max = 64;

	private int type = value;

	public static implicit operator int(LuaValueType mask)
	{
		return mask.type;
	}

	public static implicit operator LuaValueType(int intVal)
	{
		return new LuaValueType(intVal);
	}

	public override string ToString()
	{
		return LuaValueTypeName.Get(type);
	}
}
