using System.IO;

public class FileManager
{
	private static FileManager _inst;

	public static FileManager inst
	{
		get
		{
			if (_inst == null)
			{
				_inst = new FileManager();
			}
			return _inst;
		}
	}

	public void Init()
	{
	}

	public string[] ReadAllLines(string fullPath)
	{
		return File.ReadAllLines(fullPath);
	}

	public byte[] ReadAllBytes(string path)
	{
		return File.ReadAllBytes(path);
	}

	public bool FileExists(string path)
	{
		return File.Exists(path);
	}
}
