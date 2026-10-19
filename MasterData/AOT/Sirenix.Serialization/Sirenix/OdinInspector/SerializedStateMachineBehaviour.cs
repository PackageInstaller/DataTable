using Sirenix.Serialization;
using Sirenix.Utilities;
using UnityEngine;

namespace Sirenix.OdinInspector;

public abstract class SerializedStateMachineBehaviour : StateMachineBehaviour, ISerializationCallbackReceiver
{
	[HideInInspector]
	[SerializeField]
	private SerializationData serializationData;

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		if (!UnityExtensions.SafeIsUnityNull(this))
		{
			UnitySerializationUtility.DeserializeUnityObject(this, ref serializationData);
			OnAfterDeserialize();
		}
	}

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		if (!UnityExtensions.SafeIsUnityNull(this))
		{
			OnBeforeSerialize();
			UnitySerializationUtility.SerializeUnityObject(this, ref serializationData);
		}
	}

	protected virtual void OnAfterDeserialize()
	{
	}

	protected virtual void OnBeforeSerialize()
	{
	}
}
