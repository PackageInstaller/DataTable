using Google.Protobuf.Reflection;

namespace Pb;

public enum MailState
{
	[OriginalName("UNREAD")]
	Unread,
	[OriginalName("READ")]
	Read,
	[OriginalName("REWARD")]
	Reward,
	[OriginalName("DELETE")]
	Delete,
	[OriginalName("UNSEND")]
	Unsend
}
