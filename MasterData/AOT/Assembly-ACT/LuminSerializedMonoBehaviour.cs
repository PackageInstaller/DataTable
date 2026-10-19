using Sirenix.OdinInspector;
using Sirenix.Serialization;

public abstract class LuminSerializedMonoBehaviour : SerializedMonoBehaviour
{
	protected override void OnAfterDeserialize()
	{
		base.OnAfterDeserialize();
		SerializationData serializationData = ((ISupportsPrefabSerialization)this).SerializationData;
		if (LuminOdinSerializationDataUtility.ClearRedundantSerializedBytesString(ref serializationData))
		{
			((ISupportsPrefabSerialization)this).SerializationData = serializationData;
		}
	}
}
