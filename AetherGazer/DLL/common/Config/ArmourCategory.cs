using Google.Protobuf.Reflection;

namespace Config;

public enum ArmourCategory
{
	[OriginalName("ArmourCategory_None")]
	None,
	[OriginalName("ArmourCategory_Body")]
	Body,
	[OriginalName("ArmourCategory_LightArmour")]
	LightArmour,
	[OriginalName("ArmourCategory_HeavyArmour")]
	HeavyArmour,
	[OriginalName("ArmourCategory_Metal")]
	Metal
}
