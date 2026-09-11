using System;
using System.Collections.Generic;
using MessagePack;
using MessagePack.Formatters;
using UnityEngine;

public sealed class UnityGameObjectFormatter : IMessagePackFormatter<GameObject>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, GameObject value, MessagePackSerializerOptions options)
	{
		List<UnityEngine.Object> list = fsSerializationContext.mUnityReferences;
		if (list == null)
		{
			list = new List<UnityEngine.Object>();
		}
		if (list.Count == 0)
		{
			list.Add(null);
		}
		int num = -1;
		for (int i = 0; i < list.Count; i++)
		{
			if ((object)list[i] == value)
			{
				num = i;
				break;
			}
		}
		if (num < 0)
		{
			num = list.Count;
			list.Add(value);
		}
		writer.Write(num);
	}

	public GameObject Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		List<UnityEngine.Object> list = fsSerializationContext.mUnityReferences;
		if (list == null)
		{
			list = new List<UnityEngine.Object>();
		}
		GameObject result = null;
		int num = reader.ReadInt32();
		if (list.Count <= num)
		{
			return null;
		}
		try
		{
			result = list[num] as GameObject;
		}
		catch (Exception)
		{
			Debug.Log("refs type: " + list[num]?.GetType().FullName);
		}
		return result;
	}
}
