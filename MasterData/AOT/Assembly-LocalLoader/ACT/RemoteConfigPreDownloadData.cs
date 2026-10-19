using System;

namespace ACT;

[Serializable]
internal class RemoteConfigPreDownloadData
{
	public int assets_version;

	public int client_static_version;

	public int dll_version;

	public int raw_file_version;

	public ZipInfo[] diff_assets;

	public ZipInfo[] diff_client_static;

	public ZipInfo[] diff_dll;

	public ZipInfo[] diff_raw_file;
}
