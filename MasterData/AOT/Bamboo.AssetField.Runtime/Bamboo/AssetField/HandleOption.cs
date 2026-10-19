using System;
using Bamboo.Pool;

namespace Bamboo.AssetField;

internal class HandleOption : IRecycle
{
	private LoadState _state;

	private object _result;

	private Action<AssetLoadHandle> _callback;

	private Action<AssetLoadHandle> _releaseCallback;

	private Action _waitForCompletion;

	internal string AssetID { get; set; }

	internal long NumberSign { get; set; }

	internal LoadState State
	{
		get
		{
			return _state;
		}
		set
		{
			AssetLoadHandle obj = new AssetLoadHandle(this);
			if ((value == LoadState.Success || value == LoadState.Failed) && _state == LoadState.Release)
			{
				_state = LoadState.ReleaseOver;
				_releaseCallback?.Invoke(obj);
				return;
			}
			_state = value;
			if (_state == LoadState.Success)
			{
				_callback?.Invoke(obj);
			}
		}
	}

	internal object Result
	{
		get
		{
			return _result;
		}
		set
		{
			_result = value;
		}
	}

	bool IRecycle.IsRecycled { get; set; }

	internal event Action<AssetLoadHandle> Completed
	{
		add
		{
			_callback = (Action<AssetLoadHandle>)Delegate.Combine(_callback, value);
		}
		remove
		{
			_callback = (Action<AssetLoadHandle>)Delegate.Remove(_callback, value);
		}
	}

	internal event Action<AssetLoadHandle> ReleaseCompleted
	{
		add
		{
			_releaseCallback = (Action<AssetLoadHandle>)Delegate.Combine(_releaseCallback, value);
		}
		remove
		{
			_releaseCallback = (Action<AssetLoadHandle>)Delegate.Remove(_releaseCallback, value);
		}
	}

	internal void SetWaitForCompletion(Action handler)
	{
		_waitForCompletion = handler;
	}

	internal void InvokeWaitForCompletion()
	{
		_waitForCompletion?.Invoke();
	}

	internal void ClearWaitForCompletion()
	{
		_waitForCompletion = null;
	}

	void IRecycle.Recycle()
	{
		_state = LoadState.None;
		_result = null;
		_callback = null;
		_releaseCallback = null;
		ClearWaitForCompletion();
		NumberSign = -1L;
	}
}
