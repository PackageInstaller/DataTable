namespace Sirenix.Serialization;

public interface ISelfFormatter
{
	void Serialize(IDataWriter writer);

	void Deserialize(IDataReader reader);
}
