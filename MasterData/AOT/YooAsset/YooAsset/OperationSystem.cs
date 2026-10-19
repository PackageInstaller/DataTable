using System.Collections.Generic;
using System.Diagnostics;

namespace YooAsset;

internal class OperationSystem
{
	private static readonly List<AsyncOperationBase> _operations = new List<AsyncOperationBase>(1000);

	private static readonly List<AsyncOperationBase> _newList = new List<AsyncOperationBase>(1000);

	private static Stopwatch _watch;

	private static long _frameTime;

	public static long MaxTimeSlice { get; set; } = long.MaxValue;

	public static bool IsBusy => _watch.ElapsedMilliseconds - _frameTime >= MaxTimeSlice;

	public static void Initialize()
	{
		_watch = Stopwatch.StartNew();
	}

	public static void Update()
	{
		for (int num = _operations.Count - 1; num >= 0; num--)
		{
			if (_operations[num].IsFinish)
			{
				_operations.RemoveAt(num);
			}
		}
		if (_newList.Count > 0)
		{
			bool flag = false;
			foreach (AsyncOperationBase @new in _newList)
			{
				if (@new.Priority != 0)
				{
					flag = true;
					break;
				}
			}
			_operations.AddRange(_newList);
			_newList.Clear();
			if (flag)
			{
				_operations.Sort();
			}
		}
		_frameTime = _watch.ElapsedMilliseconds;
		for (int i = 0; i < _operations.Count; i++)
		{
			if (IsBusy)
			{
				break;
			}
			AsyncOperationBase asyncOperationBase = _operations[i];
			if (!asyncOperationBase.IsFinish)
			{
				asyncOperationBase.UpdateOperation();
			}
		}
	}

	public static void DestroyAll()
	{
		_operations.Clear();
		_newList.Clear();
		_watch = null;
		_frameTime = 0L;
		MaxTimeSlice = long.MaxValue;
	}

	public static void ClearPackageOperation(string packageName)
	{
		foreach (AsyncOperationBase @new in _newList)
		{
			if (@new.PackageName == packageName)
			{
				@new.AbortOperation();
			}
		}
		foreach (AsyncOperationBase operation in _operations)
		{
			if (operation.PackageName == packageName)
			{
				operation.AbortOperation();
			}
		}
	}

	public static void StartOperation(string packageName, AsyncOperationBase operation)
	{
		_newList.Add(operation);
		operation.SetPackageName(packageName);
		operation.StartOperation();
	}

	internal static List<DebugOperationInfo> GetDebugOperationInfos(string packageName)
	{
		List<DebugOperationInfo> list = new List<DebugOperationInfo>(_operations.Count);
		foreach (AsyncOperationBase operation in _operations)
		{
			if (operation.PackageName == packageName)
			{
				DebugOperationInfo debugOperationInfo = GetDebugOperationInfo(operation);
				list.Add(debugOperationInfo);
			}
		}
		return list;
	}

	internal static DebugOperationInfo GetDebugOperationInfo(AsyncOperationBase operation)
	{
		DebugOperationInfo result = new DebugOperationInfo
		{
			OperationName = operation.GetType().Name,
			OperationDesc = operation.GetOperationDesc(),
			Priority = operation.Priority,
			Progress = operation.Progress,
			BeginTime = operation.BeginTime,
			ProcessTime = operation.ProcessTime,
			Status = operation.Status.ToString(),
			Childs = new List<DebugOperationInfo>(operation.Childs.Count)
		};
		foreach (AsyncOperationBase child in operation.Childs)
		{
			DebugOperationInfo debugOperationInfo = GetDebugOperationInfo(child);
			result.Childs.Add(debugOperationInfo);
		}
		return result;
	}
}
