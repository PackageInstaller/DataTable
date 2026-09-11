using System;
using System.IO;
using LuaInterface;
using UnityEngine;

public class PathManager
{
	private static PathManager _inst;

	public static PathManager inst
	{
		get
		{
			if (_inst == null)
			{
				_inst = new PathManager();
			}
			return _inst;
		}
	}

	public void Init()
	{
	}

	public string GetLuaBundle()
	{
		Platform.GetPlatformName();
		string text = "";
		text = ((IntPtr.Size == 4) ? "32" : "64");
		return "scripts" + text;
	}

	public string GetAssetBundle(string path)
	{
		return GetStreamingAsset(path);
	}

	public string GetShortAssetBundle(string absPath)
	{
		int length = "/assetbundles/".Length;
		if (absPath.StartsWith(Application.persistentDataPath))
		{
			return absPath.Substring(Application.persistentDataPath.Length + length);
		}
		if (absPath.StartsWith(Application.streamingAssetsPath))
		{
			return absPath.Substring(Application.streamingAssetsPath.Length + length);
		}
		throw new Exception("wrong path: " + absPath);
	}

	public string GetStreamingAsset(string path)
	{
		string text = Application.persistentDataPath + "/" + path;
		Debug.Log(text);
		if (File.Exists(text))
		{
			Debugger.Log("use cached file: " + text);
			return text;
		}
		Debug.Log("使用打包时候的文件" + Application.streamingAssetsPath + "/" + path);
		return Application.streamingAssetsPath + "/" + path;
	}

	public static string GetPlatformName()
	{
		return Application.platform switch
		{
			RuntimePlatform.Android => "android", 
			RuntimePlatform.IPhonePlayer => "ios", 
			RuntimePlatform.OSXPlayer => "osx", 
			RuntimePlatform.WindowsPlayer => "win", 
			_ => throw new Exception("Do not support this platform."), 
		};
	}
}
