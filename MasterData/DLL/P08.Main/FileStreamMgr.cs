using System.Collections.Generic;
using System.IO;
using LuaInterface;
using UnityEngine;

public class FileStreamMgr
{
	private static FileStreamMgr _inst;

	public static FileStreamMgr inst
	{
		get
		{
			if (_inst == null)
			{
				_inst = new FileStreamMgr();
			}
			return _inst;
		}
	}

	public void CreateFile(string path)
	{
		string directoryName = Path.GetDirectoryName(path);
		if (!Directory.Exists(directoryName))
		{
			Directory.CreateDirectory(directoryName);
		}
		if (!File.Exists(path))
		{
			File.Create(path).Dispose();
		}
	}

	public void DeleteFile(string path)
	{
		if (File.Exists(path))
		{
			File.Delete(path);
		}
	}

	public void DeleteDirectory(string path)
	{
		if (Directory.Exists(path))
		{
			Directory.Delete(path, recursive: true);
		}
	}

	public void AppendLine(string path, string content, bool isAppend = true)
	{
		if (!File.Exists(path))
		{
			CreateFile(path);
		}
		StreamWriter streamWriter = new StreamWriter(path, isAppend);
		streamWriter.WriteLine(content);
		streamWriter.Close();
		streamWriter.Dispose();
	}

	public void AppendLines(string path, LuaTable table, bool isAppend = true)
	{
		if (!File.Exists(path))
		{
			CreateFile(path);
		}
		StreamWriter streamWriter = new StreamWriter(path, isAppend);
		for (int i = 1; i <= table.Length; i++)
		{
			streamWriter.WriteLine(table[i]);
		}
		streamWriter.Close();
		streamWriter.Dispose();
	}

	public List<string> ReadlAllLine(string path)
	{
		List<string> list = new List<string>();
		if (!File.Exists(path))
		{
			return list;
		}
		try
		{
			StreamReader streamReader = new StreamReader(path);
			string item;
			while ((item = streamReader.ReadLine()) != null)
			{
				list.Add(item);
			}
			streamReader.Close();
			streamReader.Dispose();
		}
		catch (IOException ex)
		{
			Debug.Log(ex.ToString());
		}
		return list;
	}
}
