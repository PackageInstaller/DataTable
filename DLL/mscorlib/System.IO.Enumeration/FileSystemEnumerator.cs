using System.Buffers;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.ConstrainedExecution;
using System.Threading;

namespace System.IO.Enumeration;

public abstract class FileSystemEnumerator<TResult> : CriticalFinalizerObject, IEnumerator<TResult>, IDisposable, IEnumerator
{
	private readonly string _originalRootDirectory;

	private readonly string _rootDirectory;

	private readonly EnumerationOptions _options;

	private readonly object _lock = new object();

	private string _currentPath;

	private IntPtr _directoryHandle;

	private bool _lastEntryFound;

	private Queue<string> _pending;

	private Interop.Sys.DirectoryEntry _entry;

	private TResult _current;

	private char[] _pathBuffer;

	private byte[] _entryBuffer;

	public TResult Current => _current;

	object IEnumerator.Current => Current;

	public FileSystemEnumerator(string directory, EnumerationOptions options = null)
	{
		_originalRootDirectory = directory ?? throw new ArgumentNullException("directory");
		_rootDirectory = PathInternal.TrimEndingDirectorySeparator(Path.GetFullPath(directory));
		_options = options ?? EnumerationOptions.Default;
		_directoryHandle = CreateDirectoryHandle(_rootDirectory);
		if (_directoryHandle == IntPtr.Zero)
		{
			_lastEntryFound = true;
		}
		_currentPath = _rootDirectory;
		try
		{
			_pathBuffer = ArrayPool<char>.Shared.Rent(4096);
			int readDirRBufferSize = Interop.Sys.GetReadDirRBufferSize();
			_entryBuffer = ((readDirRBufferSize > 0) ? ArrayPool<byte>.Shared.Rent(readDirRBufferSize) : null);
		}
		catch
		{
			CloseDirectoryHandle();
			throw;
		}
	}

	private bool InternalContinueOnError(Interop.ErrorInfo info, bool ignoreNotFound = false)
	{
		if ((!ignoreNotFound || !IsDirectoryNotFound(info)) && (!_options.IgnoreInaccessible || !IsAccessError(info)))
		{
			return ContinueOnError(info.RawErrno);
		}
		return true;
	}

	private static bool IsDirectoryNotFound(Interop.ErrorInfo info)
	{
		if (info.Error != Interop.Error.ENOTDIR)
		{
			return info.Error == Interop.Error.ENOENT;
		}
		return true;
	}

	private static bool IsAccessError(Interop.ErrorInfo info)
	{
		if (info.Error != Interop.Error.EACCES && info.Error != Interop.Error.EBADF)
		{
			return info.Error == Interop.Error.EPERM;
		}
		return true;
	}

	private IntPtr CreateDirectoryHandle(string path, bool ignoreNotFound = false)
	{
		IntPtr intPtr = Interop.Sys.OpenDir(path);
		if (intPtr == IntPtr.Zero)
		{
			Interop.ErrorInfo lastErrorInfo = Interop.Sys.GetLastErrorInfo();
			if (InternalContinueOnError(lastErrorInfo, ignoreNotFound))
			{
				return IntPtr.Zero;
			}
			throw Interop.GetExceptionForIoErrno(lastErrorInfo, path, isDirectory: true);
		}
		return intPtr;
	}

	private void CloseDirectoryHandle()
	{
		IntPtr intPtr = Interlocked.Exchange(ref _directoryHandle, IntPtr.Zero);
		if (intPtr != IntPtr.Zero)
		{
			Interop.Sys.CloseDir(intPtr);
		}
	}

	public unsafe bool MoveNext()
	{
		if (_lastEntryFound)
		{
			return false;
		}
		FileSystemEntry entry = default(FileSystemEntry);
		lock (_lock)
		{
			if (_lastEntryFound)
			{
				return false;
			}
			fixed (byte* entryBuffer = _entryBuffer)
			{
				do
				{
					IL_0054:
					FindNextEntry(entryBuffer, (_entryBuffer != null) ? _entryBuffer.Length : 0);
					if (_lastEntryFound)
					{
						return false;
					}
					FileAttributes fileAttributes = FileSystemEntry.Initialize(ref entry, _entry, _currentPath, _rootDirectory, _originalRootDirectory, new Span<char>(_pathBuffer));
					bool flag = (fileAttributes & FileAttributes.Directory) != 0;
					bool flag2 = false;
					if (flag && *_entry.Name == 46 && (_entry.Name[1] == 0 || (_entry.Name[1] == 46 && _entry.Name[2] == 0)))
					{
						if (!_options.ReturnSpecialDirectories)
						{
							goto IL_0054;
						}
						flag2 = true;
					}
					if (!flag2 && _options.AttributesToSkip != 0)
					{
						if ((_options.AttributesToSkip & FileAttributes.ReadOnly) != 0)
						{
							fileAttributes = entry.Attributes;
						}
						if ((_options.AttributesToSkip & fileAttributes) != 0)
						{
							goto IL_0054;
						}
					}
					if (flag && !flag2 && _options.RecurseSubdirectories && ShouldRecurseIntoEntry(ref entry))
					{
						if (_pending == null)
						{
							_pending = new Queue<string>();
						}
						_pending.Enqueue(Path.Join(_currentPath, entry.FileName));
					}
				}
				while (!ShouldIncludeEntry(ref entry));
				_current = TransformEntry(ref entry);
				return true;
			}
		}
	}

	private unsafe void FindNextEntry()
	{
		fixed (byte* entryBuffer = _entryBuffer)
		{
			FindNextEntry(entryBuffer, (_entryBuffer != null) ? _entryBuffer.Length : 0);
		}
	}

	private unsafe void FindNextEntry(byte* entryBufferPtr, int bufferLength)
	{
		int num = Interop.Sys.ReadDirR(_directoryHandle, entryBufferPtr, bufferLength, out _entry);
		switch (num)
		{
		case -1:
			DirectoryFinished();
			return;
		case 0:
			return;
		}
		if (InternalContinueOnError(new Interop.ErrorInfo(num)))
		{
			DirectoryFinished();
			return;
		}
		throw Interop.GetExceptionForIoErrno(new Interop.ErrorInfo(num), _currentPath, isDirectory: true);
	}

	private bool DequeueNextDirectory()
	{
		_directoryHandle = IntPtr.Zero;
		while (_directoryHandle == IntPtr.Zero)
		{
			if (_pending == null || _pending.Count == 0)
			{
				return false;
			}
			_currentPath = _pending.Dequeue();
			_directoryHandle = CreateDirectoryHandle(_currentPath, ignoreNotFound: true);
		}
		return true;
	}

	private void InternalDispose(bool disposing)
	{
		if (_lock != null)
		{
			lock (_lock)
			{
				_lastEntryFound = true;
				_pending = null;
				CloseDirectoryHandle();
				if (_pathBuffer != null)
				{
					ArrayPool<char>.Shared.Return(_pathBuffer);
				}
				_pathBuffer = null;
				if (_entryBuffer != null)
				{
					ArrayPool<byte>.Shared.Return(_entryBuffer);
				}
				_entryBuffer = null;
			}
		}
		Dispose(disposing);
	}

	protected virtual bool ShouldIncludeEntry(ref FileSystemEntry entry)
	{
		return true;
	}

	protected virtual bool ShouldRecurseIntoEntry(ref FileSystemEntry entry)
	{
		return true;
	}

	protected abstract TResult TransformEntry(ref FileSystemEntry entry);

	protected virtual void OnDirectoryFinished(ReadOnlySpan<char> directory)
	{
	}

	protected virtual bool ContinueOnError(int error)
	{
		return false;
	}

	private void DirectoryFinished()
	{
		_entry = default(Interop.Sys.DirectoryEntry);
		CloseDirectoryHandle();
		OnDirectoryFinished(_currentPath);
		if (!DequeueNextDirectory())
		{
			_lastEntryFound = true;
		}
		else
		{
			FindNextEntry();
		}
	}

	public void Reset()
	{
		throw new NotSupportedException();
	}

	public void Dispose()
	{
		InternalDispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
	}

	~FileSystemEnumerator()
	{
		InternalDispose(disposing: false);
	}
}
