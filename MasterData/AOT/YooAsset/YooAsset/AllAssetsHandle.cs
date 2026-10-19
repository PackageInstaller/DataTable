using System;
using System.Collections.Generic;
using UnityEngine;

namespace YooAsset;

public sealed class AllAssetsHandle : HandleBase
{
	private Action<AllAssetsHandle> _callback;

	public IReadOnlyList<UnityEngine.Object> AllAssetObjects
	{
		get
		{
			if (!IsValidWithWarning)
			{
				return null;
			}
			return Provider.AllAssetObjects;
		}
	}

	public event Action<AllAssetsHandle> Completed
	{
		add
		{
			if (!IsValidWithWarning)
			{
				throw new Exception("AllAssetsHandle is invalid");
			}
			if (Provider.IsDone)
			{
				value(this);
			}
			else
			{
				_callback = (Action<AllAssetsHandle>)Delegate.Combine(_callback, value);
			}
		}
		remove
		{
			if (!IsValidWithWarning)
			{
				throw new Exception("AllAssetsHandle is invalid");
			}
			_callback = (Action<AllAssetsHandle>)Delegate.Remove(_callback, value);
		}
	}

	internal AllAssetsHandle(ProviderOperation provider)
		: base(provider)
	{
	}

	internal override void InvokeCallback()
	{
		_callback?.Invoke(this);
	}

	public void WaitForAsyncComplete()
	{
		if (IsValidWithWarning)
		{
			Provider.WaitForAsyncComplete();
		}
	}
}
