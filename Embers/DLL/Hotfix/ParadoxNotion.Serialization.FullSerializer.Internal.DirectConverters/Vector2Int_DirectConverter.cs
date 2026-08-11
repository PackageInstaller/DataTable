using System;
using System.Collections.Generic;
using UnityEngine;

namespace ParadoxNotion.Serialization.FullSerializer.Internal.DirectConverters;

public class Vector2Int_DirectConverter : fsDirectConverter<Vector2Int>
{
	protected override fsResult DoSerialize(Vector2Int model, Dictionary<string, fsData> serialized)
	{
		SerializeMember(serialized, null, "x", model.x);
		SerializeMember(serialized, null, "y", model.y);
		return fsResult.Success;
	}

	protected override fsResult DoDeserialize(Dictionary<string, fsData> data, ref Vector2Int model)
	{
		int value = model.x;
		DeserializeMember<int>(data, null, "x", out value);
		model.x = value;
		int value2 = model.y;
		DeserializeMember<int>(data, null, "y", out value2);
		model.y = value2;
		return fsResult.Success;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return default(Vector2Int);
	}
}
