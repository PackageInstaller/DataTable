using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Security.Authentication;
using System.Security.Cryptography;
using System.Threading;

namespace Mono.Btls;

internal abstract class MonoBtlsObject : IDisposable
{
	protected internal abstract class MonoBtlsHandle : SafeHandle
	{
		public override bool IsInvalid => handle == IntPtr.Zero;

		internal MonoBtlsHandle(IntPtr handle, bool ownsHandle)
			: base(handle, ownsHandle)
		{
		}
	}

	private MonoBtlsHandle handle;

	private Exception lastError;

	internal MonoBtlsHandle Handle
	{
		get
		{
			CheckThrow();
			return handle;
		}
	}

	public bool IsValid
	{
		get
		{
			if (handle != null)
			{
				return !handle.IsInvalid;
			}
			return false;
		}
	}

	internal MonoBtlsObject(MonoBtlsHandle handle)
	{
		this.handle = handle;
	}

	protected void CheckThrow()
	{
		if (lastError != null)
		{
			throw lastError;
		}
		if (handle == null || handle.IsInvalid)
		{
			throw new ObjectDisposedException("MonoBtlsSsl");
		}
	}

	protected Exception SetException(Exception ex)
	{
		if (lastError == null)
		{
			lastError = ex;
		}
		return ex;
	}

	protected void CheckError(bool ok, [CallerMemberName] string callerName = null)
	{
		if (!ok)
		{
			if (callerName != null)
			{
				throw new CryptographicException("`" + GetType().Name + "." + callerName + "` failed.");
			}
			throw new CryptographicException();
		}
	}

	protected void CheckError(int ret, [CallerMemberName] string callerName = null)
	{
		CheckError(ret == 1, callerName);
	}

	protected internal void CheckLastError([CallerMemberName] string callerName = null)
	{
		Exception ex = Interlocked.Exchange(ref lastError, null);
		if (ex == null)
		{
			return;
		}
		if (ex is AuthenticationException || ex is NotSupportedException)
		{
			throw ex;
		}
		string message = ((callerName == null) ? "Caught unhandled exception." : ("Caught unhandled exception in `" + GetType().Name + "." + callerName + "`."));
		throw new CryptographicException(message, ex);
	}

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_free(IntPtr data);

	protected void FreeDataPtr(IntPtr data)
	{
		mono_btls_free(data);
	}

	protected virtual void Close()
	{
	}

	protected void Dispose(bool disposing)
	{
		if (!disposing)
		{
			return;
		}
		try
		{
			if (handle != null)
			{
				Close();
				handle.Dispose();
				handle = null;
			}
		}
		finally
		{
			ObjectDisposedException value = new ObjectDisposedException(GetType().Name);
			Interlocked.CompareExchange(ref lastError, value, null);
		}
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	~MonoBtlsObject()
	{
		Dispose(disposing: false);
	}
}
