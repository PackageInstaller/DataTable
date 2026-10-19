using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class AbilityBlackboardVariable
{
	public string key;

	public string name;

	public AbilityBlackboardValueType valueType;

	public float floatValue;

	public int intValue;

	public bool boolValue;

	public string stringValue;

	public Vector3 vector3Value;

	public object CreateDefaultValue()
	{
		return valueType switch
		{
			AbilityBlackboardValueType.Float => (object)floatValue, 
			AbilityBlackboardValueType.Int => intValue, 
			AbilityBlackboardValueType.Bool => boolValue, 
			AbilityBlackboardValueType.String => stringValue ?? string.Empty, 
			AbilityBlackboardValueType.Vector3 => vector3Value, 
			AbilityBlackboardValueType.EntityReferenceArray => Array.Empty<EntityReference>(), 
			_ => null, 
		};
	}
}
