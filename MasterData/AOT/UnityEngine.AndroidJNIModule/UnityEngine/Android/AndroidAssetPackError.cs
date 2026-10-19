namespace UnityEngine.Android;

public enum AndroidAssetPackError
{
	NoError = 0,
	AppUnavailable = -1,
	PackUnavailable = -2,
	InvalidRequest = -3,
	DownloadNotFound = -4,
	ApiNotAvailable = -5,
	NetworkError = -6,
	AccessDenied = -7,
	InsufficientStorage = -10,
	PlayStoreNotFound = -11,
	NetworkUnrestricted = -12,
	AppNotOwned = -13,
	InternalError = -100
}
