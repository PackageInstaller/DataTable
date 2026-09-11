using Google.Protobuf.Reflection;

namespace Config;

public enum WeaponCategory
{
	[OriginalName("WeaponCategory_None")]
	None,
	[OriginalName("WeaponCategory_Sword")]
	Sword,
	[OriginalName("WeaponCategory_LongHandled")]
	LongHandled,
	[OriginalName("WeaponCategory_Bow")]
	Bow,
	[OriginalName("WeaponCategory_Blunt")]
	Blunt,
	[OriginalName("WeaponCategory_Gun")]
	Gun,
	[OriginalName("WeaponCategory_Claw")]
	Claw,
	[OriginalName("WeaponCategory_Body")]
	Body,
	[OriginalName("WeaponCategory_Magic")]
	Magic,
	[OriginalName("WeaponCategory_Orb")]
	Orb
}
