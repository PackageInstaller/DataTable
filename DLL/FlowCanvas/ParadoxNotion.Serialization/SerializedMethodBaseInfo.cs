using System.Reflection;
using UnityEngine;

namespace ParadoxNotion.Serialization;

public abstract class SerializedMethodBaseInfo : ISerializationCallbackReceiver
{
	public abstract MethodBase GetBase();

	public abstract bool HasChanged();

	public abstract string GetMethodString();

	public override string ToString()
	{
		return GetMethodString();
	}

	public abstract void OnBeforeSerialize();

	public abstract void OnAfterDeserialize();
}
