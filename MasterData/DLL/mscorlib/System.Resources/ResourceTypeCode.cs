namespace System.Resources;

internal enum ResourceTypeCode
{
	Null = 0,
	String = 1,
	Boolean = 2,
	Char = 3,
	Byte = 4,
	SByte = 5,
	Int16 = 6,
	UInt16 = 7,
	Int32 = 8,
	UInt32 = 9,
	Int64 = 10,
	UInt64 = 11,
	Single = 12,
	Double = 13,
	Decimal = 14,
	DateTime = 15,
	TimeSpan = 16,
	LastPrimitive = TimeSpan,
	ByteArray = 32,
	Stream = 33,
	StartOfUserTypes = 64
}
