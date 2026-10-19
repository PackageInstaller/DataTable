using System;
using System.Collections.Generic;
using UnityEngine;

namespace YooAsset;

public sealed class SubAssetsHandle : HandleBase
{
	private Action<SubAssetsHandle> _callback;

	public IReadOnlyList<UnityEngine.Object> SubAssetObjects
	{
		get
		{
			if (!IsValidWithWarning)
			{
				return null;
			}
			return Provider.SubAssetObjects;
		}
	}

	public event Action<SubAssetsHandle> Completed
	{
		add
		{
			if (!IsValidWithWarning)
			{
				throw new Exception("SubAssetsHandle is invalid");
			}
			if (Provider.IsDone)
			{
				value(this);
			}
			else
			{
				_callback = (Action<SubAssetsHandle>)Delegate.Combine(_callback, value);
			}
		}
		remove
		{
			if (!IsValidWithWarning)
			{
				throw new Exception("SubAssetsHandle is invalid");
			}
			_callback = (Action<SubAssetsHandle>)Delegate.Remove(_callback, value);
		}
	}

	internal SubAssetsHandle(ProviderOperation provider)
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

	public TObject GetSubAssetObject<TObject>(string assetName) where TObject : UnityEngine.Object
	{
		if (!IsValidWithWarning)
		{
			return null;
		}
		UnityEngine.Object[] subAssetObjects = Provider.SubAssetObjects;
		foreach (UnityEngine.Object obj in subAssetObjects)
		{
			if (obj.name == assetName && obj is TObject)
			{
				return obj as TObject;
			}
		}
		YooLogger.Warning("Not found sub asset object : " + assetName);
		return null;
	}

	public TObject[] GetSubAssetObjects<TObject>() where TObject : UnityEngine.Object
	{
		if (!IsValidWithWarning)
		{
			return null;
		}
		List<TObject> list = new List<TObject>(Provider.SubAssetObjects.Length);
		UnityEngine.Object[] subAssetObjects = Provider.SubAssetObjects;
		for (int i = 0; i < subAssetObjects.Length; i++)
		{
			TObject val = subAssetObjects[i] as TObject;
			if (val != null)
			{
				list.Add(val);
			}
		}
		return list.ToArray();
	}
}
