namespace ACT;

public class RemoteConfigPreDownload
{
	public int AssetsVersion { get; private set; }

	public int ClientStaticVersion { get; private set; }

	public int DllVersion { get; private set; }

	public int RawFileVersion { get; private set; }

	public ZipInfo[] DiffAssetInfos { get; private set; }

	public ZipInfo[] DiffClientStaticInfos { get; private set; }

	public ZipInfo[] DiffDllInfos { get; private set; }

	public ZipInfo[] DiffRawFileInfos { get; private set; }

	internal static RemoteConfigPreDownload Restore(RemoteConfigResourcePreDownloadData assets, RemoteConfigResourcePreDownloadData clientStatic, RemoteConfigResourcePreDownloadData dll, RemoteConfigResourcePreDownloadData rawFile)
	{
		if (assets == null && clientStatic == null && dll == null && rawFile == null)
		{
			return null;
		}
		return new RemoteConfigPreDownload
		{
			AssetsVersion = (assets?.version ?? 0),
			ClientStaticVersion = (clientStatic?.version ?? 0),
			DllVersion = (dll?.version ?? 0),
			RawFileVersion = (rawFile?.version ?? 0),
			DiffAssetInfos = assets?.diff,
			DiffClientStaticInfos = clientStatic?.diff,
			DiffDllInfos = dll?.diff,
			DiffRawFileInfos = rawFile?.diff
		};
	}

	public bool HasAnyDiffZipInfos()
	{
		if (!HasZipInfos(DiffAssetInfos) && !HasZipInfos(DiffClientStaticInfos) && !HasZipInfos(DiffDllInfos))
		{
			return HasZipInfos(DiffRawFileInfos);
		}
		return true;
	}

	private static bool HasZipInfos(ZipInfo[] infos)
	{
		if (infos != null)
		{
			return infos.Length != 0;
		}
		return false;
	}
}
