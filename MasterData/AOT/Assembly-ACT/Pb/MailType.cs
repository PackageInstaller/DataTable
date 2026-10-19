using Google.Protobuf.Reflection;

namespace Pb;

public enum MailType
{
	[OriginalName("ZERO_FILL")]
	ZeroFill,
	[OriginalName("NORMAL")]
	Normal,
	[OriginalName("RARE")]
	Rare
}
