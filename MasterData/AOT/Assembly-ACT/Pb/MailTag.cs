using Google.Protobuf.Reflection;

namespace Pb;

public enum MailTag
{
	[OriginalName("NOTAG")]
	Notag,
	[OriginalName("COLLECT")]
	Collect
}
