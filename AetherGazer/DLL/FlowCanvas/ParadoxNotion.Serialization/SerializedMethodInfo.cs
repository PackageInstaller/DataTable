using System;
using System.Linq;
using System.Reflection;
using MessagePack;
using ParadoxNotion.Serialization.FullSerializer.Internal;
using UnityEngine;

namespace ParadoxNotion.Serialization;

[Serializable]
public class SerializedMethodInfo : SerializedMethodBaseInfo
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

	public override void OnBeforeSerialize()
	{
		_hasChanged = false;
		if (_method != null)
		{
			_baseInfo = $"{_method.RTReflectedType().FullName}|{_method.Name}|{_method.ReturnType.FullName}";
			_paramsInfo = string.Join("|", (from p in _method.GetParameters()
				select p.ParameterType.FullName).ToArray());
			_genericArgumentsInfo = (_method.IsGenericMethod ? string.Join("|", (from a in _method.GetGenericArguments()
				select a.FullName).ToArray()) : null);
		}
	}

	public override void OnAfterDeserialize()
	{
		_hasChanged = false;
		if (_baseInfo == null)
		{
			return;
		}
		string[] array = _baseInfo.Split('|');
		Type type = fsTypeCache.GetType(array[0], null);
		if (type == null)
		{
			_method = null;
			return;
		}
		string name = array[1];
		string[] array2 = (string.IsNullOrEmpty(_paramsInfo) ? null : _paramsInfo.Split('|'));
		Type[] parameterTypes = ((array2 == null) ? new Type[0] : array2.Select((string n) => fsTypeCache.GetType(n, null)).ToArray());
		if (parameterTypes.All((Type t) => t != null))
		{
			if (!string.IsNullOrEmpty(_genericArgumentsInfo))
			{
				Type[] genericArgumentTypes = (from x in _genericArgumentsInfo.Split('|')
					select fsTypeCache.GetType(x, null)).ToArray();
				_method = type.RTGetMethods().FirstOrDefault((MethodInfo m) => m.IsGenericMethod && m.Name == name && m.GetParameters().Length == parameterTypes.Length && (from p in m.MakeGenericMethod(genericArgumentTypes).GetParameters()
					select p.ParameterType).SequenceEqual(parameterTypes));
				if (_method != null)
				{
					_method = _method.MakeGenericMethod(genericArgumentTypes);
				}
			}
			else
			{
				_method = type.RTGetMethod(name, parameterTypes);
				if (array.Length >= 3)
				{
					Type type2 = fsTypeCache.GetType(array[2], null);
					if (_method != null && type2 != _method.ReturnType)
					{
						_method = null;
					}
				}
			}
		}
		if (_method == null)
		{
			_hasChanged = true;
			_method = type.RTGetMethods().FirstOrDefault((MethodInfo m) => m.Name == name);
			if (_method != null && _method.IsGenericMethodDefinition)
			{
				Type type3 = _method.GetGenericArguments().First().GetGenericParameterConstraints()
					.FirstOrDefault();
				_method = _method.MakeGenericMethod((type3 != null) ? type3 : typeof(object));
			}
		}
	}

	public SerializedMethodInfo Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		_baseInfo = reader.ReadString();
		_paramsInfo = reader.ReadString();
		_genericArgumentsInfo = reader.ReadString();
		OnAfterDeserialize();
		return this;
	}

	public void Serialize(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		OnBeforeSerialize();
		writer.Write(_baseInfo);
		writer.Write(_paramsInfo);
		writer.Write(_genericArgumentsInfo);
	}

	public SerializedMethodInfo()
	{
	}

	public SerializedMethodInfo(MethodInfo method)
	{
		_hasChanged = false;
		_method = method;
	}

	public MethodInfo Get()
	{
		return _method;
	}

	public override MethodBase GetBase()
	{
		return Get();
	}

	public override bool HasChanged()
	{
		return _hasChanged;
	}

	public override string GetMethodString()
	{
		return string.Format("{0} ({1})", _baseInfo.Replace("|", "."), _paramsInfo.Replace("|", ", "));
	}
}
