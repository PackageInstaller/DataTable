namespace MessagePack;

internal enum ValueType : byte
{
	Null,
	True,
	False,
	Double,
	Long,
	ULong,
	Decimal,
	String
}
