namespace Lockstep.Core;

public static class OperationExtension
{
	public static int ToInt(this object value)
	{
		return (int)value;
	}

	public static float ToFloat(this object value)
	{
		return (float)value;
	}

	public static bool ToBool(this object value)
	{
		return (bool)value;
	}
}
