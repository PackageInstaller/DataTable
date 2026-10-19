namespace System;

[Flags]
internal enum UnescapeMode
{
	CopyOnly = 0,
	Escape = 1,
	Unescape = 2,
	EscapeUnescape = Escape | Unescape,
	V1ToStringFlag = 4,
	UnescapeAll = 8,
	UnescapeAllOrThrow = 0x18
}
