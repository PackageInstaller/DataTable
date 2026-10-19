using Google.Protobuf.Reflection;

namespace Google.Protobuf.WellKnownTypes;

public enum Syntax
{
	[OriginalName("SYNTAX_PROTO2")]
	Proto2,
	[OriginalName("SYNTAX_PROTO3")]
	Proto3
}
