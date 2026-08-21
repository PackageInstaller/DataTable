using System;
using UnityEngine;

namespace ParadoxNotion;

[Serializable]
public sealed class DynamicParameterDefinition : ISerializationCallbackReceiver
{
	[SerializeField]
	private string _ID;

	[SerializeField]
	private string _name;

	[SerializeField]
	private string _type;

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
		private set
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

	public Type type { get; set; }

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		if (type != null)
		{
			_type = type.FullName;
		}
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		type = ReflectionTools.GetType(_type, fallbackNoNamespace: true);
	}

	public DynamicParameterDefinition()
	{
	}

	public DynamicParameterDefinition(string name, Type type)
	{
		ID = Guid.NewGuid().ToString();
		this.name = name;
		this.type = type;
	}
}
