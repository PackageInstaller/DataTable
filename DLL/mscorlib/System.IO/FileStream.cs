using System.Runtime.InteropServices;
using System.Runtime.Remoting.Messaging;
using System.Security;
using System.Security.AccessControl;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Win32.SafeHandles;

namespace System.IO;

[ComVisible(true)]
public class FileStream : Stream
{
	private delegate int ReadDelegate(byte[] buffer, int offset, int count);

	private delegate void WriteDelegate(byte[] buffer, int offset, int count);

	internal const int DefaultBufferSize = 4096;

	private static byte[] buf_recycle;

	private static readonly object buf_recycle_lock = new object();

	private byte[] buf;

	private string name = "[Unknown]";

	private SafeFileHandle safeHandle;

	private bool isExposed;

	private long append_startpos;

	private FileAccess access;

	private bool owner;

	private bool async;

	private bool canseek;

	private bool anonymous;

	private bool buf_dirty;

	private int buf_size;

	private int buf_length;

	private int buf_offset;

	private long buf_start;

	public override bool CanRead
	{
		get
		{
			if (access != FileAccess.Read)
			{
				return access == FileAccess.ReadWrite;
			}
			return true;
		}
	}

	public override bool CanWrite
	{
		get
		{
			if (access != FileAccess.Write)
			{
				return access == FileAccess.ReadWrite;
			}
			return true;
		}
	}

	public override bool CanSeek => canseek;

	public virtual bool IsAsync => async;

	public virtual string Name => name;

	public override long Length
	{
		get
		{
			if (safeHandle.IsClosed)
			{
				throw new ObjectDisposedException("Stream has been closed");
			}
			if (!CanSeek)
			{
				throw new NotSupportedException("The stream does not support seeking");
			}
			FlushBufferIfDirty();
			long length = MonoIO.GetLength(safeHandle, out var error);
			if (error != MonoIOError.ERROR_SUCCESS)
			{
				throw MonoIO.GetException(GetSecureFileName(name), error);
			}
			return length;
		}
	}

	public override long Position
	{
		get
		{
			if (safeHandle.IsClosed)
			{
				throw new ObjectDisposedException("Stream has been closed");
			}
			if (!CanSeek)
			{
				throw new NotSupportedException("The stream does not support seeking");
			}
			if (!isExposed)
			{
				return buf_start + buf_offset;
			}
			long result = MonoIO.Seek(safeHandle, 0L, SeekOrigin.Current, out var error);
			if (error != MonoIOError.ERROR_SUCCESS)
			{
				throw MonoIO.GetException(GetSecureFileName(name), error);
			}
			return result;
		}
		set
		{
			if (value < 0)
			{
				throw new ArgumentOutOfRangeException("value", Environment.GetResourceString("Non-negative number required."));
			}
			Seek(value, SeekOrigin.Begin);
		}
	}

	[Obsolete("Use SafeFileHandle instead")]
	public virtual IntPtr Handle
	{
		get
		{
			IntPtr result = safeHandle.DangerousGetHandle();
			if (!isExposed)
			{
				ExposeHandle();
			}
			return result;
		}
	}

	public virtual SafeFileHandle SafeFileHandle
	{
		get
		{
			if (!isExposed)
			{
				ExposeHandle();
			}
			return safeHandle;
		}
	}

	[Obsolete("Use FileStream(SafeFileHandle handle, FileAccess access) instead")]
	public FileStream(IntPtr handle, FileAccess access)
		: this(handle, access, ownsHandle: true, 4096, isAsync: false, isConsoleWrapper: false)
	{
	}

	[Obsolete("Use FileStream(SafeFileHandle handle, FileAccess access) instead")]
	public FileStream(IntPtr handle, FileAccess access, bool ownsHandle)
		: this(handle, access, ownsHandle, 4096, isAsync: false, isConsoleWrapper: false)
	{
	}

	[Obsolete("Use FileStream(SafeFileHandle handle, FileAccess access, int bufferSize) instead")]
	public FileStream(IntPtr handle, FileAccess access, bool ownsHandle, int bufferSize)
		: this(handle, access, ownsHandle, bufferSize, isAsync: false, isConsoleWrapper: false)
	{
	}

	[Obsolete("Use FileStream(SafeFileHandle handle, FileAccess access, int bufferSize, bool isAsync) instead")]
	public FileStream(IntPtr handle, FileAccess access, bool ownsHandle, int bufferSize, bool isAsync)
		: this(handle, access, ownsHandle, bufferSize, isAsync, isConsoleWrapper: false)
	{
	}

	internal FileStream(IntPtr handle, FileAccess access, bool ownsHandle, int bufferSize, bool isAsync, bool isConsoleWrapper)
	{
		if (handle == MonoIO.InvalidHandle)
		{
			throw new ArgumentException("handle", Locale.GetText("Invalid."));
		}
		Init(new SafeFileHandle(handle, ownsHandle: false), access, ownsHandle, bufferSize, isAsync, isConsoleWrapper);
	}

	public FileStream(string path, FileMode mode)
		: this(path, mode, (mode == FileMode.Append) ? FileAccess.Write : FileAccess.ReadWrite, FileShare.Read, 4096, anonymous: false, FileOptions.None)
	{
	}

	public FileStream(string path, FileMode mode, FileAccess access)
		: this(path, mode, access, (access != FileAccess.Write) ? FileShare.Read : FileShare.None, 4096, isAsync: false, anonymous: false)
	{
	}

	public FileStream(string path, FileMode mode, FileAccess access, FileShare share)
		: this(path, mode, access, share, 4096, anonymous: false, FileOptions.None)
	{
	}

	public FileStream(string path, FileMode mode, FileAccess access, FileShare share, int bufferSize)
		: this(path, mode, access, share, bufferSize, anonymous: false, FileOptions.None)
	{
	}

	public FileStream(string path, FileMode mode, FileAccess access, FileShare share, int bufferSize, bool useAsync)
		: this(path, mode, access, share, bufferSize, useAsync ? FileOptions.Asynchronous : FileOptions.None)
	{
	}

	public FileStream(string path, FileMode mode, FileAccess access, FileShare share, int bufferSize, FileOptions options)
		: this(path, mode, access, share, bufferSize, anonymous: false, options)
	{
	}

	public FileStream(SafeFileHandle handle, FileAccess access)
		: this(handle, access, 4096, isAsync: false)
	{
	}

	public FileStream(SafeFileHandle handle, FileAccess access, int bufferSize)
		: this(handle, access, bufferSize, isAsync: false)
	{
	}

	public FileStream(SafeFileHandle handle, FileAccess access, int bufferSize, bool isAsync)
	{
		Init(handle, access, ownsHandle: false, bufferSize, isAsync, isConsoleWrapper: false);
	}

	[MonoLimitation("This ignores the rights parameter")]
	public FileStream(string path, FileMode mode, FileSystemRights rights, FileShare share, int bufferSize, FileOptions options)
		: this(path, mode, (mode == FileMode.Append) ? FileAccess.Write : FileAccess.ReadWrite, share, bufferSize, anonymous: false, options)
	{
	}

	[MonoLimitation("This ignores the rights and fileSecurity parameters")]
	public FileStream(string path, FileMode mode, FileSystemRights rights, FileShare share, int bufferSize, FileOptions options, FileSecurity fileSecurity)
		: this(path, mode, (mode == FileMode.Append) ? FileAccess.Write : FileAccess.ReadWrite, share, bufferSize, anonymous: false, options)
	{
	}

	internal FileStream(string path, FileMode mode, FileAccess access, FileShare share, int bufferSize, FileOptions options, string msgPath, bool bFromProxy, bool useLongPath = false, bool checkHost = false)
		: this(path, mode, access, share, bufferSize, anonymous: false, options)
	{
	}

	internal FileStream(string path, FileMode mode, FileAccess access, FileShare share, int bufferSize, bool isAsync, bool anonymous)
		: this(path, mode, access, share, bufferSize, anonymous, isAsync ? FileOptions.Asynchronous : FileOptions.None)
	{
	}

	internal FileStream(string path, FileMode mode, FileAccess access, FileShare share, int bufferSize, bool anonymous, FileOptions options)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Path is empty");
		}
		this.anonymous = anonymous;
		share &= ~FileShare.Inheritable;
		if (bufferSize <= 0)
		{
			throw new ArgumentOutOfRangeException("bufferSize", "Positive number required.");
		}
		if (mode < FileMode.CreateNew || mode > FileMode.Append)
		{
			if (anonymous)
			{
				throw new ArgumentException("mode", "Enum value was out of legal range.");
			}
			throw new ArgumentOutOfRangeException("mode", "Enum value was out of legal range.");
		}
		if (access < FileAccess.Read || access > FileAccess.ReadWrite)
		{
			throw new ArgumentOutOfRangeException("access", "Enum value was out of legal range.");
		}
		if ((share < FileShare.None) || share > (FileShare.ReadWrite | FileShare.Delete))
		{
			throw new ArgumentOutOfRangeException("share", "Enum value was out of legal range.");
		}
		if (path.IndexOfAny(Path.InvalidPathChars) != -1)
		{
			throw new ArgumentException("Name has invalid chars");
		}
		path = Path.InsecureGetFullPath(path);
		if (Directory.Exists(path))
		{
			throw new UnauthorizedAccessException(string.Format(Locale.GetText("Access to the path '{0}' is denied."), GetSecureFileName(path, full: false)));
		}
		if (mode == FileMode.Append && (access & FileAccess.Read) == FileAccess.Read)
		{
			throw new ArgumentException("Append access can be requested only in write-only mode.");
		}
		if ((access & FileAccess.Write) == 0 && mode != FileMode.Open && mode != FileMode.OpenOrCreate)
		{
			throw new ArgumentException(string.Format(Locale.GetText("Combining FileMode: {0} with FileAccess: {1} is invalid."), access, mode));
		}
		SecurityManager.EnsureElevatedPermissions();
		string directoryName = Path.GetDirectoryName(path);
		if (directoryName.Length > 0 && !Directory.Exists(Path.GetFullPath(directoryName)))
		{
			throw new DirectoryNotFoundException(string.Format(Locale.GetText("Could not find a part of the path \"{0}\"."), anonymous ? directoryName : Path.GetFullPath(path)));
		}
		if (!anonymous)
		{
			name = path;
		}
		IntPtr intPtr = MonoIO.Open(path, mode, access, share, options, out var error);
		if (intPtr == MonoIO.InvalidHandle)
		{
			throw MonoIO.GetException(GetSecureFileName(path), error);
		}
		safeHandle = new SafeFileHandle(intPtr, ownsHandle: false);
		this.access = access;
		owner = true;
		if (MonoIO.GetFileType(safeHandle, out error) == MonoFileType.Disk)
		{
			canseek = true;
			async = (options & FileOptions.Asynchronous) != 0;
		}
		else
		{
			canseek = false;
			async = false;
		}
		if (access == FileAccess.Read && canseek && bufferSize == 4096)
		{
			long length = Length;
			if (bufferSize > length)
			{
				bufferSize = (int)((length < 1000) ? 1000 : length);
			}
		}
		InitBuffer(bufferSize, isZeroSize: false);
		if (mode == FileMode.Append)
		{
			Seek(0L, SeekOrigin.End);
			append_startpos = Position;
		}
		else
		{
			append_startpos = 0L;
		}
	}

	private void Init(SafeFileHandle safeHandle, FileAccess access, bool ownsHandle, int bufferSize, bool isAsync, bool isConsoleWrapper)
	{
		if (!isConsoleWrapper && safeHandle.IsInvalid)
		{
			throw new ArgumentException(Environment.GetResourceString("Invalid handle."), "handle");
		}
		if (access < FileAccess.Read || access > FileAccess.ReadWrite)
		{
			throw new ArgumentOutOfRangeException("access");
		}
		if (!isConsoleWrapper && bufferSize <= 0)
		{
			throw new ArgumentOutOfRangeException("bufferSize", Environment.GetResourceString("Positive number required."));
		}
		MonoFileType fileType = MonoIO.GetFileType(safeHandle, out var error);
		if (error != MonoIOError.ERROR_SUCCESS)
		{
			throw MonoIO.GetException(name, error);
		}
		switch (fileType)
		{
		case MonoFileType.Unknown:
			throw new IOException("Invalid handle.");
		case MonoFileType.Disk:
			canseek = true;
			break;
		default:
			canseek = false;
			break;
		}
		this.safeHandle = safeHandle;
		ExposeHandle();
		this.access = access;
		owner = ownsHandle;
		async = isAsync;
		anonymous = false;
		if (canseek)
		{
			buf_start = MonoIO.Seek(safeHandle, 0L, SeekOrigin.Current, out error);
			if (error != MonoIOError.ERROR_SUCCESS)
			{
				throw MonoIO.GetException(name, error);
			}
		}
		append_startpos = 0L;
	}

	private void ExposeHandle()
	{
		isExposed = true;
		FlushBuffer();
		InitBuffer(0, isZeroSize: true);
	}

	public override int ReadByte()
	{
		if (safeHandle.IsClosed)
		{
			throw new ObjectDisposedException("Stream has been closed");
		}
		if (!CanRead)
		{
			throw new NotSupportedException("Stream does not support reading");
		}
		if (buf_size == 0)
		{
			if (ReadData(safeHandle, buf, 0, 1) == 0)
			{
				return -1;
			}
			return buf[0];
		}
		if (buf_offset >= buf_length)
		{
			RefillBuffer();
			if (buf_length == 0)
			{
				return -1;
			}
		}
		return buf[buf_offset++];
	}

	public override void WriteByte(byte value)
	{
		if (safeHandle.IsClosed)
		{
			throw new ObjectDisposedException("Stream has been closed");
		}
		if (!CanWrite)
		{
			throw new NotSupportedException("Stream does not support writing");
		}
		if (buf_offset == buf_size)
		{
			FlushBuffer();
		}
		if (buf_size == 0)
		{
			buf[0] = value;
			buf_dirty = true;
			buf_length = 1;
			FlushBuffer();
			return;
		}
		buf[buf_offset++] = value;
		if (buf_offset > buf_length)
		{
			buf_length = buf_offset;
		}
		buf_dirty = true;
	}

	public override int Read([In][Out] byte[] array, int offset, int count)
	{
		if (safeHandle.IsClosed)
		{
			throw new ObjectDisposedException("Stream has been closed");
		}
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (!CanRead)
		{
			throw new NotSupportedException("Stream does not support reading");
		}
		int num = array.Length;
		if (offset < 0)
		{
			throw new ArgumentOutOfRangeException("offset", "< 0");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "< 0");
		}
		if (offset > num)
		{
			throw new ArgumentException("destination offset is beyond array size");
		}
		if (offset > num - count)
		{
			throw new ArgumentException("Reading would overrun buffer");
		}
		if (async)
		{
			IAsyncResult asyncResult = BeginRead(array, offset, count, null, null);
			return EndRead(asyncResult);
		}
		return ReadInternal(array, offset, count);
	}

	private int ReadInternal(byte[] dest, int offset, int count)
	{
		int num = ReadSegment(dest, offset, count);
		if (num == count)
		{
			return count;
		}
		int num2 = num;
		count -= num;
		if (count > buf_size)
		{
			FlushBuffer();
			num = ReadData(safeHandle, dest, offset + num, count);
			buf_start += num;
		}
		else
		{
			RefillBuffer();
			num = ReadSegment(dest, offset + num2, count);
		}
		return num2 + num;
	}

	public override IAsyncResult BeginRead(byte[] array, int offset, int numBytes, AsyncCallback userCallback, object stateObject)
	{
		if (safeHandle.IsClosed)
		{
			throw new ObjectDisposedException("Stream has been closed");
		}
		if (!CanRead)
		{
			throw new NotSupportedException("This stream does not support reading");
		}
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (numBytes < 0)
		{
			throw new ArgumentOutOfRangeException("numBytes", "Must be >= 0");
		}
		if (offset < 0)
		{
			throw new ArgumentOutOfRangeException("offset", "Must be >= 0");
		}
		if (numBytes > array.Length - offset)
		{
			throw new ArgumentException("Buffer too small. numBytes/offset wrong.");
		}
		if (!async)
		{
			return base.BeginRead(array, offset, numBytes, userCallback, stateObject);
		}
		return new ReadDelegate(ReadInternal).BeginInvoke(array, offset, numBytes, userCallback, stateObject);
	}

	public override int EndRead(IAsyncResult asyncResult)
	{
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		if (!async)
		{
			return base.EndRead(asyncResult);
		}
		return ((((asyncResult as AsyncResult) ?? throw new ArgumentException("Invalid IAsyncResult", "asyncResult")).AsyncDelegate as ReadDelegate) ?? throw new ArgumentException("Invalid IAsyncResult", "asyncResult")).EndInvoke(asyncResult);
	}

	public override void Write(byte[] array, int offset, int count)
	{
		if (safeHandle.IsClosed)
		{
			throw new ObjectDisposedException("Stream has been closed");
		}
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (offset < 0)
		{
			throw new ArgumentOutOfRangeException("offset", "< 0");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "< 0");
		}
		if (offset > array.Length - count)
		{
			throw new ArgumentException("Reading would overrun buffer");
		}
		if (!CanWrite)
		{
			throw new NotSupportedException("Stream does not support writing");
		}
		if (async)
		{
			IAsyncResult asyncResult = BeginWrite(array, offset, count, null, null);
			EndWrite(asyncResult);
		}
		else
		{
			WriteInternal(array, offset, count);
		}
	}

	private void WriteInternal(byte[] src, int offset, int count)
	{
		if (count > buf_size)
		{
			FlushBuffer();
			MonoIOError error;
			if (CanSeek && !isExposed)
			{
				MonoIO.Seek(safeHandle, buf_start, SeekOrigin.Begin, out error);
				if (error != MonoIOError.ERROR_SUCCESS)
				{
					throw MonoIO.GetException(GetSecureFileName(name), error);
				}
			}
			int num = count;
			while (num > 0)
			{
				int num2 = MonoIO.Write(safeHandle, src, offset, num, out error);
				if (error != MonoIOError.ERROR_SUCCESS)
				{
					throw MonoIO.GetException(GetSecureFileName(name), error);
				}
				num -= num2;
				offset += num2;
			}
			buf_start += count;
			return;
		}
		int num3 = 0;
		while (count > 0)
		{
			int num4 = WriteSegment(src, offset + num3, count);
			num3 += num4;
			count -= num4;
			if (count != 0)
			{
				FlushBuffer();
				continue;
			}
			break;
		}
	}

	public override IAsyncResult BeginWrite(byte[] array, int offset, int numBytes, AsyncCallback userCallback, object stateObject)
	{
		if (safeHandle.IsClosed)
		{
			throw new ObjectDisposedException("Stream has been closed");
		}
		if (!CanWrite)
		{
			throw new NotSupportedException("This stream does not support writing");
		}
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (numBytes < 0)
		{
			throw new ArgumentOutOfRangeException("numBytes", "Must be >= 0");
		}
		if (offset < 0)
		{
			throw new ArgumentOutOfRangeException("offset", "Must be >= 0");
		}
		if (numBytes > array.Length - offset)
		{
			throw new ArgumentException("array too small. numBytes/offset wrong.");
		}
		if (!async)
		{
			return base.BeginWrite(array, offset, numBytes, userCallback, stateObject);
		}
		new FileStreamAsyncResult(userCallback, stateObject)
		{
			BytesRead = -1,
			Count = numBytes,
			OriginalCount = numBytes
		};
		return new WriteDelegate(WriteInternal).BeginInvoke(array, offset, numBytes, userCallback, stateObject);
	}

	public override void EndWrite(IAsyncResult asyncResult)
	{
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		if (!async)
		{
			base.EndWrite(asyncResult);
		}
		else
		{
			((((asyncResult as AsyncResult) ?? throw new ArgumentException("Invalid IAsyncResult", "asyncResult")).AsyncDelegate as WriteDelegate) ?? throw new ArgumentException("Invalid IAsyncResult", "asyncResult")).EndInvoke(asyncResult);
		}
	}

	public override long Seek(long offset, SeekOrigin origin)
	{
		if (safeHandle.IsClosed)
		{
			throw new ObjectDisposedException("Stream has been closed");
		}
		if (!CanSeek)
		{
			throw new NotSupportedException("The stream does not support seeking");
		}
		long num = origin switch
		{
			SeekOrigin.End => Length + offset, 
			SeekOrigin.Current => Position + offset, 
			SeekOrigin.Begin => offset, 
			_ => throw new ArgumentException("origin", "Invalid SeekOrigin"), 
		};
		if (num < 0)
		{
			throw new IOException("Attempted to Seek before the beginning of the stream");
		}
		if (num < append_startpos)
		{
			throw new IOException("Can't seek back over pre-existing data in append mode");
		}
		FlushBuffer();
		buf_start = MonoIO.Seek(safeHandle, num, SeekOrigin.Begin, out var error);
		if (error != MonoIOError.ERROR_SUCCESS)
		{
			throw MonoIO.GetException(GetSecureFileName(name), error);
		}
		return buf_start;
	}

	public override void SetLength(long value)
	{
		if (safeHandle.IsClosed)
		{
			throw new ObjectDisposedException("Stream has been closed");
		}
		if (!CanSeek)
		{
			throw new NotSupportedException("The stream does not support seeking");
		}
		if (!CanWrite)
		{
			throw new NotSupportedException("The stream does not support writing");
		}
		if (value < 0)
		{
			throw new ArgumentOutOfRangeException("value is less than 0");
		}
		FlushBuffer();
		MonoIO.SetLength(safeHandle, value, out var error);
		if (error != MonoIOError.ERROR_SUCCESS)
		{
			throw MonoIO.GetException(GetSecureFileName(name), error);
		}
		if (Position > value)
		{
			Position = value;
		}
	}

	public override void Flush()
	{
		if (safeHandle.IsClosed)
		{
			throw new ObjectDisposedException("Stream has been closed");
		}
		FlushBuffer();
	}

	public virtual void Flush(bool flushToDisk)
	{
		if (safeHandle.IsClosed)
		{
			throw new ObjectDisposedException("Stream has been closed");
		}
		FlushBuffer();
		if (flushToDisk)
		{
			MonoIO.Flush(safeHandle, out var _);
		}
	}

	public virtual void Lock(long position, long length)
	{
		if (safeHandle.IsClosed)
		{
			throw new ObjectDisposedException("Stream has been closed");
		}
		if (position < 0)
		{
			throw new ArgumentOutOfRangeException("position must not be negative");
		}
		if (length < 0)
		{
			throw new ArgumentOutOfRangeException("length must not be negative");
		}
		MonoIO.Lock(safeHandle, position, length, out var error);
		if (error != MonoIOError.ERROR_SUCCESS)
		{
			throw MonoIO.GetException(GetSecureFileName(name), error);
		}
	}

	public virtual void Unlock(long position, long length)
	{
		if (safeHandle.IsClosed)
		{
			throw new ObjectDisposedException("Stream has been closed");
		}
		if (position < 0)
		{
			throw new ArgumentOutOfRangeException("position must not be negative");
		}
		if (length < 0)
		{
			throw new ArgumentOutOfRangeException("length must not be negative");
		}
		MonoIO.Unlock(safeHandle, position, length, out var error);
		if (error != MonoIOError.ERROR_SUCCESS)
		{
			throw MonoIO.GetException(GetSecureFileName(name), error);
		}
	}

	~FileStream()
	{
		Dispose(disposing: false);
	}

	protected override void Dispose(bool disposing)
	{
		Exception ex = null;
		if (safeHandle != null && !safeHandle.IsClosed)
		{
			try
			{
				FlushBuffer();
			}
			catch (Exception ex2)
			{
				ex = ex2;
			}
			if (owner)
			{
				MonoIO.Close(safeHandle.DangerousGetHandle(), out var error);
				if (error != MonoIOError.ERROR_SUCCESS)
				{
					throw MonoIO.GetException(GetSecureFileName(name), error);
				}
				safeHandle.DangerousRelease();
			}
		}
		canseek = false;
		access = (FileAccess)0;
		if (disposing && buf != null)
		{
			if (buf.Length == 4096 && buf_recycle == null)
			{
				lock (buf_recycle_lock)
				{
					if (buf_recycle == null)
					{
						buf_recycle = buf;
					}
				}
			}
			buf = null;
			GC.SuppressFinalize(this);
		}
		if (ex != null)
		{
			throw ex;
		}
	}

	public FileSecurity GetAccessControl()
	{
		if (safeHandle.IsClosed)
		{
			throw new ObjectDisposedException("Stream has been closed");
		}
		return new FileSecurity(SafeFileHandle, AccessControlSections.Access | AccessControlSections.Owner | AccessControlSections.Group);
	}

	public void SetAccessControl(FileSecurity fileSecurity)
	{
		if (safeHandle.IsClosed)
		{
			throw new ObjectDisposedException("Stream has been closed");
		}
		if (fileSecurity == null)
		{
			throw new ArgumentNullException("fileSecurity");
		}
		fileSecurity.PersistModifications(SafeFileHandle);
	}

	public override Task FlushAsync(CancellationToken cancellationToken)
	{
		if (safeHandle.IsClosed)
		{
			throw new ObjectDisposedException("Stream has been closed");
		}
		return base.FlushAsync(cancellationToken);
	}

	public override Task<int> ReadAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
	{
		return base.ReadAsync(buffer, offset, count, cancellationToken);
	}

	public override Task WriteAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
	{
		return base.WriteAsync(buffer, offset, count, cancellationToken);
	}

	private int ReadSegment(byte[] dest, int dest_offset, int count)
	{
		count = Math.Min(count, buf_length - buf_offset);
		if (count > 0)
		{
			Buffer.InternalBlockCopy(buf, buf_offset, dest, dest_offset, count);
			buf_offset += count;
		}
		return count;
	}

	private int WriteSegment(byte[] src, int src_offset, int count)
	{
		if (count > buf_size - buf_offset)
		{
			count = buf_size - buf_offset;
		}
		if (count > 0)
		{
			Buffer.BlockCopy(src, src_offset, buf, buf_offset, count);
			buf_offset += count;
			if (buf_offset > buf_length)
			{
				buf_length = buf_offset;
			}
			buf_dirty = true;
		}
		return count;
	}

	private void FlushBuffer()
	{
		if (buf_dirty)
		{
			MonoIOError error;
			if (CanSeek && !isExposed)
			{
				MonoIO.Seek(safeHandle, buf_start, SeekOrigin.Begin, out error);
				if (error != MonoIOError.ERROR_SUCCESS)
				{
					throw MonoIO.GetException(GetSecureFileName(name), error);
				}
			}
			int num = buf_length;
			int num2 = 0;
			while (num > 0)
			{
				int num3 = MonoIO.Write(safeHandle, buf, num2, buf_length, out error);
				if (error != MonoIOError.ERROR_SUCCESS)
				{
					throw MonoIO.GetException(GetSecureFileName(name), error);
				}
				num -= num3;
				num2 += num3;
			}
		}
		buf_start += buf_offset;
		buf_offset = (buf_length = 0);
		buf_dirty = false;
	}

	private void FlushBufferIfDirty()
	{
		if (buf_dirty)
		{
			FlushBuffer();
		}
	}

	private void RefillBuffer()
	{
		FlushBuffer();
		buf_length = ReadData(safeHandle, buf, 0, buf_size);
	}

	private int ReadData(SafeHandle safeHandle, byte[] buf, int offset, int count)
	{
		int num = 0;
		num = MonoIO.Read(safeHandle, buf, offset, count, out var error);
		switch (error)
		{
		case MonoIOError.ERROR_BROKEN_PIPE:
			num = 0;
			break;
		default:
			throw MonoIO.GetException(GetSecureFileName(name), error);
		case MonoIOError.ERROR_SUCCESS:
			break;
		}
		if (num == -1)
		{
			throw new IOException();
		}
		return num;
	}

	private void InitBuffer(int size, bool isZeroSize)
	{
		if (isZeroSize)
		{
			size = 0;
			buf = new byte[1];
		}
		else
		{
			if (size <= 0)
			{
				throw new ArgumentOutOfRangeException("bufferSize", "Positive number required.");
			}
			size = Math.Max(size, 8);
			if (size <= 4096 && buf_recycle != null)
			{
				lock (buf_recycle_lock)
				{
					if (buf_recycle != null)
					{
						buf = buf_recycle;
						buf_recycle = null;
					}
				}
			}
			if (buf == null)
			{
				buf = new byte[size];
			}
			else
			{
				Array.Clear(buf, 0, size);
			}
		}
		buf_size = size;
	}

	private string GetSecureFileName(string filename)
	{
		if (!anonymous)
		{
			return Path.GetFullPath(filename);
		}
		return Path.GetFileName(filename);
	}

	private string GetSecureFileName(string filename, bool full)
	{
		if (!anonymous)
		{
			if (!full)
			{
				return filename;
			}
			return Path.GetFullPath(filename);
		}
		return Path.GetFileName(filename);
	}
}
