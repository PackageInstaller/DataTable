using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace UnityEngine.ResourceManagement.AsyncOperations;

public struct AsyncOperationHandle<TObject> : IEnumerator, IEquatable<AsyncOperationHandle<TObject>>
{
	internal AsyncOperationBase<TObject> m_InternalOp;

	private int m_Version;

	private string m_LocationName;

	internal int Version => m_Version;

	internal string LocationName
	{
		get
		{
			return m_LocationName;
		}
		set
		{
			m_LocationName = value;
		}
	}

	public string DebugName
	{
		get
		{
			if (!IsValid())
			{
				return "InvalidHandle";
			}
			return ((IAsyncOperation)InternalOp).DebugName;
		}
	}

	internal AsyncOperationBase<TObject> InternalOp
	{
		get
		{
			if (m_InternalOp == null || m_InternalOp.Version != m_Version)
			{
				throw new Exception("Attempting to use an invalid operation handle");
			}
			return m_InternalOp;
		}
	}

	public bool IsDone
	{
		get
		{
			if (IsValid())
			{
				return InternalOp.IsDone;
			}
			return true;
		}
	}

	public Exception OperationException => InternalOp.OperationException;

	public float PercentComplete => InternalOp.PercentComplete;

	internal int ReferenceCount => InternalOp.ReferenceCount;

	public TObject Result => InternalOp.Result;

	public AsyncOperationStatus Status => InternalOp.Status;

	public Task<TObject> Task => InternalOp.Task;

	object IEnumerator.Current => Result;

	public event Action<AsyncOperationHandle<TObject>> Completed
	{
		add
		{
			InternalOp.Completed += value;
		}
		remove
		{
			InternalOp.Completed -= value;
		}
	}

	public event Action<AsyncOperationHandle> CompletedTypeless
	{
		add
		{
			InternalOp.CompletedTypeless += value;
		}
		remove
		{
			InternalOp.CompletedTypeless -= value;
		}
	}

	public event Action<AsyncOperationHandle> Destroyed
	{
		add
		{
			InternalOp.Destroyed += value;
		}
		remove
		{
			InternalOp.Destroyed -= value;
		}
	}

	public static implicit operator AsyncOperationHandle(AsyncOperationHandle<TObject> obj)
	{
		return new AsyncOperationHandle(obj.m_InternalOp, obj.m_Version, obj.m_LocationName);
	}

	internal AsyncOperationHandle(AsyncOperationBase<TObject> op)
	{
		m_InternalOp = op;
		m_Version = op?.Version ?? 0;
		m_LocationName = null;
	}

	public DownloadStatus GetDownloadStatus()
	{
		return InternalGetDownloadStatus(new HashSet<object>());
	}

	internal DownloadStatus InternalGetDownloadStatus(HashSet<object> visited)
	{
		if (visited == null)
		{
			visited = new HashSet<object>();
		}
		if (!visited.Add(InternalOp))
		{
			return new DownloadStatus
			{
				IsDone = IsDone
			};
		}
		return InternalOp.GetDownloadStatus(visited);
	}

	internal AsyncOperationHandle(IAsyncOperation op)
	{
		m_InternalOp = (AsyncOperationBase<TObject>)op;
		m_Version = op?.Version ?? 0;
		m_LocationName = null;
	}

	internal AsyncOperationHandle(IAsyncOperation op, int version)
	{
		m_InternalOp = (AsyncOperationBase<TObject>)op;
		m_Version = version;
		m_LocationName = null;
	}

	internal AsyncOperationHandle(IAsyncOperation op, string locationName)
	{
		m_InternalOp = (AsyncOperationBase<TObject>)op;
		m_Version = op?.Version ?? 0;
		m_LocationName = locationName;
	}

	internal AsyncOperationHandle(IAsyncOperation op, int version, string locationName)
	{
		m_InternalOp = (AsyncOperationBase<TObject>)op;
		m_Version = version;
		m_LocationName = locationName;
	}

	internal AsyncOperationHandle<TObject> Acquire()
	{
		InternalOp.IncrementReferenceCount();
		return this;
	}

	public void ReleaseHandleOnCompletion()
	{
		Completed += (AsyncOperationHandle<TObject> op) =>
		{
			op.Release();
		};
	}

	public void GetDependencies(List<AsyncOperationHandle> deps)
	{
		InternalOp.GetDependencies(deps);
	}

	public bool Equals(AsyncOperationHandle<TObject> other)
	{
		if (m_Version == other.m_Version)
		{
			return m_InternalOp == other.m_InternalOp;
		}
		return false;
	}

	public override int GetHashCode()
	{
		if (m_InternalOp != null)
		{
			return m_InternalOp.GetHashCode() * 17 + m_Version;
		}
		return 0;
	}

	public TObject WaitForCompletion()
	{
		if (IsValid() && !InternalOp.IsDone)
		{
			InternalOp.WaitForCompletion();
		}
		m_InternalOp?.m_RM?.Update(Time.unscaledDeltaTime);
		if (IsValid())
		{
			return Result;
		}
		return default;
	}

	public bool IsValid()
	{
		if (m_InternalOp != null)
		{
			return m_InternalOp.Version == m_Version;
		}
		return false;
	}

	public void Release()
	{
		InternalOp.DecrementReferenceCount();
		m_InternalOp = null;
	}

	bool IEnumerator.MoveNext()
	{
		return !IsDone;
	}

	void IEnumerator.Reset()
	{
	}
}
public struct AsyncOperationHandle : IEnumerator
{
	internal IAsyncOperation m_InternalOp;

	private int m_Version;

	private string m_LocationName;

	internal int Version => m_Version;

	internal string LocationName
	{
		get
		{
			return m_LocationName;
		}
		set
		{
			m_LocationName = value;
		}
	}

	public string DebugName
	{
		get
		{
			if (!IsValid())
			{
				return "InvalidHandle";
			}
			return InternalOp.DebugName;
		}
	}

	private IAsyncOperation InternalOp
	{
		get
		{
			if (m_InternalOp == null || m_InternalOp.Version != m_Version)
			{
				throw new Exception("Attempting to use an invalid operation handle");
			}
			return m_InternalOp;
		}
	}

	public bool IsDone
	{
		get
		{
			if (IsValid())
			{
				return InternalOp.IsDone;
			}
			return true;
		}
	}

	public Exception OperationException => InternalOp.OperationException;

	public float PercentComplete => InternalOp.PercentComplete;

	internal int ReferenceCount => InternalOp.ReferenceCount;

	public object Result => InternalOp.GetResultAsObject();

	public AsyncOperationStatus Status => InternalOp.Status;

	public Task<object> Task => InternalOp.Task;

	object IEnumerator.Current => Result;

	public event Action<AsyncOperationHandle> Completed
	{
		add
		{
			InternalOp.CompletedTypeless += value;
		}
		remove
		{
			InternalOp.CompletedTypeless -= value;
		}
	}

	public event Action<AsyncOperationHandle> Destroyed
	{
		add
		{
			InternalOp.Destroyed += value;
		}
		remove
		{
			InternalOp.Destroyed -= value;
		}
	}

	internal AsyncOperationHandle(IAsyncOperation op)
	{
		m_InternalOp = op;
		m_Version = op?.Version ?? 0;
		m_LocationName = null;
	}

	internal AsyncOperationHandle(IAsyncOperation op, int version)
	{
		m_InternalOp = op;
		m_Version = version;
		m_LocationName = null;
	}

	internal AsyncOperationHandle(IAsyncOperation op, string locationName)
	{
		m_InternalOp = op;
		m_Version = op?.Version ?? 0;
		m_LocationName = locationName;
	}

	internal AsyncOperationHandle(IAsyncOperation op, int version, string locationName)
	{
		m_InternalOp = op;
		m_Version = version;
		m_LocationName = locationName;
	}

	internal AsyncOperationHandle Acquire()
	{
		InternalOp.IncrementReferenceCount();
		return this;
	}

	public void ReleaseHandleOnCompletion()
	{
		Completed += (AsyncOperationHandle op) =>
		{
			op.Release();
		};
	}

	public AsyncOperationHandle<T> Convert<T>()
	{
		return new AsyncOperationHandle<T>(InternalOp, m_Version, m_LocationName);
	}

	public bool Equals(AsyncOperationHandle other)
	{
		if (m_Version == other.m_Version)
		{
			return m_InternalOp == other.m_InternalOp;
		}
		return false;
	}

	public void GetDependencies(List<AsyncOperationHandle> deps)
	{
		InternalOp.GetDependencies(deps);
	}

	public override int GetHashCode()
	{
		if (m_InternalOp != null)
		{
			return m_InternalOp.GetHashCode() * 17 + m_Version;
		}
		return 0;
	}

	public bool IsValid()
	{
		if (m_InternalOp != null)
		{
			return m_InternalOp.Version == m_Version;
		}
		return false;
	}

	public DownloadStatus GetDownloadStatus()
	{
		return InternalGetDownloadStatus(new HashSet<object>());
	}

	internal DownloadStatus InternalGetDownloadStatus(HashSet<object> visited)
	{
		if (visited == null)
		{
			visited = new HashSet<object>();
		}
		if (!visited.Add(InternalOp))
		{
			return new DownloadStatus
			{
				IsDone = IsDone
			};
		}
		return InternalOp.GetDownloadStatus(visited);
	}

	public void Release()
	{
		InternalOp.DecrementReferenceCount();
		m_InternalOp = null;
	}

	bool IEnumerator.MoveNext()
	{
		return !IsDone;
	}

	void IEnumerator.Reset()
	{
	}

	public object WaitForCompletion()
	{
		if (IsValid() && !InternalOp.IsDone)
		{
			InternalOp.WaitForCompletion();
		}
		if (IsValid())
		{
			return Result;
		}
		return null;
	}
}
