namespace ES3Internal;

internal enum ES3SpecialByte : byte
{
	Null = 0,
	Bool = 1,
	Byte = 2,
	Sbyte = 3,
	Char = 4,
	Decimal = 5,
	Double = 6,
	Float = 7,
	Int = 8,
	Uint = 9,
	Long = 10,
	Ulong = 11,
	Short = 12,
	Ushort = 13,
	String = 14,
	ByteArray = 15,
	Collection = 128,
	Dictionary = 129,
	CollectionItem = 130,
	Object = 254,
	Terminator = byte.MaxValue
}
