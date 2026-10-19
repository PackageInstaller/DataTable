using Sirenix.Serialization;

namespace ACT.Battle.Configs;

public class ConfigAbilityList : LuminSerializedScriptableObject, IOverridesSerializationFormat
{
	public ConfigAbility[] abilities;

	public DataFormat GetFormatToSerializeAs(bool isPlayer)
	{
		return DataFormat.Binary;
	}
}
