using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.FullSerializer;

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
		fsResult fsResult2 = success + DeserializeMember<float>(data, null, "xMin", out value);
		model.xMin = value;
		float value2 = model.yMin;
		fsResult fsResult3 = fsResult2 + DeserializeMember<float>(data, null, "yMin", out value2);
		model.yMin = value2;
		float value3 = model.xMax;
		fsResult fsResult4 = fsResult3 + DeserializeMember<float>(data, null, "xMax", out value3);
		model.xMax = value3;
		float value4 = model.yMax;
		fsResult result = fsResult4 + DeserializeMember<float>(data, null, "yMax", out value4);
		model.yMax = value4;
		return result;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return default(Rect);
	}
}
