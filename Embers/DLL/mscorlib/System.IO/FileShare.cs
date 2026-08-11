namespace System.IO;

[Flags]
public enum FileShare
{
	None = 0,
	Read = 1,
	Write = 2,
	ReadWrite = Read | Write,
	Delete = 4,
	Inheritable = 0x10
}
