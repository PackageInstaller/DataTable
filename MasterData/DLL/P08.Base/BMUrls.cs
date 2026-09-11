using System;
using System.Collections.Generic;
using System.IO;
using LitJson;
using UnityEngine;

[Serializable]
public class BMUrls
{
	public Dictionary<string, string> downloadUrls;

	public Dictionary<string, string> downloadPersistentUrls;

	public Dictionary<string, string> outputs;

	public BuildPlatform bundleTarget = BuildPlatform.Windows;

	public bool useEditorTarget;

	public bool downloadFromOutput;

	public bool offlineCache;

	public bool serverListSwitch;

	public bool showLoginUI;

	public bool openCreatRoom;

	public List<string> serverList;

	public string defaultURL;

	public string staticURL;

	public string errorLogPath;

	public string logUploadURL;

	public int baseVersion;

	public int channel;

	public int build;

	public int logicframe;

	public int renderframe;

	public bool abXXTeaEncoding;

	public string abXXTeaEncyptKey;

	public bool hotfixEnable;

	public bool abEncypt;

	public List<string> hotfixSkipAB;

	public List<string> hotfixSkipVoice;

	public BMUrls()
	{
		downloadUrls = new Dictionary<string, string>
		{
			{ "WebPlayer", "" },
			{ "Windows", "" },
			{ "OSX", "" },
			{ "IOS", "" },
			{ "tvOS", "" },
			{ "Android", "" },
			{ "WP8", "" }
		};
		downloadPersistentUrls = new Dictionary<string, string>
		{
			{ "WebPlayer", "" },
			{ "Windows", "" },
			{ "OSX", "" },
			{ "IOS", "" },
			{ "tvOS", "" },
			{ "Android", "" },
			{ "WP8", "" }
		};
		outputs = new Dictionary<string, string>
		{
			{ "WebPlayer", "" },
			{ "Windows", "" },
			{ "OSX", "" },
			{ "IOS", "" },
			{ "tvOS", "" },
			{ "Android", "" },
			{ "WP8", "" }
		};
	}

	public string GetInterpretedDownloadUrl(BuildPlatform platform)
	{
		return BMUtility.InterpretPath(downloadUrls[platform.ToString()], platform);
	}

	public string GetInterpretedDownloadPersistentUrl(BuildPlatform platform)
	{
		return BMUtility.InterpretPath(downloadPersistentUrls[platform.ToString()], platform);
	}

	public string GetInterpretedOutputPath(BuildPlatform platform)
	{
		return BMUtility.InterpretPath(outputs[platform.ToString()], platform);
	}

	public static string SerializeToString(BMUrls urls)
	{
		return JsonMapper.ToJson(urls);
	}

	public static void SaveJsonFile(BMUrls data, string path)
	{
		using TextWriter textWriter = new StreamWriter(path);
		if (textWriter == null)
		{
			Debug.LogError("Cannot write to " + path);
			return;
		}
		string value = SerializeToString(data);
		textWriter.Write(value);
		textWriter.Flush();
		textWriter.Close();
	}
}
