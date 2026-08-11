using YooAsset;

namespace GameFramework.Resource;

public interface IResourceHelper
{
	string GetRemoteMainURL(string packageName);

	string GetRemoteFallbackURL(string packageName);

	IRemoteServices GetRemoteServices(string defaultHostServer, string fallbackHostServer);

	IWebDecryptionServices GetWebDecryption();

	EPlayMode GetResourcePlayMode(EPlayMode setMode);
}
