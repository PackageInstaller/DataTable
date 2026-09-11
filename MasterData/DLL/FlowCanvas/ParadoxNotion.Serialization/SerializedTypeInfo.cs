using System;
using ParadoxNotion.Serialization.FullSerializer.Internal;
using UnityEngine;

namespace ParadoxNotion.Serialization;

[Serializable]
public class SerializedTypeInfo : ISerializationCallbackReceiver
{
	[SerializeField]
	public string _baseInfo;

	[NonSerialized]
	private Type _type;

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		if (_type != null)
		{
			_baseInfo = _type.FullName;
		}
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		if (_baseInfo != null)
		{
			_type = fsTypeCache.GetType(_baseInfo, null);
		}
	}

	public void FindType(string typeName)
	{
		_type = fsTypeCache.GetType(typeName);
	}

	public SerializedTypeInfo()
	{
	}

	public SerializedTypeInfo(Type info)
	{
		_type = info;
	}

	public Type Get()
	{
		return _type;
	}
}
