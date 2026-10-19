namespace System.Net;

[Flags]
internal enum FtpMethodFlags
{
	None = 0,
	IsDownload = 1,
	IsUpload = 2,
	TakesParameter = 4,
	MayTakeParameter = 8,
	DoesNotTakeParameter = 0x10,
	ParameterIsDirectory = 0x20,
	ShouldParseForResponseUri = 0x40,
	HasHttpCommand = 0x80,
	MustChangeWorkingDirectoryToPath = 0x100
}
