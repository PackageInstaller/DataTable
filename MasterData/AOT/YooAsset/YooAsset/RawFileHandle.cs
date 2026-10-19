using System;
using System.IO;

namespace YooAsset;

public class RawFileHandle : HandleBase
{
	private Action<RawFileHandle> _callback;

	public event Action<RawFileHandle> Completed
	{
		add
		{
			if (!IsValidWithWarning)
			{
				throw new Exception("RawFileHandle is invalid");
			}
			if (Provider.IsDone)
			{
				value(this);
			}
			else
			{
				_callback = (Action<RawFileHandle>)Delegate.Combine(_callback, value);
			}
		}
		remove
		{
			if (!IsValidWithWarning)
			{
				throw new Exception("RawFileHandle is invalid");
			}
			_callback = (Action<RawFileHandle>)Delegate.Remove(_callback, value);
		}
	}

	internal RawFileHandle(ProviderOperation provider)
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

	public byte[] GetRawFileData()
	{
		if (!IsValidWithWarning)
		{
			return null;
		}
		return Provider.BundleResultObject.ReadBundleFileData();
	}

	public string GetRawFileText()
	{
		if (!IsValidWithWarning)
		{
			return null;
		}
		return Provider.BundleResultObject.ReadBundleFileText();
	}

	public string GetRawFilePath()
	{
		if (!IsValidWithWarning)
		{
			return string.Empty;
		}
		return Provider.BundleResultObject.GetBundleFilePath();
	}

	public Stream OpenRawFileStream()
	{
		if (!IsValidWithWarning)
		{
			return null;
		}
		return Provider.BundleResultObject.OpenBundleFileStream();
	}
}
