using System;
using System.IO;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMIO_Children
{
	public static HUMIO.Data.And And(this HUMIO.Data.Save saveData)
	{
		return default;
	}

	public static string EndSlash(this HUMIO.Data.Remove remove)
	{
		string text = remove.path[remove.path.Length - 1].ToString();
		if (!(text == "/") && !(text == "\\"))
		{
			return remove.path;
		}
		return remove.path.Remove(remove.path.Length - 1, 1);
	}

	public static HUMIO.Data.Persistant Persistant(this HUMIO.Data.Save saveData, string fileName)
	{
		string path = HUMIO.PersistantPath();
		if (!Directory.Exists(path))
		{
			Directory.CreateDirectory(path);
		}
		return new HUMIO.Data.Persistant(path, saveData, default);
	}

	public static HUMIO.Data.Custom Custom(this HUMIO.Data.Save saveData, string filePath, string fileName)
	{
		if (!Directory.Exists(filePath))
		{
			Directory.CreateDirectory(filePath);
		}
		return new HUMIO.Data.Custom(filePath + fileName, saveData, default);
	}

	public static HUMIO.Data.Custom Custom(this HUMIO.Data.Save saveData, string fullPath)
	{
		return new HUMIO.Data.Custom(fullPath, saveData, default);
	}

	public static void Persistant(this HUMIO.Data.Delete deleteData, string fileName)
	{
		string path = HUMIO.PersistantPath(fileName);
		if (System.IO.File.Exists(path))
		{
			System.IO.File.Delete(path);
		}
	}

	public static void Custom(this HUMIO.Data.Delete deleteData, string filePath)
	{
		if (System.IO.File.Exists(filePath))
		{
			System.IO.File.Delete(filePath);
		}
	}

	public static void Persistant(this HUMIO.Data.Copy copyData, string fileName, string newFileName)
	{
		string text = HUMIO.PersistantPath(fileName);
		string destFileName = HUMIO.PersistantPath(newFileName);
		if (System.IO.File.Exists(text))
		{
			System.IO.File.Copy(text, destFileName);
		}
	}

	public static void Custom(this HUMIO.Data.Copy copyData, string filePath, string newFilePath)
	{
		if (System.IO.File.Exists(filePath))
		{
			System.IO.File.Copy(filePath, newFilePath);
		}
	}

	public static void Text(this HUMIO.Data.Persistant persistantData)
	{
		using FileStream stream = new FileStream(persistantData.path, FileMode.Create);
		new StreamWriter(stream).Write(persistantData.save.value.ToString());
	}

	public static void Text(this HUMIO.Data.Custom customData, bool refresh = true)
	{
		using FileStream stream = new FileStream(customData.path, FileMode.Create);
		StreamWriter streamWriter = new StreamWriter(stream);
		streamWriter.Write(customData.save.value.ToString());
		streamWriter.Close();
	}

	public static void Path(this HUMIO.Data.Ensure ensure)
	{
		string path = ((!ensure.path.Contains(".")) ? ensure.path : ensure.path.Remove(ensure.path.LastIndexOf("/") + 1, ensure.path.Length - 1 - ensure.path.LastIndexOf("/")));
		if (!Directory.Exists(path))
		{
			Directory.CreateDirectory(path);
		}
	}

	public static void File(this HUMIO.Data.Ensure ensure, Action create)
	{
		if (!System.IO.File.Exists((!ensure.path.Contains(".")) ? ensure.path : ensure.path.Remove(ensure.path.LastIndexOf("/") + 1, ensure.path.Length - 1 - ensure.path.LastIndexOf("/"))))
		{
			create?.Invoke();
		}
	}

	public static HUMIO.Data.Delete Delete()
	{
		return default;
	}
}
