using System.Collections.Generic;
using System.IO;
using CriWare;

public class CriWareExtension
{
	public static string localizationFlag = "zh";

	public static string[] m_inPackageList = null;

	public static Dictionary<string, AssetHashManifest> m_voiceAssetHasnManifest = null;

	public static string GetDownloadPersistentDataPath()
	{
		return Path.Combine(Platform.GetDownloadPersistentDataPath(), "../Voice/");
	}

	public static void AddAssetHashManifestr(string pAbbr, AssetHashManifest pAssetHashManifest)
	{
		if (m_voiceAssetHasnManifest == null)
		{
			m_voiceAssetHasnManifest = new Dictionary<string, AssetHashManifest>();
		}
		m_voiceAssetHasnManifest[pAbbr] = pAssetHashManifest;
	}

	public static bool TryGetBundleFileName(string bundleName, out string fileName)
	{
		fileName = string.Empty;
		if (m_voiceAssetHasnManifest == null)
		{
			return false;
		}
		if (m_voiceAssetHasnManifest.ContainsKey(localizationFlag) && m_voiceAssetHasnManifest[localizationFlag].mBundleName2FileInfo.TryGetValue(bundleName, out var value))
		{
			fileName = value.mFilePath;
			return true;
		}
		if (string.IsNullOrEmpty(fileName))
		{
			return false;
		}
		return true;
	}

	public static bool TryGetFilePath(string pFileName, out string pFilePath)
	{
		string fileName = pFileName;
		if (!TryGetBundleFileName(pFileName, out fileName) && !AssetManager.TryGetBundleFileName(pFileName, out fileName))
		{
			fileName = pFileName;
		}
		else
		{
			AssetManager.AppendABLoadLog(pFileName, fileName);
		}
		string text = Path.Combine(GetDownloadPersistentDataPath(), localizationFlag, fileName);
		if (File.Exists(text))
		{
			pFilePath = text;
			return true;
		}
		string text2 = Path.Combine(Common.persistentDataPath, fileName);
		if (File.Exists(text2))
		{
			pFilePath = text2;
			return true;
		}
		pFilePath = fileName;
		return false;
	}

	public static bool HasVoiceFileInPersistentData(string pFileName)
	{
		string fileName = pFileName;
		if (!TryGetBundleFileName(pFileName, out fileName) && !AssetManager.TryGetBundleFileName(pFileName, out fileName))
		{
			fileName = pFileName;
		}
		else
		{
			AssetManager.AppendABLoadLog(pFileName, fileName);
		}
		if (fileName.Contains("story_v_empty"))
		{
			return true;
		}
		if (File.Exists(Path.Combine(GetDownloadPersistentDataPath(), localizationFlag, fileName)))
		{
			return true;
		}
		return false;
	}

	public static AssetHashManifest GetAssetHashManifest()
	{
		if (m_voiceAssetHasnManifest == null)
		{
			return null;
		}
		if (m_voiceAssetHasnManifest.ContainsKey(localizationFlag))
		{
			return m_voiceAssetHasnManifest[localizationFlag];
		}
		return null;
	}
}
