namespace ACT;

public class ZipDownloadParam
{
	public ZipInfo[] DllZipDownloadURLs;

	public ZipInfo[] ClientStaticZipDownloadURLs;

	public ZipInfo[] AssetsZipDownloadURLs;

	public ZipInfo[] RawFileZipDownloadURLs;

	public string[] DownloadTags;

	public string[] IntegrityDownloadTags;

	public bool WriteVersionInfo = true;

	public bool IsPreDownload;

	public string PreDownloadVersionKey;

	public bool UsePreDownloadedPackages = true;

	public RemoteConfigZipSource Source = RemoteConfigZipSource.Normal;
}
