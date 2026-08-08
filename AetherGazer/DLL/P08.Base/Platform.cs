using System;
using System.Collections.Generic;
using System.IO;
using LitJson;
using MessagePack;
using MessagePack.Resolvers;
using UnityEngine;

public class Platform
{
	private static BuildPlatform curPlatform;

	private static BMUrls bmUrl = null;

	private static string downloadPathStr = string.Empty;

	private static string downloadPersistentPathStr = string.Empty;

	private static string downloadRootUrl = string.Empty;

	private static string downloadEditorPath = string.Empty;

	private static string outputABPath = string.Empty;

	private static string outputABEditorPath = string.Empty;

	private static bool isRegMP = false;

	public static string BundleId => Application.identifier;

	public static bool IsShowLoginUI
	{
		get
		{
			if (bmUrl == null)
			{
				bmUrl = GetURL();
			}
			return bmUrl.showLoginUI;
		}
	}

	public static bool IsOpenCreatRoom
	{
		get
		{
			if (bmUrl == null)
			{
				bmUrl = GetURL();
			}
			return bmUrl.openCreatRoom;
		}
	}

	public static void Clear()
	{
		bmUrl = null;
		downloadPathStr = string.Empty;
		downloadPersistentPathStr = string.Empty;
		downloadRootUrl = string.Empty;
		downloadEditorPath = string.Empty;
		outputABPath = string.Empty;
		outputABEditorPath = string.Empty;
	}

	public static BMUrls GetURL()
	{
		if (bmUrl == null)
		{
			TextAsset textAsset = (TextAsset)Resources.Load("Urls");
			try
			{
				bmUrl = JsonMapper.ToObject<BMUrls>(textAsset.text);
			}
			catch (Exception ex)
			{
				Debug.LogError(ex.Message);
			}
		}
		return bmUrl;
	}

	public static BuildPlatform GetPlatform()
	{
		bmUrl = GetURL();
		if (Application.platform == RuntimePlatform.WindowsEditor)
		{
			curPlatform = bmUrl.bundleTarget;
		}
		else if (Application.platform == RuntimePlatform.OSXEditor)
		{
			curPlatform = BuildPlatform.OSX;
		}
		else
		{
			curPlatform = GetRuntimePlatform();
		}
		return curPlatform;
	}

	public static string GetPlatformName()
	{
		return GetPlatform().ToString();
	}

	public static string GetDownloadURL(string manualUrl = "")
	{
		if (string.IsNullOrEmpty(downloadRootUrl))
		{
			bmUrl = GetURL();
			downloadRootUrl = new Uri(GetDownloadPath(manualUrl)).AbsoluteUri;
		}
		return downloadRootUrl;
	}

	public static string GetDownloadPath(string manualUrl = "")
	{
		if (string.IsNullOrEmpty(downloadPathStr))
		{
			bmUrl = GetURL();
			curPlatform = GetPlatform();
			if (manualUrl == "")
			{
				downloadPathStr = bmUrl.GetInterpretedDownloadUrl(curPlatform);
			}
			else
			{
				downloadPathStr = BMUtility.InterpretPath(manualUrl, curPlatform);
			}
		}
		return downloadPathStr;
	}

	public static string GetDownloadPersistentDataPath(string manualUrl = "")
	{
		if (string.IsNullOrEmpty(downloadPersistentPathStr))
		{
			bmUrl = GetURL();
			curPlatform = GetPlatform();
			if (manualUrl == "")
			{
				downloadPersistentPathStr = bmUrl.GetInterpretedDownloadPersistentUrl(curPlatform);
			}
			else
			{
				downloadPersistentPathStr = BMUtility.InterpretPath(manualUrl, curPlatform);
			}
		}
		return downloadPersistentPathStr;
	}

	public static string GetABOutputPath()
	{
		if (string.IsNullOrEmpty(outputABPath))
		{
			bmUrl = GetURL();
			curPlatform = GetPlatform();
			outputABPath = bmUrl.GetInterpretedOutputPath(curPlatform);
		}
		return outputABPath;
	}

	public static string GetABEncryptOutputPath()
	{
		return GetABOutputPath() + "../../encrypt";
	}

	public static BuildPlatform GetRuntimePlatform()
	{
		if (Application.platform == RuntimePlatform.WindowsPlayer || Application.platform == RuntimePlatform.LinuxPlayer)
		{
			return BuildPlatform.Windows;
		}
		if (Application.platform == RuntimePlatform.OSXPlayer)
		{
			return BuildPlatform.OSX;
		}
		if (Application.platform == RuntimePlatform.IPhonePlayer)
		{
			return BuildPlatform.IOS;
		}
		if (Application.platform == RuntimePlatform.tvOS)
		{
			return BuildPlatform.tvOS;
		}
		if (Application.platform == RuntimePlatform.Android)
		{
			return BuildPlatform.Android;
		}
		Debug.LogWarning("Platform " + Application.platform.ToString() + " is not supported by BundleManager.");
		return BuildPlatform.Windows;
	}

	public static List<string> GetServerURLList()
	{
		if (bmUrl == null)
		{
			bmUrl = GetURL();
		}
		return bmUrl.serverList;
	}

	public static bool GetServerListSwitch()
	{
		if (bmUrl == null)
		{
			bmUrl = GetURL();
		}
		return bmUrl.serverListSwitch;
	}

	public static string GetServerURL()
	{
		if (bmUrl == null)
		{
			bmUrl = GetURL();
		}
		return bmUrl.defaultURL;
	}

	public static string GetStaticURL()
	{
		if (bmUrl == null)
		{
			bmUrl = GetURL();
		}
		return bmUrl.staticURL;
	}

	public static string GetErrorLogPath()
	{
		if (bmUrl == null)
		{
			bmUrl = GetURL();
		}
		string text = BMUtility.InterpretPath(bmUrl.errorLogPath, GetRuntimePlatform());
		Debug.Log("ErrorLogPath == " + text);
		return text;
	}

	public static string GetLogUploadURL()
	{
		if (bmUrl == null)
		{
			bmUrl = GetURL();
		}
		return bmUrl.logUploadURL;
	}

	public static int GetBaseVersion()
	{
		if (bmUrl == null)
		{
			bmUrl = GetURL();
		}
		return bmUrl.baseVersion;
	}

	public static int GetLocalChannel()
	{
		if (bmUrl == null)
		{
			bmUrl = GetURL();
		}
		return bmUrl.channel;
	}

	public static int GetBuild()
	{
		if (bmUrl == null)
		{
			bmUrl = GetURL();
		}
		return bmUrl.build;
	}

	public static int GetLogicFrame()
	{
		if (bmUrl == null)
		{
			bmUrl = GetURL();
		}
		return bmUrl.logicframe;
	}

	public static int GetRenderFrame()
	{
		if (bmUrl == null)
		{
			bmUrl = GetURL();
		}
		return bmUrl.renderframe;
	}

	public static bool GetHotfixEnable()
	{
		if (bmUrl == null)
		{
			bmUrl = GetURL();
		}
		return bmUrl.hotfixEnable;
	}

	public static bool CheckABXXtea()
	{
		if (bmUrl == null)
		{
			bmUrl = GetURL();
		}
		return bmUrl.abXXTeaEncoding;
	}

	public static string GetABXXteaKey()
	{
		if (bmUrl == null)
		{
			bmUrl = GetURL();
		}
		return bmUrl.abXXTeaEncyptKey;
	}

	public static bool CheckABEncypt()
	{
		if (bmUrl == null)
		{
			bmUrl = GetURL();
		}
		return bmUrl.abEncypt;
	}

	public static T GetMPFile<T>(string path)
	{
		if (!isRegMP)
		{
			isRegMP = true;
			StaticCompositeResolver.Instance.Register(GeneratedResolver.Instance, BuiltinResolver.Instance, StandardResolver.Instance, PrimitiveObjectResolver.Instance);
			MessagePackSerializer.DefaultOptions = MessagePackSerializer.DefaultOptions.WithResolver(StaticCompositeResolver.Instance);
		}
		return MessagePackSerializer.Deserialize<T>(File.ReadAllBytes(path));
	}

	public static T GetMPFile<T>(byte[] content)
	{
		if (!isRegMP)
		{
			isRegMP = true;
			StaticCompositeResolver.Instance.Register(GeneratedResolver.Instance, BuiltinResolver.Instance, StandardResolver.Instance, PrimitiveObjectResolver.Instance);
			MessagePackSerializer.DefaultOptions = MessagePackSerializer.DefaultOptions.WithResolver(StaticCompositeResolver.Instance);
		}
		return MessagePackSerializer.Deserialize<T>(content);
	}

	public static void SaveMPFile<T>(T data, string path)
	{
		if (!isRegMP)
		{
			isRegMP = true;
			StaticCompositeResolver.Instance.Register(GeneratedResolver.Instance, BuiltinResolver.Instance, StandardResolver.Instance, PrimitiveObjectResolver.Instance);
			MessagePackSerializer.DefaultOptions = MessagePackSerializerOptions.Standard.WithResolver(StaticCompositeResolver.Instance);
		}
		byte[] bytes = MessagePackSerializer.Serialize(data);
		File.WriteAllBytes(path, bytes);
	}

	public static void SaveJsonFile<T>(T data, string path, bool PrettyPrint = false)
	{
		using TextWriter textWriter = new StreamWriter(path);
		if (textWriter == null)
		{
			Debug.LogError("Cannot write to " + path);
			return;
		}
		JsonWriter jsonWriter = new JsonWriter(textWriter);
		jsonWriter.PrettyPrint = PrettyPrint;
		JsonMapper.ToJson(data, jsonWriter);
		textWriter.Flush();
		textWriter.Close();
	}

	public static T GetJsonFile<T>(string path)
	{
		using TextReader textReader = new StreamReader(path);
		if (textReader == null)
		{
			Debug.LogError("Cannot write to " + path);
			return default(T);
		}
		return JsonMapper.ToObject<T>(textReader);
	}

	public static string GetStreamingPath()
	{
		string text = Application.streamingAssetsPath + "/";
		if (Application.platform == RuntimePlatform.Android)
		{
			return "jar:file://" + Application.dataPath + "!/assets/";
		}
		if (Application.platform == RuntimePlatform.IPhonePlayer)
		{
			return "file://" + text;
		}
		return "file:///" + text;
	}
}
