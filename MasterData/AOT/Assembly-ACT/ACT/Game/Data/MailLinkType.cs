using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum MailLinkType
{
	[OriginalName("MAIL_LINK_TYPE_NONE")]
	None,
	[OriginalName("MAIL_LINK_TYPE_INNER")]
	Inner,
	[OriginalName("MAIL_LINK_TYPE_OUTER")]
	Outer,
	[OriginalName("MAIL_LINK_TYPE_GAME_CONTENT")]
	GameContent
}
