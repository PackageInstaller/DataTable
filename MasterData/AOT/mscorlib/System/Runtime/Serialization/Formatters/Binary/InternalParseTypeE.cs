namespace System.Runtime.Serialization.Formatters.Binary;

internal enum InternalParseTypeE
{
	Empty,
	SerializedStreamHeader,
	Object,
	Member,
	ObjectEnd,
	MemberEnd,
	Headers,
	HeadersEnd,
	SerializedStreamHeaderEnd,
	Envelope,
	EnvelopeEnd,
	Body,
	BodyEnd
}
