using System;
using System.Collections.Generic;
using UnityEngine;

namespace ParadoxNotion.Serialization.FullSerializer.Internal.DirectConverters;

public class Vector3Int_DirectConverter : fsDirectConverter<Vector3Int>
{
	protected override fsResult DoSerialize(Vector3Int model, Dictionary<string, fsData> serialized)
	{
		SerializeMember(serialized, null, "x", model.x);
		SerializeMember(serialized, null, "y", model.y);
		SerializeMember(serialized, null, "z", model.z);
		return fsResult.Success;
	}

	protected override fsResult DoDeserialize(Dictionary<string, fsData> data, ref Vector3Int model)
	{
		int value = model.x;
		DeserializeMember<int>(data, null, "x", out value);
		model.x = value;
		int value2 = model.y;
		DeserializeMember<int>(data, null, "y", out value2);
		model.y = value2;
		int value3 = model.z;
		DeserializeMember<int>(data, null, "z", out value3);
		model.z = value3;
		return fsResult.Success;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return default(Vector3Int);
	}
}
