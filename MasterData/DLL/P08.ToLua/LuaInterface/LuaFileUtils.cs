using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace LuaInterface;

public class LuaFileUtils
{
	public delegate byte[] BundleLoader(string filename);

	public bool beZip;

	protected List<string> searchPaths = new List<string>();

	protected Dictionary<string, AssetBundle> zipMap = new Dictionary<string, AssetBundle>();

	public BundleLoader bundleLoader;

	public bool useBundle;

	protected static LuaFileUtils instance;

	public static LuaFileUtils Instance
	{
		get
		{
			if (instance == null)
			{
				instance = new LuaFileUtils();
			}
			return instance;
		}
		protected set
		{
			instance = value;
		}
	}

	public LuaFileUtils()
	{
		instance = this;
	}

	public virtual void Dispose()
	{
		if (instance == null)
		{
			return;
		}
		instance = null;
		searchPaths.Clear();
		foreach (KeyValuePair<string, AssetBundle> item in zipMap)
		{
			item.Value.Unload(unloadAllLoadedObjects: true);
		}
		zipMap.Clear();
	}

	public bool AddSearchPath(string path, bool front = false)
	{
		if (searchPaths.IndexOf(path) >= 0)
		{
			return false;
		}
		if (front)
		{
			searchPaths.Insert(0, path);
		}
		else
		{
			searchPaths.Add(path);
		}
		return true;
	}

	public bool RemoveSearchPath(string path)
	{
		int num = searchPaths.IndexOf(path);
		if (num >= 0)
		{
			searchPaths.RemoveAt(num);
			return true;
		}
		return false;
	}

	public void AddSearchBundle(string name, AssetBundle bundle)
	{
		zipMap[name] = bundle;
	}

	public string FindFile(string fileName)
	{
		if (fileName == string.Empty)
		{
			return string.Empty;
		}
		if (Path.IsPathRooted(fileName))
		{
			if (!fileName.EndsWith(".lua"))
			{
				fileName += ".lua";
			}
			return fileName;
		}
		if (fileName.EndsWith(".lua"))
		{
			fileName = fileName.Substring(0, fileName.Length - 4);
		}
		string text = null;
		for (int i = 0; i < searchPaths.Count; i++)
		{
			text = searchPaths[i].Replace("?", fileName);
			if (File.Exists(text))
			{
				return text;
			}
		}
		return null;
	}

	public virtual byte[] ReadFile(string fileName)
	{
		if (useBundle)
		{
			return bundleLoader(fileName);
		}
		if (!beZip)
		{
			string text = FindFile(fileName);
			byte[] result = null;
			if (!string.IsNullOrEmpty(text) && File.Exists(text))
			{
				result = File.ReadAllBytes(text);
			}
			return result;
		}
		return ReadZipFile(fileName);
	}

	public virtual string FindFileError(string fileName)
	{
		if (Path.IsPathRooted(fileName))
		{
			return fileName;
		}
		if (fileName.EndsWith(".lua"))
		{
			fileName = fileName.Substring(0, fileName.Length - 4);
		}
		using (CString.Block())
		{
			CString cString = CString.Alloc(512);
			for (int i = 0; i < searchPaths.Count; i++)
			{
				cString.Append("\n\tno file '").Append(searchPaths[i]).Append('\'');
			}
			cString = cString.Replace("?", fileName);
			if (beZip)
			{
				int num = fileName.LastIndexOf('/');
				if (num > 0)
				{
					int num2 = num + 1;
					cString.Append("\n\tno file '").Append(fileName, num2, fileName.Length - num2).Append(".lua' in ")
						.Append("lua_");
					num2 = cString.Length;
					cString.Append(fileName, 0, num).Replace('/', '_', num2, num).Append(".unity3d");
				}
				else
				{
					cString.Append("\n\tno file '").Append(fileName).Append(".lua' in ")
						.Append("lua.unity3d");
				}
			}
			return cString.ToString();
		}
	}

	private byte[] ReadZipFile(string fileName)
	{
		AssetBundle value = null;
		byte[] result = null;
		string text = null;
		using (CString.Block())
		{
			CString cString = CString.Alloc(256);
			cString.Append("lua");
			int num = fileName.LastIndexOf('/');
			if (num > 0)
			{
				cString.Append("_");
				cString.Append(fileName, 0, num).ToLower().Replace('/', '_');
				fileName = fileName.Substring(num + 1);
			}
			if (!fileName.EndsWith(".lua"))
			{
				fileName += ".lua";
			}
			fileName += ".bytes";
			text = cString.ToString();
			zipMap.TryGetValue(text, out value);
		}
		if (value != null)
		{
			TextAsset textAsset = value.LoadAsset<TextAsset>(fileName);
			if (textAsset != null)
			{
				result = textAsset.bytes;
				Resources.UnloadAsset(textAsset);
			}
		}
		return result;
	}

	public static string GetOSDir()
	{
		return LuaConst.osDir;
	}
}
