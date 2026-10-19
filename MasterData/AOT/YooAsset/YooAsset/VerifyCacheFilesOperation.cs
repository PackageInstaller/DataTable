using System;
using System.Collections.Generic;
using System.IO;
using System.Threading;
using UnityEngine;

namespace YooAsset;

internal sealed class VerifyCacheFilesOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		InitVerify,
		UpdateVerify,
		Done
	}

	private readonly DefaultCacheFileSystem _fileSystem;

	private readonly EFileVerifyLevel _fileVerifyLevel;

	private List<VerifyFileElement> _waitingList;

	private List<VerifyFileElement> _verifyingList;

	private int _verifyMaxNum;

	private int _verifyTotalCount;

	private float _verifyStartTime;

	private int _succeedCount;

	private int _failedCount;

	private ESteps _steps;

	internal VerifyCacheFilesOperation(DefaultCacheFileSystem fileSystem, List<VerifyFileElement> elements)
	{
		_fileSystem = fileSystem;
		_waitingList = elements;
		_fileVerifyLevel = fileSystem.FileVerifyLevel;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.InitVerify;
		_verifyStartTime = Time.realtimeSinceStartup;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.InitVerify)
		{
			int count = _waitingList.Count;
			int processorCount = SystemInfo.processorCount;
			ThreadPool.GetMaxThreads(out var workerThreads, out var completionPortThreads);
			_verifyMaxNum = Math.Min(Math.Min(workerThreads, completionPortThreads) / 2, (processorCount - 1) * 4);
			_verifyTotalCount = count;
			if (_verifyMaxNum < 1)
			{
				_verifyMaxNum = 1;
			}
			_verifyingList = new List<VerifyFileElement>(_verifyMaxNum);
			_steps = ESteps.UpdateVerify;
		}
		if (_steps != ESteps.UpdateVerify)
		{
			return;
		}
		for (int num = _verifyingList.Count - 1; num >= 0; num--)
		{
			VerifyFileElement verifyFileElement = _verifyingList[num];
			if (verifyFileElement.Result != 0)
			{
				_verifyingList.RemoveAt(num);
				RecordVerifyFile(verifyFileElement);
			}
		}
		Progress = GetProgress();
		if (_waitingList.Count == 0 && _verifyingList.Count == 0)
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Succeed;
			_ = Time.realtimeSinceStartup;
			_ = _verifyStartTime;
		}
		int num2 = _waitingList.Count - 1;
		while (num2 >= 0 && !OperationSystem.IsBusy && _verifyingList.Count < _verifyMaxNum)
		{
			VerifyFileElement verifyFileElement2 = _waitingList[num2];
			if (ThreadPool.QueueUserWorkItem(VerifyInThread, verifyFileElement2))
			{
				_waitingList.RemoveAt(num2);
				_verifyingList.Add(verifyFileElement2);
				num2--;
				continue;
			}
			YooLogger.Warning("The thread pool is failed queued.");
			break;
		}
	}

	private float GetProgress()
	{
		if (_verifyTotalCount == 0)
		{
			return 1f;
		}
		return (float)(_succeedCount + _failedCount) / (float)_verifyTotalCount;
	}

	private void VerifyInThread(object obj)
	{
		VerifyFileElement verifyFileElement = (VerifyFileElement)obj;
		int result = (int)VerifyingCacheFile(verifyFileElement, _fileVerifyLevel);
		verifyFileElement.Result = result;
	}

	private void RecordVerifyFile(VerifyFileElement element)
	{
		if (element.Result == 1)
		{
			_succeedCount++;
			RecordFileElement element2 = new RecordFileElement(element.InfoFilePath, element.DataFilePath, element.DataFileCRC, element.DataFileSize);
			_fileSystem.RecordBundleFile(element.BundleGUID, element2);
		}
		else
		{
			_failedCount++;
			YooLogger.Warning($"Failed to verify file {element.Result} and delete files : {element.FileRootPath}");
			element.DeleteFiles();
		}
	}

	private EFileVerifyResult VerifyingCacheFile(VerifyFileElement element, EFileVerifyLevel verifyLevel)
	{
		try
		{
			if (verifyLevel == EFileVerifyLevel.Low)
			{
				if (!File.Exists(element.InfoFilePath))
				{
					return EFileVerifyResult.InfoFileNotExisted;
				}
				if (!File.Exists(element.DataFilePath))
				{
					return EFileVerifyResult.DataFileNotExisted;
				}
				return EFileVerifyResult.Succeed;
			}
			if (!File.Exists(element.InfoFilePath))
			{
				return EFileVerifyResult.InfoFileNotExisted;
			}
			_fileSystem.ReadBundleInfoFile(element.InfoFilePath, out element.DataFileCRC, out element.DataFileSize);
		}
		catch (Exception)
		{
			return EFileVerifyResult.Exception;
		}
		return FileVerifyHelper.FileVerify(element.DataFilePath, element.DataFileSize, element.DataFileCRC, verifyLevel);
	}
}
