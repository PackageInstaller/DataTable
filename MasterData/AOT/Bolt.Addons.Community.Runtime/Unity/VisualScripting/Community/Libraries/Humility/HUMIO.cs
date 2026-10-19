using System.IO;
using System.Runtime.InteropServices;
using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMIO
{
	public static class Data
	{
		public struct Save(object value)
		{
			public object value = value;
		}

		[StructLayout(LayoutKind.Sequential, Size = 1)]
		public struct Load
		{
		}

		[StructLayout(LayoutKind.Sequential, Size = 1)]
		public struct Delete
		{
		}

		[StructLayout(LayoutKind.Sequential, Size = 1)]
		public struct Copy
		{
		}

		[StructLayout(LayoutKind.Sequential, Size = 1)]
		public struct Asset
		{
		}

		public struct Remove(string path)
		{
			public string path = path;
		}

		public struct Persistant(string path, Save saveData, Load loadData)
		{
			public string path = path;

			public Save save = saveData;

			public Load load = loadData;
		}

		public struct Custom(string path, Save saveData, Load loadData)
		{
			public string path = path;

			public Save save = saveData;

			public Load load = loadData;
		}

		[StructLayout(LayoutKind.Sequential, Size = 1)]
		public struct And
		{
		}

		public struct Ensure(string path)
		{
			public string path = path;
		}

		[StructLayout(LayoutKind.Sequential, Size = 1)]
		public struct Legal
		{
		}
	}

	internal static string PersistantPath(string fileName)
	{
		return Application.persistentDataPath + "/data/" + fileName;
	}

	public static string PersistantPath()
	{
		return Application.persistentDataPath + "/data/";
	}

	public static Data.Save Save(this object value)
	{
		return new Data.Save(value);
	}

	public static Data.Load Load()
	{
		return default;
	}

	public static Data.Remove Remove(this string path)
	{
		return new Data.Remove(path);
	}

	public static Data.Delete Delete()
	{
		return default;
	}

	public static void Delete(string path)
	{
		if (Directory.Exists(path))
		{
			Directory.Delete(path, recursive: true);
		}
	}

	public static Data.Copy Copy()
	{
		return default;
	}

	public static Data.Ensure Ensure(this string path)
	{
		return new Data.Ensure(path);
	}
}
