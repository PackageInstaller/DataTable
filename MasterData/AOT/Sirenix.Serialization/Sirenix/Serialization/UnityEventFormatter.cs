using UnityEngine.Events;

namespace Sirenix.Serialization;

public class UnityEventFormatter<T> : ReflectionFormatter<T> where T : UnityEventBase, new()
{
	protected override T GetUninitializedObject()
	{
		return new T();
	}
}
