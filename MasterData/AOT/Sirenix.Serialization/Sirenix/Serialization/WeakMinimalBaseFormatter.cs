using System;
using System.Runtime.Serialization;

namespace Sirenix.Serialization;

public abstract class WeakMinimalBaseFormatter : IFormatter
{
	protected readonly Type SerializedType;

	protected readonly bool IsValueType;

	Type IFormatter.SerializedType => SerializedType;

	public WeakMinimalBaseFormatter(Type serializedType)
	{
		SerializedType = serializedType;
		IsValueType = SerializedType.IsValueType;
	}

	public object Deserialize(IDataReader reader)
	{
		object value = GetUninitializedObject();
		if (!IsValueType && value != null)
		{
			RegisterReferenceID(value, reader);
		}
		Read(ref value, reader);
		return value;
	}

	public void Serialize(object value, IDataWriter writer)
	{
		Write(ref value, writer);
	}

	protected virtual object GetUninitializedObject()
	{
		if (IsValueType)
		{
			return Activator.CreateInstance(SerializedType);
		}
		return FormatterServices.GetUninitializedObject(SerializedType);
	}

	protected abstract void Read(ref object value, IDataReader reader);

	protected abstract void Write(ref object value, IDataWriter writer);

	protected void RegisterReferenceID(object value, IDataReader reader)
	{
		if (!IsValueType)
		{
			int currentNodeId = reader.CurrentNodeId;
			if (currentNodeId < 0)
			{
				reader.Context.Config.DebugContext.LogWarning("Reference type node is missing id upon deserialization. Some references may be broken. This tends to happen if a value type has changed to a reference type (IE, struct to class) since serialization took place.");
			}
			else
			{
				reader.Context.RegisterInternalReference(currentNodeId, value);
			}
		}
	}
}
