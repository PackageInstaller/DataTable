using System;
using System.Collections.Generic;
using ParadoxNotion.Serialization.FullSerializer;

[Serializable]
public class GraphByteData
{
	public List<byte> ByteGraph = new List<byte>();

	public List<int> DataPosition = new List<int>();

	public List<string> TypeHashName = new List<string>();

	public List<byte> TypeHashEnum = new List<byte>();

	public List<int> ArrayCount = new List<int>();

	public List<ushort> ShortArrayCount = new List<ushort>();

	private static string[] s_typeStr;

	public void Clear()
	{
		for (int i = 0; i < TypeHashName.Count; i++)
		{
			GraphSerializerPool.Release(TypeHashName[i]);
		}
		TypeHashEnum.Clear();
		ByteGraph.Clear();
		DataPosition.Clear();
		TypeHashName.Clear();
		ArrayCount.Clear();
		ShortArrayCount.Clear();
	}

	public string GetStrByType(byte t)
	{
		if (s_typeStr == null)
		{
			s_typeStr = Enum.GetNames(typeof(fsDataType));
		}
		return s_typeStr[t];
	}
}
