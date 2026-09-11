using System.IO;
using LuaInterface;
using UnityEngine;

public class LuaResLoader : LuaFileUtils
{
	public LuaResLoader()
	{
		LuaFileUtils.instance = this;
		beZip = false;
	}

	public override byte[] ReadFile(string fileName)
	{
		byte[] array = ReadDownLoadFile(fileName);
		if (array == null)
		{
			array = ReadResourceFile(fileName);
		}
		if (array == null)
		{
			array = base.ReadFile(fileName);
		}
		return array;
	}

	public override string FindFileError(string fileName)
	{
		if (Path.IsPathRooted(fileName))
		{
			return fileName;
		}
		if (Path.GetExtension(fileName) == ".lua")
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
			cString.Append("\n\tno file './Resources/").Append(fileName).Append(".lua'")
				.Append("\n\tno file '")
				.Append(LuaConst.luaResDir)
				.Append('/')
				.Append(fileName)
				.Append(".lua'");
			cString = cString.Replace("?", fileName);
			return cString.ToString();
		}
	}

	private byte[] ReadResourceFile(string fileName)
	{
		if (!fileName.EndsWith(".lua"))
		{
			fileName += ".lua";
		}
		byte[] result = null;
		TextAsset textAsset = Resources.Load("Lua/" + fileName, typeof(TextAsset)) as TextAsset;
		if (textAsset != null)
		{
			result = textAsset.bytes;
			Resources.UnloadAsset(textAsset);
		}
		return result;
	}

	private byte[] ReadDownLoadFile(string fileName)
	{
		if (!fileName.EndsWith(".lua"))
		{
			fileName += ".lua";
		}
		string path = fileName;
		if (!Path.IsPathRooted(fileName))
		{
			path = $"{LuaConst.luaResDir}/{fileName}";
		}
		if (File.Exists(path))
		{
			return File.ReadAllBytes(path);
		}
		return null;
	}
}
