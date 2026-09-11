using Google.Protobuf.Reflection;

namespace Config;

public enum RoleType
{
	[OriginalName("RoleType_None")]
	None = 0,
	[OriginalName("RoleType_Player")]
	Player = 1,
	[OriginalName("RoleType_Enemy")]
	Enemy = 2,
	[OriginalName("RoleType_Neutral")]
	Neutral = 4,
	[OriginalName("RoleType_Bunker")]
	Bunker = 8,
	[OriginalName("RoleType_Trigger")]
	Trigger = 0x10,
	[OriginalName("RoleType_Trap")]
	Trap = 0x20,
	[OriginalName("RoleType_Box")]
	Box = 0x40,
	[OriginalName("RoleType_Friend")]
	Friend = 0x80,
	[OriginalName("RoleType_Puppet")]
	Puppet = 0x100,
	[OriginalName("RoleType_AvoidShadow")]
	AvoidShadow = 0x200,
	[OriginalName("RoleType_AirWall")]
	AirWall = 0x400,
	[OriginalName("RoleType_PlayerSecond")]
	PlayerSecond = 0x800,
	[OriginalName("RoleType_PlayerThird")]
	PlayerThird = 0x1000
}
