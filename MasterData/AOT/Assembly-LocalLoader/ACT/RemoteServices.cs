using YooAsset;

namespace ACT;

internal class RemoteServices : IRemoteServices
{
	private readonly string _defaultHostServer;

	private readonly string _fallbackHostServer;

	private readonly string _packageName;

	internal readonly string _integrityCdnPath;

	private readonly AssetType _assetType;

	private const int _prefixLength = 2;

	public static bool UseIntegrityCdn;

	public RemoteServices(string defaultHostServer, string fallbackHostServer, string integrityCdnPath, AssetType assetType, string packageName = null)
	{
		_defaultHostServer = defaultHostServer;
		_fallbackHostServer = fallbackHostServer;
		_integrityCdnPath = integrityCdnPath;
		_assetType = assetType;
		_packageName = packageName;
	}

	string IRemoteServices.GetRemoteMainURL(string fileName)
	{
		if (UseIntegrityCdn && !string.IsNullOrEmpty(_integrityCdnPath) && !string.IsNullOrEmpty(_packageName))
		{
			string text = ((fileName.Length >= 2) ? fileName.Substring(0, 2) : fileName);
			return LuminApplication.GetCDNPath(_assetType) + _integrityCdnPath + "/" + text + "/" + fileName;
		}
		return LuminApplication.GetCDNPath(_assetType) + _defaultHostServer + "/" + fileName;
	}

	string IRemoteServices.GetRemoteFallbackURL(string fileName)
	{
		if (UseIntegrityCdn && !string.IsNullOrEmpty(_integrityCdnPath) && !string.IsNullOrEmpty(_packageName))
		{
			string text = ((fileName.Length >= 2) ? fileName.Substring(0, 2) : fileName);
			return LuminApplication.GetBackUpCDNPath(_assetType) + _integrityCdnPath + "/" + text + "/" + fileName;
		}
		return LuminApplication.GetBackUpCDNPath(_assetType) + _fallbackHostServer + "/" + fileName;
	}

	string IRemoteServices.GetDeviceId()
	{
		return LuminApplication.DeviceId;
	}
}
