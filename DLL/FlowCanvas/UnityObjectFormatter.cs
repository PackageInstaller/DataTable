using System;
using System.Collections.Generic;
using MessagePack;
using MessagePack.Formatters;
using NodeCanvas.Framework.Internal;
using ParadoxNotion.Serialization;
using UnityEngine;

public sealed class UnityObjectFormatter : IMessagePackFormatter<UnityEngine.Object>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, UnityEngine.Object value, MessagePackSerializerOptions options)
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

	public UnityEngine.Object Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		_ = (fsGraphFormatter)options.Resolver.GetFormatterWithVerify<GraphSerializationData>();
		List<UnityEngine.Object> list = fsSerializationContext.mUnityReferences;
		if (list == null)
		{
			list = new List<UnityEngine.Object>();
		}
		int num = reader.ReadInt32();
		if (list.Count <= num)
		{
			return null;
		}
		return list[num];
	}
}
