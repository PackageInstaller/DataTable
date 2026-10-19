using System;
using UnityEngine;

namespace Unity.VisualScripting;

public abstract class LudiqScriptableObject : ScriptableObject, ISerializationCallbackReceiver
{
	[DoNotSerialize]
	[SerializeField]
	protected SerializationData _data;

	internal event Action OnDestroyActions;

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		Serialization.isUnitySerializing = true;
		try
		{
			OnBeforeSerialize();
			_data = this.Serialize(forceReflected: true);
			OnAfterSerialize();
		}
		catch (Exception arg)
		{
			Debug.LogError($"Failed to serialize scriptable object.\n{arg}", this);
		}
		Serialization.isUnitySerializing = false;
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		Serialization.isUnitySerializing = true;
		try
		{
			object instance = this;
			OnBeforeDeserialize();
			_data.DeserializeInto(ref instance, forceReflected: true);
			OnAfterDeserialize();
			_data.Clear();
		}
		catch (Exception arg)
		{
			Debug.LogError($"Failed to deserialize scriptable object.\n{arg}", this);
		}
		Serialization.isUnitySerializing = false;
	}

	protected virtual void OnBeforeSerialize()
	{
	}

	protected virtual void OnAfterSerialize()
	{
	}

	protected virtual void OnBeforeDeserialize()
	{
	}

	protected virtual void OnAfterDeserialize()
	{
	}

	protected virtual void OnPostDeserializeInEditor()
	{
	}

	private void OnDestroy()
	{
		OnDestroyActions?.Invoke();
	}

	protected virtual void ShowData()
	{
		SerializationData serializationData = this.Serialize(forceReflected: true);
		serializationData.ShowString(ToString());
		serializationData.Clear();
	}

	public override string ToString()
	{
		return this.ToSafeString();
	}
}
