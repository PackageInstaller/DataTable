using System.IO;
using System.Net.Sockets;
using System.Runtime.ExceptionServices;

namespace System.Net;

internal class FtpDataStream : Stream, ICloseEx
{
	private FtpWebRequest _request;

	private NetworkStream _networkStream;

	private bool _writeable;

	private bool _readable;

	private bool _isFullyRead;

	private bool _closing;

	public override bool CanRead => _readable;

	public override bool CanSeek => _networkStream.CanSeek;

	public override bool CanWrite => _writeable;

	public override long Length => _networkStream.Length;

	public override long Position
	{
		get
		{
			return _networkStream.Position;
		}
		set
		{
			_networkStream.Position = value;
		}
	}

	public override bool CanTimeout => _networkStream.CanTimeout;

	public override int ReadTimeout
	{
		get
		{
			return _networkStream.ReadTimeout;
		}
		set
		{
			_networkStream.ReadTimeout = value;
		}
	}

	public override int WriteTimeout
	{
		get
		{
			return _networkStream.WriteTimeout;
		}
		set
		{
			_networkStream.WriteTimeout = value;
		}
	}

	internal FtpDataStream(NetworkStream networkStream, FtpWebRequest request, TriState writeOnly)
	{
		if (NetEventSource.IsEnabled)
		{
			NetEventSource.Info(this, null, ".ctor");
		}
		_readable = true;
		_writeable = true;
		switch (writeOnly)
		{
		case TriState.True:
			_readable = false;
			break;
		case TriState.False:
			_writeable = false;
			break;
		}
		_networkStream = networkStream;
		_request = request;
	}

	protected override void Dispose(bool disposing)
	{
		try
		{
			if (disposing)
			{
				((ICloseEx)this).CloseEx(CloseExState.Normal);
			}
			else
			{
				((ICloseEx)this).CloseEx(CloseExState.Abort | CloseExState.Silent);
			}
		}
		finally
		{
			base.Dispose(disposing);
		}
	}

	void ICloseEx.CloseEx(CloseExState closeState)
	{
		if (NetEventSource.IsEnabled)
		{
			NetEventSource.Info(this, $"state = {closeState}", "CloseEx");
		}
		lock (this)
		{
			if (_closing)
			{
				return;
			}
			_closing = true;
			_writeable = false;
			_readable = false;
		}
		try
		{
			try
			{
				if ((closeState & CloseExState.Abort) == 0)
				{
					_networkStream.Close(-1);
				}
				else
				{
					_networkStream.Close(0);
				}
			}
			finally
			{
				_request.DataStreamClosed(closeState);
			}
		}
		catch (Exception ex)
		{
			bool flag = true;
			if (ex is WebException { Response: FtpWebResponse response } && !_isFullyRead && response.StatusCode == FtpStatusCode.ConnectionClosed)
			{
				flag = false;
			}
			if (flag && (closeState & CloseExState.Silent) == 0)
			{
				throw;
			}
		}
	}

	private void CheckError()
	{
		if (_request.Aborted)
		{
			throw ExceptionHelper.RequestAbortedException;
		}
	}

	public override long Seek(long offset, SeekOrigin origin)
	{
		CheckError();
		try
		{
			return _networkStream.Seek(offset, origin);
		}
		catch
		{
			CheckError();
			throw;
		}
	}

	public override int Read(byte[] buffer, int offset, int size)
	{
		CheckError();
		int num;
		try
		{
			num = _networkStream.Read(buffer, offset, size);
		}
		catch
		{
			CheckError();
			throw;
		}
		if (num == 0)
		{
			_isFullyRead = true;
			Close();
		}
		return num;
	}

	public override void Write(byte[] buffer, int offset, int size)
	{
		CheckError();
		try
		{
			_networkStream.Write(buffer, offset, size);
		}
		catch
		{
			CheckError();
			throw;
		}
	}

	private void AsyncReadCallback(IAsyncResult ar)
	{
		LazyAsyncResult lazyAsyncResult = (LazyAsyncResult)ar.AsyncState;
		try
		{
			try
			{
				int num = _networkStream.EndRead(ar);
				if (num == 0)
				{
					_isFullyRead = true;
					Close();
				}
				lazyAsyncResult.InvokeCallback(num);
			}
			catch (Exception result)
			{
				if (!lazyAsyncResult.IsCompleted)
				{
					lazyAsyncResult.InvokeCallback(result);
				}
			}
		}
		catch
		{
		}
	}

	public override IAsyncResult BeginRead(byte[] buffer, int offset, int size, AsyncCallback callback, object state)
	{
		CheckError();
		LazyAsyncResult lazyAsyncResult = new LazyAsyncResult(this, state, callback);
		try
		{
			_networkStream.BeginRead(buffer, offset, size, AsyncReadCallback, lazyAsyncResult);
			return lazyAsyncResult;
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
			object obj = ((LazyAsyncResult)ar).InternalWaitForCompletion();
			if (obj is Exception source)
			{
				ExceptionDispatchInfo.Throw(source);
			}
			return (int)obj;
		}
		finally
		{
			CheckError();
		}
	}

	public override IAsyncResult BeginWrite(byte[] buffer, int offset, int size, AsyncCallback callback, object state)
	{
		CheckError();
		try
		{
			return _networkStream.BeginWrite(buffer, offset, size, callback, state);
		}
		catch
		{
			CheckError();
			throw;
		}
	}

	public override void EndWrite(IAsyncResult asyncResult)
	{
		try
		{
			_networkStream.EndWrite(asyncResult);
		}
		finally
		{
			CheckError();
		}
	}

	public override void Flush()
	{
		_networkStream.Flush();
	}

	public override void SetLength(long value)
	{
		_networkStream.SetLength(value);
	}

	internal void SetSocketTimeoutOption(int timeout)
	{
		_networkStream.ReadTimeout = timeout;
		_networkStream.WriteTimeout = timeout;
	}
}
