using System;
using System.Linq;
using System.Reflection;
using UnityEngine;

namespace ParadoxNotion.Serialization;

[Serializable]
public class SerializedMethodInfo : ISerializedMethodBaseInfo, ISerializedReflectedInfo, ISerializationCallbackReceiver
{
	[SerializeField]
	private string _baseInfo;

	[SerializeField]
	private string _paramsInfo;

	[SerializeField]
	private string _genericArgumentsInfo;

	[NonSerialized]
	private MethodInfo _method;

	[NonSerialized]
	private bool _hasChanged;

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		_hasChanged = false;
		if (_method != null)
		{
			_baseInfo = $"{_method.RTReflectedOrDeclaredType().FullName}|{_method.Name}|{_method.ReturnType.FullName}";
			_paramsInfo = string.Join("|", (from p in _method.GetParameters()
				select p.ParameterType.FullName).ToArray());
			_genericArgumentsInfo = (_method.IsGenericMethod ? string.Join("|", (from a in _method.RTGetGenericArguments()
				select a.FullName).ToArray()) : null);
		}
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		_hasChanged = false;
		if (_baseInfo == null)
		{
			return;
		}
		string[] array = _baseInfo.Split('|');
		Type type = ReflectionTools.GetType(array[0], fallbackNoNamespace: true);
		if (type == null)
		{
			_method = null;
			return;
		}
		string name = array[1];
		Type returnType = ((array.Length >= 3) ? ReflectionTools.GetType(array[2], fallbackNoNamespace: true) : null);
		bool isSerializedGeneric = !string.IsNullOrEmpty(_genericArgumentsInfo);
		string[] array2 = (string.IsNullOrEmpty(_paramsInfo) ? null : _paramsInfo.Split('|'));
		Type[] parameterTypes = ((array2 != null) ? new Type[array2.Length] : Type.EmptyTypes);
		bool flag = false;
		for (int i = 0; i < parameterTypes.Length; i++)
		{
			Type type2 = ReflectionTools.GetType(array2[i], fallbackNoNamespace: true);
			if (type2 == null)
			{
				flag = true;
				break;
			}
			parameterTypes[i] = type2;
		}
		if (!flag)
		{
			if (isSerializedGeneric)
			{
				string[] array3 = _genericArgumentsInfo.Split('|');
				Type[] array4 = new Type[array3.Length];
				bool flag2 = false;
				for (int j = 0; j < array4.Length; j++)
				{
					Type type3 = ReflectionTools.GetType(array3[j], fallbackNoNamespace: true);
					if (type3 == null)
					{
						flag2 = true;
						break;
					}
					array4[j] = type3;
				}
				if (!flag2)
				{
					_method = type.RTGetMethod(name, parameterTypes, returnType, array4);
				}
			}
			else
			{
				_method = type.RTGetMethod(name, parameterTypes, returnType);
			}
		}
		if (!(_method == null))
		{
			return;
		}
		_hasChanged = true;
		MethodInfo[] source = type.RTGetMethods();
		_method = source.FirstOrDefault((MethodInfo m) => m.Name == name && m.GetParameters().Length == parameterTypes.Length && isSerializedGeneric == m.IsGenericMethod);
		if (_method == null)
		{
			_method = source.FirstOrDefault((MethodInfo m) => m.Name == name);
		}
		if (_method != null && _method.IsGenericMethod)
		{
			Type type4 = (isSerializedGeneric ? ReflectionTools.GetType(_genericArgumentsInfo.Split('|').First(), fallbackNoNamespace: true) : _method.GetFirstGenericParameterConstraintType());
			_method = _method.MakeGenericMethod(type4);
		}
	}

	public SerializedMethodInfo()
	{
	}

	public SerializedMethodInfo(MethodInfo method)
	{
		_hasChanged = false;
		_method = method;
	}

	public MemberInfo AsMemberInfo()
	{
		return _method;
	}

	public MethodBase GetMethodBase()
	{
		return _method;
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

	public static implicit operator MethodInfo(SerializedMethodInfo value)
	{
		return value?._method;
	}
}
