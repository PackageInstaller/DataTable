using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum EquipType
{
	[OriginalName("EQUIP_TYPE_NULL")]
	Null,
	[OriginalName("EQUIP_TYPE_FORCE")]
	Force,
	[OriginalName("EQUIP_TYPE_DYNAMIC")]
	Dynamic,
	[OriginalName("EQUIP_TYPE_ENERGY")]
	Energy,
	[OriginalName("EQUIP_TYPE_ASSIST")]
	Assist
}
