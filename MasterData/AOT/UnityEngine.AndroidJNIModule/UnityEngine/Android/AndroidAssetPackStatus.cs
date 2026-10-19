namespace UnityEngine.Android;

public enum AndroidAssetPackStatus
{
	Unknown,
	Pending,
	Downloading,
	Transferring,
	Completed,
	Failed,
	Canceled,
	WaitingForWifi,
	NotInstalled
}
