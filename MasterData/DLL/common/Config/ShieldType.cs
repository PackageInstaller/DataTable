using Google.Protobuf.Reflection;

namespace Config;

public enum ShieldType
{
	[OriginalName("ShieldType_NONE")]
	None = 0,
	[OriginalName("ShieldType_PHYSICS_BY_TIME")]
	PhysicsByTime = 2,
	[OriginalName("ShieldType_DARK_BY_TIME")]
	DarkByTime = 162,
	[OriginalName("ShieldType_WIND_BY_VALUE")]
	WindByValue = 33,
	[OriginalName("ShieldType_LIGHT_BY_VALUE")]
	LightByValue = 193,
	[OriginalName("ShieldType_PHYSICS_BY_VALUE")]
	PhysicsByValue = 1,
	[OriginalName("ShieldType_FIRE_BY_TIME")]
	FireByTime = 66,
	[OriginalName("ShieldType_FIRE_BY_VALUE")]
	FireByValue = 65,
	[OriginalName("ShieldType_DARK_BY_VALUE")]
	DarkByValue = 161,
	[OriginalName("ShieldType_ICE_BY_TIME")]
	IceByTime = 98,
	[OriginalName("ShieldType_WIND_BY_TIME")]
	WindByTime = 34,
	[OriginalName("ShieldType_THUNDER_BY_VALUE")]
	ThunderByValue = 225,
	[OriginalName("ShieldType_LIGHT_BY_TIME")]
	LightByTime = 194,
	[OriginalName("ShieldType_WARTER_BY_TIME")]
	WarterByTime = 130,
	[OriginalName("ShieldType_ICE_BY_VALUE")]
	IceByValue = 97,
	[OriginalName("ShieldType_WARTER_BY_VALUE")]
	WarterByValue = 129,
	[OriginalName("ShieldType_THUNDER_BY_TIME")]
	ThunderByTime = 226,
	[OriginalName("ShieldType_ALL_BY_TIME")]
	AllByTime = 4082,
	[OriginalName("ShieldType_ALL_BY_VALUE")]
	AllByValue = 4081
}
