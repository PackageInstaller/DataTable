using System.IO;
using System.Text;

namespace FlowCanvas.Core;

public static class fsUtility
{
	public static readonly string S_DIR = Platform.GetDownloadPath() + "ABRes";

	public static readonly string S_CONFIG_PATH = S_DIR + "/Config.bytes";

	public static readonly string S_FS_CONFIG_JSON_PATH = S_DIR + "/fsPrefabConfig.json";

	public static readonly string S_COL_CONFIG_JSON_PATH = S_DIR + "/levelExtraCollisions.json";

	public static readonly string S_FS_CATEGORY_CONFIG_JSON_PATH = S_DIR + "/FlowScriptCategory.json";

	public static readonly string S_BB_BIN_DIR = S_DIR + "/FlowScript/";

	public static readonly string S_FS_BIN_DIR = S_DIR + "/FlowScript/";

	public static readonly string S_PREFAB_SUFFIX = ".prefab";

	public static readonly string S_ASSET_SUFFIX = ".asset";

	public static readonly string S_JSON_SUFFIX = ".json";

	public static readonly string S_BYTES_SUFFIX = ".bytes";

	public static readonly string S_BB_SUFFIX = ".bbb";

	public static readonly string S_FS_SUFFIX = ".bfs";

	public static readonly string S_MD_SUFFIX = ".bmd";

	public static void GetFullPrefabPath(ref string prefabPath)
	{
		if (!prefabPath.Contains(S_PREFAB_SUFFIX))
		{
			prefabPath += S_PREFAB_SUFFIX;
		}
	}

	public static string GetBlackBoardBinPathFromPrefabPath(string prefabPath)
	{
		return prefabPath.Replace("FlowScript/", S_BB_BIN_DIR).Replace(S_PREFAB_SUFFIX, S_BB_SUFFIX);
	}

	public static string GetGraphBinPathFromAssetPath(string assetPath)
	{
		return assetPath.Replace("FlowScript/", S_FS_BIN_DIR).Replace(S_ASSET_SUFFIX, "") + S_FS_SUFFIX;
	}

	public static string GetGraphName(string path)
	{
		string text = path.Replace(S_ASSET_SUFFIX, "").Replace(S_FS_SUFFIX, "");
		return text.Substring(text.LastIndexOf("/") + 1);
	}

	public static string ReadTextContent(string filePath)
	{
		string empty = string.Empty;
		if (!File.Exists(filePath))
		{
			return empty;
		}
		using StreamReader streamReader = new StreamReader(filePath, Encoding.UTF8);
		return streamReader.ReadToEnd();
	}

	public static byte[] ReadByteContent(string filePath)
	{
		byte[] result = null;
		if (!File.Exists(filePath))
		{
			return result;
		}
		using FileStream fileStream = new FileStream(filePath, FileMode.Open, FileAccess.Read);
		result = new byte[fileStream.Length];
		fileStream.Read(result, 0, result.Length);
		fileStream.Close();
		return result;
	}
}
