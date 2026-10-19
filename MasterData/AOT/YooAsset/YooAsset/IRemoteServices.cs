namespace YooAsset;

public interface IRemoteServices
{
	string GetRemoteMainURL(string fileName);

	string GetRemoteFallbackURL(string fileName);

	string GetDeviceId();
}
