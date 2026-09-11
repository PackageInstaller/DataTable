using System;
using System.Collections.Generic;
using UnityEngine;

namespace ParadoxNotion.Serialization.FullSerializer.Internal.DirectConverters;

public class Rect_DirectConverter : fsDirectConverter<Rect>
{
	protected override fsResult DoSerialize(Rect model, Dictionary<string, fsData> serialized)
	{
		return fsResult.Success + SerializeMember(serialized, null, "xMin", model.xMin) + SerializeMember(serialized, null, "yMin", model.yMin) + SerializeMember(serialized, null, "xMax", model.xMax) + SerializeMember(serialized, null, "yMax", model.yMax);
	}

	protected override fsResult DoDeserialize(Dictionary<string, fsData> data, ref Rect model)
	{
		fsResult success = fsResult.Success;
		float value = model.xMin;
		fsResult obj = success + DeserializeMember<float>(data, null, "xMin", out value);
		model.xMin = value;
		float value2 = model.yMin;
		fsResult obj2 = obj + DeserializeMember<float>(data, null, "yMin", out value2);
		model.yMin = value2;
		float value3 = model.xMax;
		fsResult obj3 = obj2 + DeserializeMember<float>(data, null, "xMax", out value3);
		model.xMax = value3;
		float value4 = model.yMax;
		fsResult result = obj3 + DeserializeMember<float>(data, null, "yMax", out value4);
		model.yMax = value4;
		return result;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return default(Rect);
	}
}
