using System;
using System.Reflection;
using UnityEngine;
using UnityEngine.Events;

namespace ParadoxNotion.Serialization;

[Serializable]
public class SerializedUnityEventInfo : ISerializedReflectedInfo, ISerializationCallbackReceiver
{
	[SerializeField]
	private string _baseInfo;

	[NonSerialized]
	private MemberInfo _memberInfo;

	public bool isStatic
	{
		get
		{
			if (_memberInfo is FieldInfo)
			{
				return (_memberInfo as FieldInfo).IsStatic;
			}
			if (_memberInfo is PropertyInfo)
			{
				return (_memberInfo as PropertyInfo).IsStatic();
			}
			return false;
		}
	}

	public Type memberType
	{
		get
		{
			if (_memberInfo is FieldInfo)
			{
				return (_memberInfo as FieldInfo).FieldType;
			}
			if (_memberInfo is PropertyInfo)
			{
				return (_memberInfo as PropertyInfo).PropertyType;
			}
			return null;
		}
	}

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		if (_memberInfo != null)
		{
			_baseInfo = $"{_memberInfo.RTReflectedOrDeclaredType().FullName}|{_memberInfo.Name}";
		}
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		if (_baseInfo == null)
		{
			return;
		}
		string[] array = _baseInfo.Split('|');
		Type type = ReflectionTools.GetType(array[0], fallbackNoNamespace: true);
		if (type == null)
		{
			_memberInfo = null;
			return;
		}
		string name = array[1];
		MemberInfo memberInfo = type.RTGetFieldOrProp(name);
		_memberInfo = null;
		if (memberInfo is FieldInfo && typeof(UnityEventBase).RTIsAssignableFrom((memberInfo as FieldInfo).FieldType))
		{
			_memberInfo = memberInfo;
		}
		else if (memberInfo is PropertyInfo && typeof(UnityEventBase).RTIsAssignableFrom((memberInfo as PropertyInfo).PropertyType))
		{
			_memberInfo = memberInfo;
		}
	}

	public SerializedUnityEventInfo()
	{
	}

	public SerializedUnityEventInfo(FieldInfo info)
	{
		_memberInfo = info;
	}

	public SerializedUnityEventInfo(PropertyInfo info)
	{
		_memberInfo = info;
	}

	public SerializedUnityEventInfo(MemberInfo info)
	{
		if (info is FieldInfo || info is PropertyInfo)
		{
			_memberInfo = info;
			return;
		}
		throw new Exception("MemberInfo is neither Field nor Property");
	}

	public MemberInfo AsMemberInfo()
	{
		return _memberInfo;
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

	public static implicit operator FieldInfo(SerializedUnityEventInfo value)
	{
		if (value == null)
		{
			return null;
		}
		return value._memberInfo as FieldInfo;
	}

	public static implicit operator PropertyInfo(SerializedUnityEventInfo value)
	{
		if (value == null)
		{
			return null;
		}
		return value._memberInfo as PropertyInfo;
	}
}
