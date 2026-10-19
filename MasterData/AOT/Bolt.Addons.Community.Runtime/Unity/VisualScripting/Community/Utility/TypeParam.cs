using System;
using Unity.VisualScripting.Community.Libraries.CSharp;
using UnityEngine;

namespace Unity.VisualScripting.Community.Utility;

[Serializable]
[Inspectable]
[RenamedFrom("Bolt.Addons.Community.Utility.TypeParam")]
public sealed class TypeParam : ISerializationCallbackReceiver
{
	[Serialize]
	[Inspectable]
	public Type type = typeof(object);

	[SerializeField]
	public SystemType Paramtype = new SystemType();

	[Serialize]
	[Inspectable]
	public string name;

	public bool hasDefault;

	[SerializeField]
	public bool isParamsParameter;

	[SerializeField]
	[Serialize]
	public object defaultValue;

	[Serialize]
	[SerializeField]
	private SerializationData defaultValueSerialized;

	public ParameterModifier modifier;

	public TypeParam()
	{
	}

	public TypeParam(Type type, string name)
	{
		this.type = type;
		this.name = name;
		Paramtype = new SystemType(type);
	}

	public object GetDefaultValue()
	{
		if (!string.IsNullOrEmpty(defaultValueSerialized.json))
		{
			return defaultValueSerialized.Deserialize();
		}
		return defaultValue;
	}

	public void OnBeforeSerialize()
	{
		if (defaultValue != null)
		{
			defaultValueSerialized = defaultValue.Serialize();
		}
	}

	public void OnAfterDeserialize()
	{
		defaultValue = GetDefaultValue();
	}
}
