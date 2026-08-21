using System.Collections.Generic;
using GameFramework.Resource;
using YooAsset;

namespace Ase;

public class YooAssetHelper : IResourceHelper
{
	private class RemoteServices : IRemoteServices
	{
		private readonly string defaultHostServer;

		private readonly string fallbackHostServer;

		public RemoteServices(string defaultHostServer, string fallbackHostServer)
		{
			this.defaultHostServer = defaultHostServer;
			this.fallbackHostServer = fallbackHostServer;
		}

		string IRemoteServices.GetRemoteMainURL(string fileName)
		{
			return defaultHostServer + "/" + fileName;
		}

		string IRemoteServices.GetRemoteFallbackURL(string fileName)
		{
			return fallbackHostServer + "/" + fileName;
		}
	}

	private readonly List<string> m_StackAssets = new List<string>();

	private bool m_EnableAssetStack;

	private string m_CurrentStackKey = string.Empty;

	public string GetRemoteMainURL(string packageName)
	{
		return ResourcesExtension.GetAssetRemoteURL(packageName);
	}

	public string GetRemoteFallbackURL(string packageName)
	{
		return ResourcesExtension.GetAssetFallbackURL(packageName);
	}

	public IRemoteServices GetRemoteServices(string defaultHostServer, string fallbackHostServer)
	{
		return (IRemoteServices)(object)new RemoteServices(defaultHostServer, fallbackHostServer);
	}

	public IWebDecryptionServices GetWebDecryption()
	{
		return null;
	}

	public EPlayMode GetResourcePlayMode(EPlayMode setMode)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		if ((int)setMode == 0)
		{
			return (EPlayMode)1;
		}
		return setMode;
	}
}
