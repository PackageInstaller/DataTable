namespace System.IO;

internal enum MonoFileType
{
	Unknown = 0,
	Disk = 1,
	Char = 2,
	Pipe = 3,
	Remote = 32768
}
