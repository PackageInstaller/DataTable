namespace Sirenix.Serialization;

public interface IOverridesSerializationPolicy
{
	ISerializationPolicy SerializationPolicy { get; }

	bool OdinSerializesUnityFields { get; }
}
