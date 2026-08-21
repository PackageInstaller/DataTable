using System;
using System.Collections.Generic;
using UnityEngine;

namespace ParadoxNotion.Serialization.FullSerializer.Internal.DirectConverters;

public class Vector2_DirectConverter : fsDirectConverter<Vector2>
{
	protected override fsResult DoSerialize(Vector2 model, Dictionary<string, fsData> serialized)
	{
		SerializeMember(serialized, null, "x", model.x);
		SerializeMember(serialized, null, "y", model.y);
		return fsResult.Success;
	}

	protected override fsResult DoDeserialize(Dictionary<string, fsData> data, ref Vector2 model)
	{
		float value = model.x;
		DeserializeMember<float>(data, null, "x", out value);
		model.x = value;
		float value2 = model.y;
		DeserializeMember<float>(data, null, "y", out value2);
		model.y = value2;
		return fsResult.Success;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return default(Vector2);
	}
}
