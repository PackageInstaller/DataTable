using System;

namespace ACT;

[Serializable]
public class SettingData
{
	public enum DataType
	{
		Unknown,
		Int,
		Float,
		Bool,
		String
	}

	public string Id;

	public int Version;

	public DataType Type;

	public int[] IntValues;

	public float[] FloatValues;

	public bool[] BoolValues;

	public string[] StringValues;
}
