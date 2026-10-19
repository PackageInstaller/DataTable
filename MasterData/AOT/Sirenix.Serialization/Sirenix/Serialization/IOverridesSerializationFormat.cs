namespace Sirenix.Serialization;

public interface IOverridesSerializationFormat
{
	DataFormat GetFormatToSerializeAs(bool isPlayer);
}
