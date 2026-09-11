using System;
using ParadoxNotion;
using UnityEngine;

namespace FlowCanvas;

[Serializable]
public class DynamicPortDefinition : ISerializationCallbackReceiver
{
	[SerializeField]
	private string _ID;

	[SerializeField]
	private string _name;

	[SerializeField]
	private string _type;

	[NonSerialized]
	private Type resolvedType;

	public string ID
	{
		get
		{
			if (string.IsNullOrEmpty(_ID))
			{
				_ID = name;
			}
			return _ID;
		}
		set
		{
			_ID = value;
		}
	}

	public string name
	{
		get
		{
			return _name;
		}
		set
		{
			_name = value;
		}
	}

	public Type type
	{
		get
		{
			return resolvedType;
		}
		set
		{
			resolvedType = value;
		}
	}

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		_type = ((resolvedType != null) ? resolvedType.FullName : null);
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		resolvedType = ReflectionTools.GetType(_type, fallbackNoNamespace: true);
	}

	public DynamicPortDefinition()
	{
	}

	public DynamicPortDefinition(string name, Type type)
	{
		ID = Guid.NewGuid().ToString();
		this.name = name;
		this.type = type;
	}
}
