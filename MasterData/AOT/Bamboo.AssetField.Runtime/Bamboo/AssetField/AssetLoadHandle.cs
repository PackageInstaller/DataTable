using System;
using System.Collections;
using UnityEngine;

namespace Bamboo.AssetField;

public struct AssetLoadHandle : IEnumerator
{
	private long m_number { get; }

	internal HandleOption HandleOption { get; }

	internal bool CanUse
	{
		get
		{
			if (HandleOption != null)
			{
				return m_number == HandleOption.NumberSign;
			}
			return false;
		}
	}

	public string AssetID => HandleOption.AssetID;

	public LoadState State
	{
		get
		{
			if (!CanUse)
			{
				return LoadState.None;
			}
			return HandleOption.State;
		}
		internal set
		{
			HandleOption.State = value;
		}
	}

	public object Result
	{
		get
		{
			if (!CanUse)
			{
				return null;
			}
			return HandleOption.Result;
		}
		internal set
		{
			HandleOption.Result = value;
		}
	}

	public bool IsValid
	{
		get
		{
			if (CanUse)
			{
				if (HandleOption.State != LoadState.Loading)
				{
					return HandleOption.State == LoadState.Success;
				}
				return true;
			}
			return false;
		}
	}

	public bool IsDone
	{
		get
		{
			if (HandleOption != null)
			{
				if (HandleOption.State != LoadState.ReleaseOver && HandleOption.State != LoadState.Success)
				{
					return HandleOption.State == LoadState.Failed;
				}
				return true;
			}
			return false;
		}
	}

	object IEnumerator.Current => Result;

	public event Action<AssetLoadHandle> Completed
	{
		add
		{
			if (CanUse)
			{
				switch (HandleOption.State)
				{
				case LoadState.Success:
				{
					AssetLoadHandle obj = this;
					value(obj);
					return;
				}
				case LoadState.Loading:
					HandleOption.Completed += value;
					return;
				}
			}
			Debug.LogError("Handle未加载或者不可用");
		}
		remove
		{
			HandleOption.Completed -= value;
		}
	}

	internal event Action<AssetLoadHandle> ReleaseCompleted
	{
		add
		{
			if (CanUse)
			{
				HandleOption.ReleaseCompleted += value;
			}
			else
			{
				Debug.LogError("Handle此时不可添加释放事件");
			}
		}
		remove
		{
			HandleOption.ReleaseCompleted -= value;
		}
	}

	internal AssetLoadHandle(HandleOption option)
	{
		HandleOption = option;
		m_number = HandleOption.NumberSign;
	}

	internal AssetLoadHandle(HandleOption option, int sign)
	{
		HandleOption = option;
		m_number = sign;
	}

	public T As<T>() where T : UnityEngine.Object
	{
		if (!(Result is T result))
		{
			return null;
		}
		return result;
	}

	public GameObject AsGameObject()
	{
		if (!(Result is GameObject result))
		{
			return null;
		}
		return result;
	}

	public bool WaitForCompletion(int timeoutMilliseconds = -1)
	{
		if (!CanUse)
		{
			Debug.LogError("Handle不可用，无法等待完成");
			return false;
		}
		if (IsDone)
		{
			return State == LoadState.Success;
		}
		HandleOption.InvokeWaitForCompletion();
		return State == LoadState.Success;
	}

	bool IEnumerator.MoveNext()
	{
		return !IsDone;
	}

	void IEnumerator.Reset()
	{
	}

	public static bool operator ==(AssetLoadHandle left, AssetLoadHandle right)
	{
		return left.m_number == right.m_number;
	}

	public static bool operator !=(AssetLoadHandle left, AssetLoadHandle right)
	{
		return left.m_number != right.m_number;
	}

	public override bool Equals(object obj)
	{
		if (obj is AssetLoadHandle other)
		{
			return Equals(other);
		}
		return false;
	}

	public bool Equals(AssetLoadHandle other)
	{
		return m_number == other.m_number;
	}

	public override int GetHashCode()
	{
		return m_number.GetHashCode();
	}
}
