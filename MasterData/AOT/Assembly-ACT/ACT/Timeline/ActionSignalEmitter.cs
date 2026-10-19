using System;
using System.Collections.Generic;
using Sirenix.Serialization;
using Sirenix.Utilities;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[Serializable]
[CustomStyle("SignalEmitter")]
[ExcludeFromPreset]
public class ActionSignalEmitter : SignalEmitter, IActionSignalEmitter, ISerializationCallbackReceiver
{
	[SerializeReference]
	public List<ISignalAction> eventActions = new List<ISignalAction>();

	[SerializeField]
	[HideInInspector]
	private SerializationData serializationData;

	public void Invoke(INotificationReceiver receiver)
	{
		foreach (ISignalAction eventAction in eventActions)
		{
			eventAction.Invoke(receiver);
		}
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		if (!this.SafeIsUnityNull())
		{
			UnitySerializationUtility.DeserializeUnityObject(this, ref serializationData);
			OnAfterDeserialize();
		}
	}

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		if (!this.SafeIsUnityNull())
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
