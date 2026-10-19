using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum ContactSessionState
{
	[OriginalName("CONTACT_SESSION_STATE_LOCK")]
	Lock,
	[OriginalName("CONTACT_SESSION_STATE_ONGOING")]
	Ongoing,
	[OriginalName("CONTACT_SESSION_STATE_FINISH")]
	Finish
}
