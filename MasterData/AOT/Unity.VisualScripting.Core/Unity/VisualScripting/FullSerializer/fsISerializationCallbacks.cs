using System;

namespace Unity.VisualScripting.FullSerializer;

public interface fsISerializationCallbacks
{
	void OnBeforeSerialize(Type storageType);

	void OnAfterSerialize(Type storageType, ref fsData data);

	void OnBeforeDeserialize(Type storageType, ref fsData data);

	void OnAfterDeserialize(Type storageType);
}
