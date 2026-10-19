using System;
using UnityEngine;

namespace Sirenix.Serialization;

public sealed class CoroutineFormatter : IFormatter<Coroutine>, IFormatter
{
	public Type SerializedType => typeof(Coroutine);

	object IFormatter.Deserialize(IDataReader reader)
	{
		return null;
	}

	public Coroutine Deserialize(IDataReader reader)
	{
		return null;
	}

	public void Serialize(object value, IDataWriter writer)
	{
	}

	public void Serialize(Coroutine value, IDataWriter writer)
	{
	}
}
