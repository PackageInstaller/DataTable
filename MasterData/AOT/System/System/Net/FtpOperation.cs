namespace System.Net;

internal enum FtpOperation
{
	DownloadFile,
	ListDirectory,
	ListDirectoryDetails,
	UploadFile,
	UploadFileUnique,
	AppendFile,
	DeleteFile,
	GetDateTimestamp,
	GetFileSize,
	Rename,
	MakeDirectory,
	RemoveDirectory,
	PrintWorkingDirectory,
	Other
}
