using System.Collections.Generic;

namespace ACT;

public class RemoteConfig
{
	private List<int> _clientBlockIds;

	public static readonly RemoteConfig Empty = new RemoteConfig();

	public int BuildId { get; private set; }

	public int AssetsVersion { get; private set; }

	public int DllVersion { get; private set; }

	public int ClientStaticVersion { get; private set; }

	public int RawFileVersion { get; private set; }

	public string ServerUrl { get; private set; }

	public string ServerName { get; private set; }

	public string CdnUrl { get; private set; }

	public string BackUpCdnUrl { get; private set; }

	public string ClientStaticCdnUrl { get; private set; }

	public string ClientStaticBackUpCdnUrl { get; private set; }

	public string DllCdnUrl { get; private set; }

	public string DllBackUpCdnUrl { get; private set; }

	public string RawFileCdnUrl { get; private set; }

	public string RawFileBackUpCdnUrl { get; private set; }

	public string ManifestPrefix { get; private set; }

	public string ClientStaticManifestPrefix { get; private set; }

	public string DllManifestPrefix { get; private set; }

	public string RawFileManifestPrefix { get; private set; }

	public string BundlePrefix { get; private set; }

	public string ClientStaticBundlePrefix { get; private set; }

	public string DllBundlePrefix { get; private set; }

	public string RawFileBundlePrefix { get; private set; }

	public ZipInfo[] FullAssetInfos { get; private set; }

	public ZipInfo[] FullClientStaticInfos { get; private set; }

	public ZipInfo[] FullDllInfos { get; private set; }

	public ZipInfo[] FullRawFileInfos { get; private set; }

	public ZipInfo[] DiffAssetInfos { get; private set; }

	public ZipInfo[] DiffClientStaticInfos { get; private set; }

	public ZipInfo[] DiffDllInfos { get; private set; }

	public ZipInfo[] DiffRawFileInfos { get; private set; }

	public RemoteConfigPreDownload PreDownload { get; private set; }

	public RemoteConfigHotfix Hotfix { get; private set; }

	public ClientUpdateType UpdateType { get; private set; }

	public string UpdateNoticeContent { get; private set; }

	public string DisplayVersion { get; private set; }

	internal static RemoteConfig Restore(RemoteConfigData data)
	{
		if (data == null)
		{
			return null;
		}
		RemoteConfig remoteConfig = new RemoteConfig
		{
			BuildId = data.build_id,
			CdnUrl = data.assets?.cdn,
			BackUpCdnUrl = data.assets?.backup_cdn,
			ClientStaticCdnUrl = data.client_static?.cdn,
			ClientStaticBackUpCdnUrl = data.client_static?.backup_cdn,
			DllCdnUrl = data.dll?.cdn,
			DllBackUpCdnUrl = data.dll?.backup_cdn,
			RawFileCdnUrl = data.raw_file?.cdn,
			RawFileBackUpCdnUrl = data.raw_file?.backup_cdn,
			AssetsVersion = (data.assets?.normal?.version).GetValueOrDefault(),
			DllVersion = (data.dll?.normal?.version).GetValueOrDefault(),
			ClientStaticVersion = (data.client_static?.normal?.version).GetValueOrDefault(),
			RawFileVersion = (data.raw_file?.normal?.version).GetValueOrDefault(),
			ServerUrl = data.server_url,
			ServerName = data.server_name,
			ManifestPrefix = data.assets?.manifest_prefix,
			ClientStaticManifestPrefix = data.client_static?.manifest_prefix,
			DllManifestPrefix = data.dll?.manifest_prefix,
			RawFileManifestPrefix = data.raw_file?.manifest_prefix,
			BundlePrefix = data.assets?.bundle_prefix,
			ClientStaticBundlePrefix = data.client_static?.bundle_prefix,
			DllBundlePrefix = data.dll?.bundle_prefix,
			RawFileBundlePrefix = data.raw_file?.bundle_prefix,
			FullAssetInfos = data.assets?.normal?.full,
			FullRawFileInfos = data.raw_file?.normal?.full,
			FullClientStaticInfos = data.client_static?.normal?.full,
			FullDllInfos = data.dll?.normal?.full,
			DiffAssetInfos = data.assets?.normal?.diff,
			DiffRawFileInfos = data.raw_file?.normal?.diff,
			DiffClientStaticInfos = data.client_static?.normal?.diff,
			DiffDllInfos = data.dll?.normal?.diff,
			UpdateNoticeContent = data.update_link,
			UpdateType = (ClientUpdateType)data.update_type,
			PreDownload = RemoteConfigPreDownload.Restore(data.assets?.pre_download, data.client_static?.pre_download, data.dll?.pre_download, data.raw_file?.pre_download),
			Hotfix = RemoteConfigHotfix.Restore(data.assets?.hotfix, data.client_static?.hotfix, data.dll?.hotfix, data.raw_file?.hotfix)
		};
		List<int> list = (remoteConfig._clientBlockIds = new List<int>());
		if (data.client_shield != null)
		{
			string[] client_shield = data.client_shield;
			for (int i = 0; i < client_shield.Length; i++)
			{
				if (int.TryParse(client_shield[i], out var result))
				{
					list.Add(result);
				}
			}
		}
		return remoteConfig;
	}

	private RemoteConfig()
	{
	}

	public VersionConfig GetVersionConfig()
	{
		return new VersionConfig(AssetsVersion, DllVersion, ClientStaticVersion, RawFileVersion);
	}

	internal bool FeatureIsBlocked(int systemType)
	{
		return _clientBlockIds.Contains(systemType);
	}
}
