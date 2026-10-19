using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace YooAsset;

internal sealed class SearchCacheFilesOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		Prepare,
		SearchFiles,
		Done
	}

	private readonly DefaultCacheFileSystem _fileSystem;

	private IEnumerator<DirectoryInfo> _filesEnumerator;

	private float _verifyStartTime;

	private ESteps _steps;

	public readonly List<VerifyFileElement> Result = new List<VerifyFileElement>(5000);

	public readonly HashSet<string> FoundBundleGUIDs = new HashSet<string>();

	internal SearchCacheFilesOperation(DefaultCacheFileSystem fileSystem)
	{
		_fileSystem = fileSystem;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.Prepare;
		_verifyStartTime = Time.realtimeSinceStartup;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.Prepare)
		{
			DirectoryInfo directoryInfo = new DirectoryInfo(_fileSystem.GetCacheBundleFilesRoot());
			if (directoryInfo.Exists)
			{
				IEnumerable<DirectoryInfo> enumerable = directoryInfo.EnumerateDirectories();
				_filesEnumerator = enumerable.GetEnumerator();
			}
			_steps = ESteps.SearchFiles;
		}
		if (_steps == ESteps.SearchFiles && !SearchFiles())
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Succeed;
			_ = Time.realtimeSinceStartup;
			_ = _verifyStartTime;
		}
	}

	private bool SearchFiles()
	{
		if (_filesEnumerator == null)
		{
			return false;
		}
		bool flag;
		do
		{
			flag = _filesEnumerator.MoveNext();
			if (!flag)
			{
				break;
			}
			DirectoryInfo[] directories = _filesEnumerator.Current.GetDirectories();
			foreach (DirectoryInfo directoryInfo in directories)
			{
				string name = directoryInfo.Name;
				FoundBundleGUIDs.Add(name);
				if (_fileSystem.IsRecordBundleFile(name))
				{
					continue;
				}
				string fullName = directoryInfo.FullName;
				string text = fullName + "/__data";
				string infoFilePath = fullName + "/__info";
				if (_fileSystem.AppendFileExtension)
				{
					string text2 = FindDataFileExtension(directoryInfo);
					if (!string.IsNullOrEmpty(text2))
					{
						text += text2;
					}
				}
				VerifyFileElement item = new VerifyFileElement(_fileSystem.PackageName, name, fullName, text, infoFilePath);
				Result.Add(item);
			}
		}
		while (!OperationSystem.IsBusy);
		return flag;
	}

	private string FindDataFileExtension(DirectoryInfo directoryInfo)
	{
		string result = string.Empty;
		FileInfo[] files = directoryInfo.GetFiles();
		foreach (FileInfo fileInfo in files)
		{
			if (fileInfo.Name.StartsWith("__data"))
			{
				result = fileInfo.Extension;
				break;
			}
		}
		return result;
	}
}
