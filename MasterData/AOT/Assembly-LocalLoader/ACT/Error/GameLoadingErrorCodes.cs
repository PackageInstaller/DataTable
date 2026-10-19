namespace ACT.Error;

public static class GameLoadingErrorCodes
{
	public const string RemoteConfigNetworkError = "C01-0007";

	public const string RemoteConfigAnalyzeError = "C01-0008";

	public const string RemoteConfigMonoNull = "C01-0103";

	public const string RemoteConfigException = "C01-0104";

	public const string VersionCheckRefreshFail = "C01-0201";

	public const string ReadVersionFileFailed = "C01-0301";

	public const string AnalyzeVersionFileFailed = "C01-0302";

	public const string YooAssetPackageInitFailed = "C01-0401";

	public const string YooAssetPlayModeInitFailed = "C01-0402";

	public const string YooAssetRequestVersionFailed = "C01-0403";

	public const string YooAssetUpdateManifestFailed = "C01-0404";

	public const string YooAssetUnknownStep = "C01-0405";

	public const string DownloadZipFailed = "C01-0501";

	public const string ExtractZipFailed = "C03-0502";

	public const string WriteVersionInfoFailed = "C03-0504";

	public const string DownloadAssetUnknownStep = "C03-0505";

	public const string GetLocalAssetFailed = "C01-0506";

	public const string ZipVerificationFailed = "C03-0507";

	public const string AssetIsNotReady = "C03-0600";

	public const string CalculateResourceSizeFailed = "C03-0601";

	public const string DownloadMissingResourcesFailed = "C01-0602";

	public const string PackageNotFound = "C03-0603";

	public const string LoadDllAssetFailed = "C03-0701";

	public const string LoadMetadataFailed = "C03-0702";

	public const string LoadAssemblyFailed = "C03-0703";

	public const string HotUpdateAssemblyNull = "C03-0704";

	public const string InitDllUnknownStep = "C03-0705";

	public const string RuntimeDataInitFailed = "C01-0801";

	public const string AssemblyACTNotFound = "C01-0802";

	public const string RuntimeInitializerNotFound = "C01-0803";

	public const string APMInitFailed = "C01-1001";

	public const string ReadAppInfoFailed = "C01-1101";

	public const string DownloadAnnouncementBannerError = "C02-0014";

	public const string UnknownError = "C01-9999";

	public const string InsufficientDiskSpace = "C03-9902";

	public const string OverRetryCount = "C01-9903";

	public static string GetErrorMessage(string errorCode)
	{
		return errorCode switch
		{
			"C01-1101" => "版本信息初始化失败", 
			"C01-1001" => "APM初始化失败", 
			"C01-0301" => "读取版本文件失败", 
			"C01-0302" => "解析版本文件失败", 
			"C01-0007" => "获取远程配置网络错误", 
			"C01-0008" => "解析远程配置错误", 
			"C01-0103" => "远程配置初始化失败", 
			"C01-0104" => "远程配置初始化异常", 
			"C01-0201" => "获取远端版本号失败", 
			"C01-0501" => "下载资源包失败", 
			"C03-0502" => "解压资源包失败", 
			"C03-0504" => "版本信息更新失败", 
			"C03-0505" => "下载错误", 
			"C01-0506" => "获取本地资源失败", 
			"C03-0507" => "资源包校验失败", 
			"C01-0401" => "资源包初始化失败", 
			"C01-0402" => "资源加载模式初始化失败", 
			"C01-0403" => "请求资源版本失败", 
			"C01-0404" => "更新资源清单失败", 
			"C01-0405" => "资源初始化流程错误", 
			"C03-0600" => "资源异常", 
			"C03-0601" => "计算资源大小失败", 
			"C01-0602" => "下载缺失资源失败", 
			"C03-0603" => "资源包未找到", 
			"C03-0701" => "编译器初始化失败", 
			"C03-0702" => "编译器初始化失败", 
			"C03-0703" => "编译器初始化失败", 
			"C03-0704" => "编译器初始化失败", 
			"C03-0705" => "编译器初始化流程错误", 
			"C01-0801" => "运行时数据初始化失败", 
			"C01-0802" => "未找到运行程序集", 
			"C01-0803" => "未找到运行时初始化器", 
			"C02-0014" => "获取公告图片失败", 
			"C03-9902" => "磁盘空间不足", 
			"C01-9999" => "未知错误", 
			"C01-9903" => "重试失败", 
			_ => "未定义的错误", 
		};
	}
}
