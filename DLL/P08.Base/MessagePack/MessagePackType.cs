namespace MessagePack;

public enum MessagePackType : byte
{
	Unknown,
	Integer,
	Nil,
	Boolean,
	Float,
	String,
	Binary,
	Array,
	Map,
	Extension
}
