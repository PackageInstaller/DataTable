using System.Reflection;
using UnityEngine;

namespace ParadoxNotion.Serialization;

public interface ISerializedReflectedInfo : ISerializationCallbackReceiver
{
	MemberInfo AsMemberInfo();

	string AsString();
}
