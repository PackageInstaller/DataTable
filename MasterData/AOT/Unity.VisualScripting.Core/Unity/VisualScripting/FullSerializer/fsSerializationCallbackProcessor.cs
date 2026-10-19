using System;

namespace Unity.VisualScripting.FullSerializer;

public class fsSerializationCallbackProcessor : fsObjectProcessor
{
	public override bool CanProcess(Type type)
	{
		return typeof(fsISerializationCallbacks).IsAssignableFrom(type);
	}

	public override void OnBeforeSerialize(Type storageType, object instance)
	{
		if (instance != null)
		{
			((fsISerializationCallbacks)instance).OnBeforeSerialize(storageType);
		}
	}

	public override void OnAfterSerialize(Type storageType, object instance, ref fsData data)
	{
		if (instance != null)
		{
			((fsISerializationCallbacks)instance).OnAfterSerialize(storageType, ref data);
		}
	}

	public override void OnBeforeDeserializeAfterInstanceCreation(Type storageType, object instance, ref fsData data)
	{
		if (!(instance is fsISerializationCallbacks))
		{
			throw new InvalidCastException("Please ensure the converter for " + storageType?.ToString() + " actually returns an instance of it, not an instance of " + instance.GetType());
		}
		((fsISerializationCallbacks)instance).OnBeforeDeserialize(storageType, ref data);
	}

	public override void OnAfterDeserialize(Type storageType, object instance)
	{
		if (instance != null)
		{
			((fsISerializationCallbacks)instance).OnAfterDeserialize(storageType);
		}
	}
}
