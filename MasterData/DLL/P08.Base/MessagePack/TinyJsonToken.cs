namespace MessagePack;

internal enum TinyJsonToken
{
	None,
	StartObject,
	EndObject,
	StartArray,
	EndArray,
	Number,
	String,
	True,
	False,
	Null
}
