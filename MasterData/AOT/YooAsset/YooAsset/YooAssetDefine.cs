using System.Collections.Generic;

namespace YooAsset;

public class YooAssetDefine
{
	public const string ASSETS_PACKAGE = "Assets";

	public const string RAW_FILE_PACKAGE = "RawFile";

	public const string CLINET_STATIC_PACKAGE = "ClientStatic";

	public const string DLL_PACKAGE = "Dll";

	public static List<string> PACKAGES = new List<string> { "Assets", "ClientStatic", "Dll", "RawFile" };
}
