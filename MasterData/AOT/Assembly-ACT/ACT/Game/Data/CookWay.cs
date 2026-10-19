using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum CookWay
{
	[OriginalName("MENU")]
	Menu,
	[OriginalName("CUSTOM")]
	Custom,
	[OriginalName("SAVEDMENU")]
	Savedmenu,
	[OriginalName("RECOMMENDMENU")]
	Recommendmenu
}
