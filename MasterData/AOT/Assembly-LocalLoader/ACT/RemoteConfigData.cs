using System;

namespace ACT;

[Serializable]
internal class RemoteConfigData
{
	public int build_id;

	public string client_version;

	public RemoteConfigResourceData assets;

	public RemoteConfigResourceData client_static;

	public RemoteConfigResourceData dll;

	public RemoteConfigResourceData raw_file;

	public string[] client_shield;

	public string server_url;

	public string server_name;

	public int update_type;

	public string update_link;

	public RemoteConfigPreDownloadData pre_download;
}
