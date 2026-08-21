using System;
using System.Linq;
using System.Reflection;
using UnityEngine;

namespace ParadoxNotion.Serialization;

[Serializable]
public class SerializedConstructorInfo : ISerializedMethodBaseInfo, ISerializedReflectedInfo, ISerializationCallbackReceiver
{
	[SerializeField]
	private string _baseInfo;

	[SerializeField]
	private string _paramsInfo;

	[NonSerialized]
	private ConstructorInfo _constructor;

	[NonSerialized]
	private bool _hasChanged;

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		_hasChanged = false;
		if (_constructor != null)
		{
			_baseInfo = _constructor.RTReflectedOrDeclaredType().FullName + "|$Constructor";
			_paramsInfo = string.Join("|", (from p in _constructor.GetParameters()
				select p.ParameterType.FullName).ToArray());
		}
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		_hasChanged = false;
		if (_baseInfo == null)
		{
			return;
		}
		Type type = ReflectionTools.GetType(_baseInfo.Split('|')[0], fallbackNoNamespace: true);
		if (type == null)
		{
			_constructor = null;
			return;
		}
		string[] array = (string.IsNullOrEmpty(_paramsInfo) ? null : _paramsInfo.Split('|'));
		Type[] parameterTypes = ((array != null) ? new Type[array.Length] : Type.EmptyTypes);
		bool flag = false;
		if (array != null)
		{
			for (int i = 0; i < array.Length; i++)
			{
				Type type2 = ReflectionTools.GetType(array[i], fallbackNoNamespace: true);
				if (type2 == null)
				{
					flag = true;
					break;
				}
				parameterTypes[i] = type2;
			}
		}
		if (!flag)
		{
			_constructor = type.RTGetConstructor(parameterTypes);
		}
		if (_constructor == null)
		{
			_hasChanged = true;
			ConstructorInfo[] source = type.RTGetConstructors();
			_constructor = source.FirstOrDefault((ConstructorInfo c) => c.GetParameters().Length == parameterTypes.Length);
			if (_constructor == null)
			{
				_constructor = source.FirstOrDefault();
			}
		}
	}

	public SerializedConstructorInfo()
	{
	}

	public SerializedConstructorInfo(ConstructorInfo constructor)
	{
		_hasChanged = false;
		_constructor = constructor;
	}

	public MemberInfo AsMemberInfo()
	{
		return _constructor;
	}

	public MethodBase GetMethodBase()
	{
		return _constructor;
	}

	public bool HasChanged()
	{
		return _hasChanged;
	}

	public string AsString()
	{
		return string.Format("{0} ({1})", _baseInfo.Replace("|", "."), _paramsInfo.Replace("|", ", "));
	}

	public override string ToString()
	{
		return AsString();
	}

	public static implicit operator ConstructorInfo(SerializedConstructorInfo value)
	{
		return value?._constructor;
	}
}
