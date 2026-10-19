using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading.Tasks;
using UnityEngine;

namespace YooAsset;

public abstract class AsyncOperationBase : IEnumerator, IComparable<AsyncOperationBase>
{
	private Action<AsyncOperationBase> _callback;

	private string _packageName;

	private int _whileFrame = 1000;

	internal readonly List<AsyncOperationBase> Childs = new List<AsyncOperationBase>(10);

	public string BeginTime = string.Empty;

	private Stopwatch _watch;

	private TaskCompletionSource<object> _taskCompletionSource;

	internal bool IsWaitForAsyncComplete { get; private set; }

	internal bool IsFinish { get; private set; }

	public uint Priority { get; set; }

	public EOperationStatus Status { get; protected set; }

	public string Error { get; protected set; }

	public float Progress { get; protected set; }

	public string PackageName => _packageName;

	public bool IsDone
	{
		get
		{
			if (Status != EOperationStatus.Failed)
			{
				return Status == EOperationStatus.Succeed;
			}
			return true;
		}
	}

	public Task Task
	{
		get
		{
			if (_taskCompletionSource == null)
			{
				_taskCompletionSource = new TaskCompletionSource<object>();
				if (IsDone)
				{
					_taskCompletionSource.SetResult(null);
				}
			}
			return _taskCompletionSource.Task;
		}
	}

	public long ProcessTime { get; protected set; }

	object IEnumerator.Current => null;

	public event Action<AsyncOperationBase> Completed
	{
		add
		{
			if (IsDone)
			{
				value(this);
			}
			else
			{
				_callback = (Action<AsyncOperationBase>)Delegate.Combine(_callback, value);
			}
		}
		remove
		{
			_callback = (Action<AsyncOperationBase>)Delegate.Remove(_callback, value);
		}
	}

	internal abstract void InternalStart();

	internal abstract void InternalUpdate();

	internal virtual void InternalAbort()
	{
	}

	internal virtual void InternalWaitForAsyncComplete()
	{
		throw new NotImplementedException(GetType().Name);
	}

	internal virtual string InternalGetDesc()
	{
		return string.Empty;
	}

	internal void SetPackageName(string packageName)
	{
		_packageName = packageName;
	}

	internal void AddChildOperation(AsyncOperationBase child)
	{
		Childs.Add(child);
	}

	internal string GetOperationDesc()
	{
		return InternalGetDesc();
	}

	internal void StartOperation()
	{
		if (Status == EOperationStatus.None)
		{
			Status = EOperationStatus.Processing;
			InternalStart();
		}
	}

	internal void UpdateOperation()
	{
		if (!IsDone)
		{
			InternalUpdate();
		}
		if (IsDone && !IsFinish)
		{
			IsFinish = true;
			Progress = 1f;
			_callback?.Invoke(this);
			if (_taskCompletionSource != null)
			{
				_taskCompletionSource.TrySetResult(null);
			}
		}
	}

	internal void AbortOperation()
	{
		foreach (AsyncOperationBase child in Childs)
		{
			child.AbortOperation();
		}
		if (!IsDone)
		{
			Status = EOperationStatus.Failed;
			Error = "user abort";
			YooLogger.Warning("Async operaiton " + GetType().Name + " has been abort !");
			InternalAbort();
		}
	}

	protected bool ExecuteWhileDone()
	{
		if (!IsDone)
		{
			InternalUpdate();
			_whileFrame--;
			if (_whileFrame <= 0)
			{
				Status = EOperationStatus.Failed;
				Error = "Operation " + GetType().Name + " failed to wait for async complete !";
				YooLogger.Error(Error);
			}
		}
		return IsDone;
	}

	protected void ClearCompletedCallback()
	{
		_callback = null;
	}

	public void WaitForAsyncComplete()
	{
		if (!IsDone)
		{
			if (Status == EOperationStatus.None)
			{
				StartOperation();
			}
			IsWaitForAsyncComplete = true;
			InternalWaitForAsyncComplete();
		}
	}

	[Conditional("DEBUG")]
	private void DebugBeginRecording()
	{
		if (_watch == null)
		{
			BeginTime = SpawnTimeToString(Time.realtimeSinceStartup);
			_watch = Stopwatch.StartNew();
		}
	}

	[Conditional("DEBUG")]
	private void DebugUpdateRecording()
	{
		if (_watch != null)
		{
			ProcessTime = _watch.ElapsedMilliseconds;
		}
	}

	[Conditional("DEBUG")]
	private void DebugEndRecording()
	{
		if (_watch != null)
		{
			ProcessTime = _watch.ElapsedMilliseconds;
			_watch = null;
		}
	}

	private string SpawnTimeToString(float spawnTime)
	{
		float num = Mathf.FloorToInt(spawnTime / 3600f);
		float num2 = Mathf.FloorToInt(spawnTime / 60f - num * 60f);
		float num3 = Mathf.FloorToInt(spawnTime - num2 * 60f - num * 3600f);
		return num.ToString("00") + ":" + num2.ToString("00") + ":" + num3.ToString("00");
	}

	public int CompareTo(AsyncOperationBase other)
	{
		return other.Priority.CompareTo(Priority);
	}

	bool IEnumerator.MoveNext()
	{
		return !IsDone;
	}

	void IEnumerator.Reset()
	{
	}
}
