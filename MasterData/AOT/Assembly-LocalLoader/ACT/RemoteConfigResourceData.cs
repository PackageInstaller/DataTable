using System;

namespace ACT;

[Serializable]
internal class RemoteConfigResourceData
{
	public string cdn;

	public string backup_cdn;

	public string manifest_prefix;

	public string bundle_prefix;

	public RemoteConfigResourceNormalData normal;

	public RemoteConfigResourcePreDownloadData pre_download;

	public RemoteConfigResourceHotfixData hotfix;
}
