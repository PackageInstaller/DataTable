namespace System.IO;

[Flags]
public enum FileOptions
{
	None = 0,
	WriteThrough = int.MinValue,
	Asynchronous = 0x40000000,
	RandomAccess = 0x10000000,
	DeleteOnClose = 0x4000000,
	SequentialScan = 0x8000000,
	Encrypted = 0x4000
}
