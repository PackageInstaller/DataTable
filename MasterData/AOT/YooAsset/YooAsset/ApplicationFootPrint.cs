using System.IO;
using UnityEngine;

namespace YooAsset;

internal class ApplicationFootPrint
{
	private readonly DefaultCacheFileSystem _fileSystem;

	private string _footPrint;

	public ApplicationFootPrint(DefaultCacheFileSystem fileSystem)
	{
		_fileSystem = fileSystem;
	}

	public void Load(string packageName)
	{
		string sandboxAppFootPrintFilePath = _fileSystem.GetSandboxAppFootPrintFilePath();
		if (File.Exists(sandboxAppFootPrintFilePath))
		{
			_footPrint = FileUtility.ReadAllText(sandboxAppFootPrintFilePath);
		}
		else
		{
			Coverage(packageName);
		}
	}

	public bool IsDirty()
	{
		return _footPrint != Application.buildGUID;
	}

	public void Coverage(string packageName)
	{
		_footPrint = Application.buildGUID;
		FileUtility.WriteAllText(_fileSystem.GetSandboxAppFootPrintFilePath(), _footPrint);
	}
}
