using System;
using System.Reflection;
using ParadoxNotion.Serialization.FullSerializer.Internal;
using UnityEngine;

namespace ParadoxNotion.Serialization;

[Serializable]
public class SerializedEventInfo : ISerializationCallbackReceiver
{
	[SerializeField]
	private string _baseInfo;

	[NonSerialized]
	private EventInfo _event;

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		if (_event != null)
		{
			_baseInfo = $"{_event.RTReflectedType().FullName}|{_event.Name}";
		}
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		if (_baseInfo != null)
		{
			string[] array = _baseInfo.Split('|');
			Type type = fsTypeCache.GetType(array[0], null);
			if (type == null)
			{
				_event = null;
				return;
			}
			string name = array[1];
			_event = type.RTGetEvent(name);
		}
	}

	public SerializedEventInfo()
	{
	}

	public SerializedEventInfo(EventInfo info)
	{
		_event = info;
	}

	public EventInfo Get()
	{
		return _event;
	}
}
