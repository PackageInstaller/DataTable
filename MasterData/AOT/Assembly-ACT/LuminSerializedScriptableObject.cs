using System;
using System.Reflection;
using ACT;
using Sirenix.OdinInspector;
using Sirenix.Serialization;
using UnityEngine;

public abstract class LuminSerializedScriptableObject : SerializedScriptableObject
{
	private const string SerializationDataFieldName = "serializationData";

	private static readonly FieldInfo SerializationDataField = typeof(SerializedScriptableObject).GetField("serializationData", BindingFlags.Instance | BindingFlags.NonPublic);

	protected override void OnAfterDeserialize()
	{
		base.OnAfterDeserialize();
		MissingFieldException exception = new MissingFieldException(typeof(SerializedScriptableObject).FullName, "serializationData");
		if (SerializationDataField == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
			return;
		}
		SerializationData serializationData = (SerializationData)SerializationDataField.GetValue(this);
		if (LuminOdinSerializationDataUtility.ClearRedundantSerializedBytesString(ref serializationData))
		{
			SerializationDataField.SetValue(this, serializationData);
		}
	}
}
