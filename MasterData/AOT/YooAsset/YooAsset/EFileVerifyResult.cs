namespace YooAsset;

internal enum EFileVerifyResult
{
	Exception = -7,
	CacheNotFound,
	InfoFileNotExisted,
	DataFileNotExisted,
	FileNotComplete,
	FileOverflow,
	FileCrcError,
	None,
	Succeed
}
