using Google.Protobuf.Reflection;

namespace Pb;

public enum RecordConversationOP
{
	[OriginalName("RecordConversationAdd")]
	RecordConversationAdd,
	[OriginalName("RecordConversationReset")]
	RecordConversationReset
}
