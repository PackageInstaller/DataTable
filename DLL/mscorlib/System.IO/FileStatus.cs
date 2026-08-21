namespace System.IO;

internal struct FileStatus
{
	private Interop.Sys.FileStatus _fileStatus;

	private int _fileStatusInitialized;

	internal bool _isDirectory;

	private bool _exists;

	internal bool InitiallyDirectory { get; private set; }

	internal static void Initialize(ref FileStatus status, bool isDirectory)
	{
		status.InitiallyDirectory = isDirectory;
		status._fileStatusInitialized = -1;
	}

	internal void Invalidate()
	{
		_fileStatusInitialized = -1;
	}

	internal bool IsReadOnly(ReadOnlySpan<char> path, bool continueOnError = false)
	{
		EnsureStatInitialized(path, continueOnError);
		Interop.Sys.Permissions permissions;
		Interop.Sys.Permissions permissions2;
		if (_fileStatus.Uid == Interop.Sys.GetEUid())
		{
			permissions = Interop.Sys.Permissions.S_IRUSR;
			permissions2 = Interop.Sys.Permissions.S_IWUSR;
		}
		else if (_fileStatus.Gid == Interop.Sys.GetEGid())
		{
			permissions = Interop.Sys.Permissions.S_IRGRP;
			permissions2 = Interop.Sys.Permissions.S_IWGRP;
		}
		else
		{
			permissions = Interop.Sys.Permissions.S_IROTH;
			permissions2 = Interop.Sys.Permissions.S_IWOTH;
		}
		if (((uint)_fileStatus.Mode & (uint)permissions) != 0)
		{
			return ((uint)_fileStatus.Mode & (uint)permissions2) == 0;
		}
		return false;
	}

	public FileAttributes GetAttributes(ReadOnlySpan<char> path, ReadOnlySpan<char> fileName)
	{
		EnsureStatInitialized(path);
		if (!_exists)
		{
			return (FileAttributes)(-1);
		}
		FileAttributes fileAttributes = (FileAttributes)0;
		if (IsReadOnly(path))
		{
			fileAttributes |= FileAttributes.ReadOnly;
		}
		if ((_fileStatus.Mode & 0xF000) == 40960)
		{
			fileAttributes |= FileAttributes.ReparsePoint;
		}
		if (_isDirectory)
		{
			fileAttributes |= FileAttributes.Directory;
		}
		if (fileName.Length > 0 && (fileName[0] == '.' || (_fileStatus.UserFlags & 0x8000) == 32768))
		{
			fileAttributes |= FileAttributes.Hidden;
		}
		if (fileAttributes == (FileAttributes)0)
		{
			return FileAttributes.Normal;
		}
		return fileAttributes;
	}

	public void SetAttributes(string path, FileAttributes attributes)
	{
		if ((attributes & ~(FileAttributes.ReadOnly | FileAttributes.Hidden | FileAttributes.System | FileAttributes.Directory | FileAttributes.Archive | FileAttributes.Device | FileAttributes.Normal | FileAttributes.Temporary | FileAttributes.SparseFile | FileAttributes.ReparsePoint | FileAttributes.Compressed | FileAttributes.Offline | FileAttributes.NotContentIndexed | FileAttributes.Encrypted | FileAttributes.IntegrityStream | FileAttributes.NoScrubData)) != 0)
		{
			throw new ArgumentException("Invalid File or Directory attributes value.", "Attributes");
		}
		EnsureStatInitialized(path);
		if (!_exists)
		{
			FileSystemInfo.ThrowNotFound(path);
		}
		if (Interop.Sys.CanSetHiddenFlag)
		{
			if ((attributes & FileAttributes.Hidden) != 0)
			{
				if ((_fileStatus.UserFlags & 0x8000) == 0)
				{
					Interop.CheckIo(Interop.Sys.LChflags(path, _fileStatus.UserFlags | 0x8000), path, InitiallyDirectory);
				}
			}
			else if ((_fileStatus.UserFlags & 0x8000) == 32768)
			{
				Interop.CheckIo(Interop.Sys.LChflags(path, _fileStatus.UserFlags & 0xFFFF7FFFu), path, InitiallyDirectory);
			}
		}
		int num = _fileStatus.Mode;
		if ((attributes & FileAttributes.ReadOnly) != 0)
		{
			num &= -147;
		}
		else if ((num & 0x100) != 0)
		{
			num |= 0x80;
		}
		if (num != _fileStatus.Mode)
		{
			Interop.CheckIo(Interop.Sys.ChMod(path, num), path, InitiallyDirectory);
		}
		_fileStatusInitialized = -1;
	}

	internal bool GetExists(ReadOnlySpan<char> path)
	{
		if (_fileStatusInitialized == -1)
		{
			Refresh(path);
		}
		if (_exists)
		{
			return InitiallyDirectory == _isDirectory;
		}
		return false;
	}

	internal DateTimeOffset GetCreationTime(ReadOnlySpan<char> path, bool continueOnError = false)
	{
		EnsureStatInitialized(path, continueOnError);
		if (!_exists)
		{
			return DateTimeOffset.FromFileTime(0L);
		}
		if ((_fileStatus.Flags & Interop.Sys.FileStatusFlags.HasBirthTime) != Interop.Sys.FileStatusFlags.None)
		{
			return UnixTimeToDateTimeOffset(_fileStatus.BirthTime, _fileStatus.BirthTimeNsec);
		}
		if (_fileStatus.MTime < _fileStatus.CTime || (_fileStatus.MTime == _fileStatus.CTime && _fileStatus.MTimeNsec < _fileStatus.CTimeNsec))
		{
			return UnixTimeToDateTimeOffset(_fileStatus.MTime, _fileStatus.MTimeNsec);
		}
		return UnixTimeToDateTimeOffset(_fileStatus.CTime, _fileStatus.CTimeNsec);
	}

	internal void SetCreationTime(string path, DateTimeOffset time)
	{
		SetLastAccessTime(path, time);
	}

	internal DateTimeOffset GetLastAccessTime(ReadOnlySpan<char> path, bool continueOnError = false)
	{
		EnsureStatInitialized(path, continueOnError);
		if (!_exists)
		{
			return DateTimeOffset.FromFileTime(0L);
		}
		return UnixTimeToDateTimeOffset(_fileStatus.ATime, _fileStatus.ATimeNsec);
	}

	internal void SetLastAccessTime(string path, DateTimeOffset time)
	{
		SetAccessWriteTimes(path, time.ToUnixTimeSeconds(), (time.Ticks - 621355968000000000L) % 10000000 / 10, null, null);
	}

	internal DateTimeOffset GetLastWriteTime(ReadOnlySpan<char> path, bool continueOnError = false)
	{
		EnsureStatInitialized(path, continueOnError);
		if (!_exists)
		{
			return DateTimeOffset.FromFileTime(0L);
		}
		return UnixTimeToDateTimeOffset(_fileStatus.MTime, _fileStatus.MTimeNsec);
	}

	internal void SetLastWriteTime(string path, DateTimeOffset time)
	{
		SetAccessWriteTimes(path, null, null, time.ToUnixTimeSeconds(), (time.Ticks - 621355968000000000L) % 10000000 / 10);
	}

	private DateTimeOffset UnixTimeToDateTimeOffset(long seconds, long nanoseconds)
	{
		return DateTimeOffset.FromUnixTimeSeconds(seconds).AddTicks(nanoseconds / 100).ToLocalTime();
	}

	private void SetAccessWriteTimes(string path, long? accessSec, long? accessUSec, long? writeSec, long? writeUSec)
	{
		_fileStatusInitialized = -1;
		EnsureStatInitialized(path);
		Interop.Sys.TimeValPair times = default(Interop.Sys.TimeValPair);
		times.ASec = accessSec ?? _fileStatus.ATime;
		times.AUSec = accessUSec ?? (_fileStatus.ATimeNsec / 1000);
		times.MSec = writeSec ?? _fileStatus.MTime;
		times.MUSec = writeUSec ?? (_fileStatus.MTimeNsec / 1000);
		Interop.CheckIo(Interop.Sys.UTimes(path, ref times), path, InitiallyDirectory);
		_fileStatusInitialized = -1;
	}

	internal long GetLength(ReadOnlySpan<char> path, bool continueOnError = false)
	{
		EnsureStatInitialized(path, continueOnError);
		return _fileStatus.Size;
	}

	public void Refresh(ReadOnlySpan<char> path)
	{
		_isDirectory = false;
		path = PathInternal.TrimEndingDirectorySeparator(path);
		if (Interop.Sys.LStat(path, out _fileStatus) < 0)
		{
			Interop.ErrorInfo lastErrorInfo = Interop.Sys.GetLastErrorInfo();
			if (lastErrorInfo.Error == Interop.Error.ENOENT || lastErrorInfo.Error == Interop.Error.ENOTDIR)
			{
				_fileStatusInitialized = 0;
				_exists = false;
			}
			else
			{
				_fileStatusInitialized = lastErrorInfo.RawErrno;
			}
			return;
		}
		_exists = true;
		_isDirectory = (_fileStatus.Mode & 0xF000) == 16384;
		if ((_fileStatus.Mode & 0xF000) == 40960 && Interop.Sys.Stat(path, out var output) >= 0)
		{
			_isDirectory = (output.Mode & 0xF000) == 16384;
		}
		_fileStatusInitialized = 0;
	}

	internal void EnsureStatInitialized(ReadOnlySpan<char> path, bool continueOnError = false)
	{
		if (_fileStatusInitialized == -1)
		{
			Refresh(path);
		}
		if (_fileStatusInitialized != 0 && !continueOnError)
		{
			int fileStatusInitialized = _fileStatusInitialized;
			_fileStatusInitialized = -1;
			throw Interop.GetExceptionForIoErrno(new Interop.ErrorInfo(fileStatusInitialized), new string(path));
		}
	}
}
