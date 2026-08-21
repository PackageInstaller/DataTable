using System;
using System.Reflection;
using ParadoxNotion.Serialization.FullSerializer.Internal;
using UnityEngine;

namespace ParadoxNotion.Serialization;

[Serializable]
public class SerializedFieldInfo : ISerializationCallbackReceiver
{
	[SerializeField]
	private string _baseInfo;

	[NonSerialized]
	private FieldInfo _field;

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		if (_field != null)
		{
			_baseInfo = $"{_field.RTReflectedType().FullName}|{_field.Name}";
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
				_field = null;
				return;
			}
			string name = array[1];
			_field = type.RTGetField(name);
		}
	}

	public SerializedFieldInfo()
	{
	}

	public SerializedFieldInfo(FieldInfo info)
	{
		_field = info;
	}

	public FieldInfo Get()
	{
		return _field;
	}
}
