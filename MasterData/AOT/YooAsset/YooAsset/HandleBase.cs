using System;
using System.Collections;
using System.Threading.Tasks;

namespace YooAsset;

public abstract class HandleBase : IEnumerator, IDisposable
{
	private readonly AssetInfo _assetInfo;

	internal ProviderOperation Provider { get; private set; }

	public EOperationStatus Status
	{
		get
		{
			if (!IsValidWithWarning)
			{
				return EOperationStatus.None;
			}
			return Provider.Status;
		}
	}

	public string LastError
	{
		get
		{
			if (!IsValidWithWarning)
			{
				return string.Empty;
			}
			return Provider.Error;
		}
	}

	public float Progress
	{
		get
		{
			if (!IsValidWithWarning)
			{
				return 0f;
			}
			return Provider.Progress;
		}
	}

	public bool IsDone
	{
		get
		{
			if (!IsValidWithWarning)
			{
				return true;
			}
			return Provider.IsDone;
		}
	}

	public bool IsValid
	{
		get
		{
			if (Provider != null && !Provider.IsDestroyed)
			{
				return true;
			}
			return false;
		}
	}

	internal bool IsValidWithWarning
	{
		get
		{
			if (Provider != null && !Provider.IsDestroyed)
			{
				return true;
			}
			if (Provider == null)
			{
				YooLogger.Warning("Operation handle is released : " + _assetInfo.AssetPath);
			}
			else if (Provider.IsDestroyed)
			{
				YooLogger.Warning("Provider is destroyed : " + _assetInfo.AssetPath);
			}
			return false;
		}
	}

	public Task Task
	{
		get
		{
			if (!IsValidWithWarning)
			{
				return null;
			}
			return Provider.Task;
		}
	}

	object IEnumerator.Current => Provider;

	internal HandleBase(ProviderOperation provider)
	{
		Provider = provider;
		_assetInfo = provider.MainAssetInfo;
	}

	internal abstract void InvokeCallback();

	public void Release()
	{
		if (IsValidWithWarning)
		{
			Provider.ReleaseHandle(this);
			Provider = null;
		}
	}

	public void Dispose()
	{
		Release();
	}

	public AssetInfo GetAssetInfo()
	{
		return _assetInfo;
	}

	public DownloadStatus GetDownloadStatus()
	{
		if (!IsValidWithWarning)
		{
			return DownloadStatus.CreateDefaultStatus();
		}
		return Provider.GetDownloadStatus();
	}

	bool IEnumerator.MoveNext()
	{
		return !IsDone;
	}

	void IEnumerator.Reset()
	{
	}
}
