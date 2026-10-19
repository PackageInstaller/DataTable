using System.Collections;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;

namespace System.Diagnostics;

internal class AsyncStreamReader : IDisposable
{
	private Stream stream;

	private Encoding encoding;

	private Decoder decoder;

	private byte[] byteBuffer;

	private char[] charBuffer;

	private int _maxCharsPerBuffer;

	private Process process;

	private UserCallBack userCallBack;

	private bool cancelOperation;

	private ManualResetEvent eofEvent;

	private Queue messageQueue;

	private StringBuilder sb;

	private bool bLastCarriageReturn;

	private int currentLinePos;

	private object syncObject = new object();

	private IAsyncResult asyncReadResult;

	internal AsyncStreamReader(Process process, Stream stream, UserCallBack callback, Encoding encoding)
		: this(process, stream, callback, encoding, 1024)
	{
	}

	internal AsyncStreamReader(Process process, Stream stream, UserCallBack callback, Encoding encoding, int bufferSize)
	{
		Init(process, stream, callback, encoding, bufferSize);
		messageQueue = new Queue();
	}

	private void Init(Process process, Stream stream, UserCallBack callback, Encoding encoding, int bufferSize)
	{
		this.process = process;
		this.stream = stream;
		this.encoding = encoding;
		userCallBack = callback;
		decoder = encoding.GetDecoder();
		if (bufferSize < 128)
		{
			bufferSize = 128;
		}
		byteBuffer = new byte[bufferSize];
		_maxCharsPerBuffer = encoding.GetMaxCharCount(bufferSize);
		charBuffer = new char[_maxCharsPerBuffer];
		cancelOperation = false;
		eofEvent = new ManualResetEvent(initialState: false);
		sb = null;
		bLastCarriageReturn = false;
	}

	public virtual void Close()
	{
		Dispose(disposing: true);
	}

	void IDisposable.Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
		lock (syncObject)
		{
			if (disposing && stream != null)
			{
				if (asyncReadResult != null && !asyncReadResult.IsCompleted && stream is FileStream)
				{
					SafeHandle safeFileHandle = ((FileStream)stream).SafeFileHandle;
					MonoIOError error;
					while (!asyncReadResult.IsCompleted && (MonoIO.Cancel(safeFileHandle, out error) || error != MonoIOError.ERROR_NOT_SUPPORTED))
					{
						asyncReadResult.AsyncWaitHandle.WaitOne(200);
					}
				}
				stream.Close();
			}
			if (stream != null)
			{
				stream = null;
				encoding = null;
				decoder = null;
				byteBuffer = null;
				charBuffer = null;
			}
			if (eofEvent != null)
			{
				eofEvent.Close();
				eofEvent = null;
			}
		}
	}

	internal void BeginReadLine()
	{
		if (cancelOperation)
		{
			cancelOperation = false;
		}
		if (sb == null)
		{
			sb = new StringBuilder(1024);
			asyncReadResult = stream.BeginRead(byteBuffer, 0, byteBuffer.Length, ReadBuffer, null);
		}
		else
		{
			FlushMessageQueue();
		}
	}

	internal void CancelOperation()
	{
		cancelOperation = true;
	}

	private void ReadBuffer(IAsyncResult ar)
	{
		int num;
		try
		{
			lock (syncObject)
			{
				asyncReadResult = null;
				num = ((stream != null) ? stream.EndRead(ar) : 0);
			}
		}
		catch (IOException)
		{
			num = 0;
		}
		catch (OperationCanceledException)
		{
			num = 0;
		}
		while (num != 0)
		{
			lock (syncObject)
			{
				if (decoder == null)
				{
					num = 0;
					continue;
				}
				int chars = decoder.GetChars(byteBuffer, 0, num, charBuffer, 0);
				sb.Append(charBuffer, 0, chars);
			}
			GetLinesFromStringBuilder();
			lock (syncObject)
			{
				if (stream == null)
				{
					num = 0;
					continue;
				}
				asyncReadResult = stream.BeginRead(byteBuffer, 0, byteBuffer.Length, ReadBuffer, null);
				return;
			}
		}
		lock (messageQueue)
		{
			if (sb.Length != 0)
			{
				messageQueue.Enqueue(sb.ToString());
				sb.Length = 0;
			}
			messageQueue.Enqueue(null);
		}
		try
		{
			FlushMessageQueue();
		}
		finally
		{
			lock (syncObject)
			{
				if (eofEvent != null)
				{
					try
					{
						eofEvent.Set();
					}
					catch (ObjectDisposedException)
					{
					}
				}
			}
		}
	}

	private void GetLinesFromStringBuilder()
	{
		int i = currentLinePos;
		int num = 0;
		int length = sb.Length;
		if (bLastCarriageReturn && length > 0 && sb[0] == '\n')
		{
			i = 1;
			num = 1;
			bLastCarriageReturn = false;
		}
		for (; i < length; i++)
		{
			char c = sb[i];
			if (c == '\r' || c == '\n')
			{
				string obj = sb.ToString(num, i - num);
				num = i + 1;
				if (c == '\r' && num < length && sb[num] == '\n')
				{
					num++;
					i++;
				}
				lock (messageQueue)
				{
					messageQueue.Enqueue(obj);
				}
			}
		}
		if (sb[length - 1] == '\r')
		{
			bLastCarriageReturn = true;
		}
		if (num < length)
		{
			if (num == 0)
			{
				currentLinePos = i;
			}
			else
			{
				sb.Remove(0, num);
				currentLinePos = 0;
			}
		}
		else
		{
			sb.Length = 0;
			currentLinePos = 0;
		}
		FlushMessageQueue();
	}

	private void FlushMessageQueue()
	{
		while (messageQueue.Count > 0)
		{
			lock (messageQueue)
			{
				if (messageQueue.Count > 0)
				{
					string data = (string)messageQueue.Dequeue();
					if (!cancelOperation)
					{
						userCallBack(data);
					}
				}
			}
		}
	}

	internal void WaitUtilEOF()
	{
		if (eofEvent != null)
		{
			eofEvent.WaitOne();
			eofEvent.Close();
			eofEvent = null;
		}
	}
}
