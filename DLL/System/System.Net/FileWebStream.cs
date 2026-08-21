using System.IO;

namespace System.Net;

internal sealed class FileWebStream : FileStream, ICloseEx
{
	private FileWebRequest m_request;

	public FileWebStream(FileWebRequest request, string path, FileMode mode, FileAccess access, FileShare sharing)
		: base(path, mode, access, sharing)
	{
		m_request = request;
	}

	public FileWebStream(FileWebRequest request, string path, FileMode mode, FileAccess access, FileShare sharing, int length, bool async)
		: base(path, mode, access, sharing, length, async)
	{
		m_request = request;
	}

	protected override void Dispose(bool disposing)
	{
		try
		{
			if (disposing && m_request != null)
			{
				m_request.UnblockReader();
			}
		}
		finally
		{
			base.Dispose(disposing);
		}
	}

	void ICloseEx.CloseEx(CloseExState closeState)
	{
		if ((closeState & CloseExState.Abort) != CloseExState.Normal)
		{
			SafeFileHandle.Close();
		}
		else
		{
			Close();
		}
	}

	public override int Read(byte[] buffer, int offset, int size)
	{
		CheckError();
		try
		{
			return base.Read(buffer, offset, size);
		}
		catch
		{
			CheckError();
			throw;
		}
	}

	public override void Write(byte[] buffer, int offset, int size)
	{
		CheckError();
		try
		{
			base.Write(buffer, offset, size);
		}
		catch
		{
			CheckError();
			throw;
		}
	}

	public override IAsyncResult BeginRead(byte[] buffer, int offset, int size, AsyncCallback callback, object state)
	{
		CheckError();
		try
		{
			return base.BeginRead(buffer, offset, size, callback, state);
		}
		catch
		{
			CheckError();
			throw;
		}
	}

	public override int EndRead(IAsyncResult ar)
	{
		try
		{
			return base.EndRead(ar);
		}
		catch
		{
			CheckError();
			throw;
		}
	}

	public override IAsyncResult BeginWrite(byte[] buffer, int offset, int size, AsyncCallback callback, object state)
	{
		CheckError();
		try
		{
			return base.BeginWrite(buffer, offset, size, callback, state);
		}
		catch
		{
			CheckError();
			throw;
		}
	}

	public override void EndWrite(IAsyncResult ar)
	{
		try
		{
			base.EndWrite(ar);
		}
		catch
		{
			CheckError();
			throw;
		}
	}

	private void CheckError()
	{
		if (m_request.Aborted)
		{
			throw new WebException(NetRes.GetWebStatusString("net_requestaborted", WebExceptionStatus.RequestCanceled), WebExceptionStatus.RequestCanceled);
		}
	}
}
