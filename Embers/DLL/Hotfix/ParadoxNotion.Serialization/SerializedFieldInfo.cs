using System;
using System.Reflection;
using UnityEngine;

namespace ParadoxNotion.Serialization;

[Serializable]
public class SerializedFieldInfo : ISerializedReflectedInfo, ISerializationCallbackReceiver
{
	[SerializeField]
	private string _baseInfo;

	[NonSerialized]
	private FieldInfo _field;

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		if (_field != null)
		{
			_baseInfo = $"{_field.RTReflectedOrDeclaredType().FullName}|{_field.Name}";
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

	public MemberInfo AsMemberInfo()
	{
		return _field;
	}

	public string AsString()
	{
		if (_baseInfo == null)
		{
			return "None";
		}
		return _baseInfo.Replace("|", ".");
	}

	public override string ToString()
	{
		return AsString();
	}

	public static implicit operator FieldInfo(SerializedFieldInfo value)
	{
		return value?._field;
	}
}
