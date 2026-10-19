using System;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[Serializable]
[RenamedFrom("Bolt.Addons.Community.Code.ClassFieldDeclaration")]
[Inspectable]
public sealed class ClassFieldDeclaration : FieldDeclaration, ISerializationCallbackReceiver
{
	public SerializableType typeHandle;

	[InspectorToggleLeft]
	public object defaultValue = 0;

	[Serialize]
	private object serlizer;

	[HideInInspector]
	[SerializeField]
	private SerializationData serializedValue;

	[HideInInspector]
	[SerializeField]
	private SerializationData serializedValueType;

	public void OnAfterDeserialize()
	{
		type = (Type)serializedValueType.Deserialize();
		serlizer = serializedValue.Deserialize();
		defaultValue = serlizer;
	}

	public void OnBeforeSerialize()
	{
		if (defaultValue == null)
		{
			serializedValue = default;
			return;
		}
		serializedValue = defaultValue.Serialize();
		serlizer = defaultValue.Serialize();
		if (type == null)
		{
			serializedValueType = default;
		}
		else
		{
			serializedValueType = type.Serialize();
		}
	}
}
