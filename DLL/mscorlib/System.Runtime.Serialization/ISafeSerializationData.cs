namespace System.Runtime.Serialization;

public interface ISafeSerializationData
{
	void CompleteDeserialization(object deserialized);
}
