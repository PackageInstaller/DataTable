using System;
using System.Linq;
using System.Reflection;
using ParadoxNotion.Serialization.FullSerializer.Internal;
using UnityEngine;

namespace ParadoxNotion.Serialization;

[Serializable]
public class SerializedConstructorInfo : SerializedMethodBaseInfo
{
	[SerializeField]
	private string _baseInfo;

	[SerializeField]
	private string _paramsInfo;

	[NonSerialized]
	private ConstructorInfo _constructor;

	[NonSerialized]
	private bool _hasChanged;

	public override void OnBeforeSerialize()
	{
		_hasChanged = false;
		if (_constructor != null)
		{
			_baseInfo = _constructor.RTReflectedType().FullName + "|$Constructor";
			_paramsInfo = string.Join("|", (from p in _constructor.GetParameters()
				select p.ParameterType.FullName).ToArray());
		}
	}

	public override void OnAfterDeserialize()
	{
		_hasChanged = false;
		Type type = fsTypeCache.GetType(_baseInfo.Split('|')[0], null);
		if (type == null)
		{
			_constructor = null;
			return;
		}
		string[] array = (string.IsNullOrEmpty(_paramsInfo) ? null : _paramsInfo.Split('|'));
		Type[] array2 = ((array == null) ? new Type[0] : array.Select((string n) => fsTypeCache.GetType(n, null)).ToArray());
		if (array2.All((Type t) => t != null))
		{
			_constructor = type.RTGetConstructor(array2);
		}
		if (_constructor == null)
		{
			_hasChanged = true;
			_constructor = type.RTGetConstructors().FirstOrDefault();
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

	public ConstructorInfo Get()
	{
		return _constructor;
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
