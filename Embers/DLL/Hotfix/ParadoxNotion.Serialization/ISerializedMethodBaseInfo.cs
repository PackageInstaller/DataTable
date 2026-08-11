using System.Reflection;
using UnityEngine;

namespace ParadoxNotion.Serialization;

public interface ISerializedMethodBaseInfo : ISerializedReflectedInfo, ISerializationCallbackReceiver
{
	MethodBase GetMethodBase();

	bool HasChanged();
}
