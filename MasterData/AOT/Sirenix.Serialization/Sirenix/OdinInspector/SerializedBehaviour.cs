using Sirenix.Serialization;
using Sirenix.Utilities;
using UnityEngine;

namespace Sirenix.OdinInspector;

public abstract class SerializedBehaviour : Behaviour, ISerializationCallbackReceiver, ISupportsPrefabSerialization
{
	[HideInInspector]
	[SerializeField]
	private SerializationData serializationData;

	SerializationData ISupportsPrefabSerialization.SerializationData
	{
		get
		{
			return serializationData;
		}
		set
		{
			serializationData = value;
		}
	}

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
