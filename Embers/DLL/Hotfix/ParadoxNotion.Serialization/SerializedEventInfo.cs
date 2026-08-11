using System;
using System.Reflection;
using UnityEngine;

namespace ParadoxNotion.Serialization;

[Serializable]
public class SerializedEventInfo : ISerializedReflectedInfo, ISerializationCallbackReceiver
{
	[SerializeField]
	private string _baseInfo;

	[NonSerialized]
	private EventInfo _event;

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		if (_event != null)
		{
			_baseInfo = $"{_event.RTReflectedOrDeclaredType().FullName}|{_event.Name}";
		}
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		if (_baseInfo != null)
		{
			string[] array = _baseInfo.Split('|');
			Type type = ReflectionTools.GetType(array[0], fallbackNoNamespace: true);
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

	public MemberInfo AsMemberInfo()
	{
		return _event;
	}

	public string AsString()
	{
		if (_baseInfo == null)
		{
			return null;
		}
		return _baseInfo.Replace("|", ".");
	}

	public override string ToString()
	{
		return AsString();
	}

	public static implicit operator EventInfo(SerializedEventInfo value)
	{
		return value?._event;
	}
}
