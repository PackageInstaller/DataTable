using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.IO;

[Serializable]
public abstract class FileSystemInfo : MarshalByRefObject, ISerializable
{
	private FileStatus _fileStatus;

	protected string FullPath;

	protected string OriginalPath;

	internal string _name;

	public FileAttributes Attributes
	{
		get
		{
			return _fileStatus.GetAttributes(FullPath, Name);
		}
		set
		{
			_fileStatus.SetAttributes(FullPath, value);
		}
	}

	internal bool ExistsCore => _fileStatus.GetExists(FullPath);

	internal DateTimeOffset CreationTimeCore
	{
		get
		{
			return _fileStatus.GetCreationTime(FullPath);
		}
		set
		{
			_fileStatus.SetCreationTime(FullPath, value);
		}
	}

	internal DateTimeOffset LastAccessTimeCore
	{
		get
		{
			return _fileStatus.GetLastAccessTime(FullPath);
		}
		set
		{
			_fileStatus.SetLastAccessTime(FullPath, value);
		}
	}

	internal DateTimeOffset LastWriteTimeCore
	{
		get
		{
			return _fileStatus.GetLastWriteTime(FullPath);
		}
		set
		{
			_fileStatus.SetLastWriteTime(FullPath, value);
		}
	}

	internal long LengthCore => _fileStatus.GetLength(FullPath);

	internal string NormalizedPath => FullPath;

	public virtual string FullName => FullPath;

	public string Extension
	{
		get
		{
			int length = FullPath.Length;
			int num = length;
			while (--num >= 0)
			{
				char c = FullPath[num];
				if (c == '.')
				{
					return FullPath.Substring(num, length - num);
				}
				if (PathInternal.IsDirectorySeparator(c) || c == Path.VolumeSeparatorChar)
				{
					break;
				}
			}
			return string.Empty;
		}
	}

	public virtual string Name => _name;

	public virtual bool Exists
	{
		get
		{
			try
			{
				return ExistsCore;
			}
			catch
			{
				return false;
			}
		}
	}

	public DateTime CreationTime
	{
		get
		{
			return CreationTimeUtc.ToLocalTime();
		}
		set
		{
			CreationTimeUtc = value.ToUniversalTime();
		}
	}

	public DateTime CreationTimeUtc
	{
		get
		{
			return CreationTimeCore.UtcDateTime;
		}
		set
		{
			CreationTimeCore = File.GetUtcDateTimeOffset(value);
		}
	}

	public DateTime LastAccessTime
	{
		get
		{
			return LastAccessTimeUtc.ToLocalTime();
		}
		set
		{
			LastAccessTimeUtc = value.ToUniversalTime();
		}
	}

	public DateTime LastAccessTimeUtc
	{
		get
		{
			return LastAccessTimeCore.UtcDateTime;
		}
		set
		{
			LastAccessTimeCore = File.GetUtcDateTimeOffset(value);
		}
	}

	public DateTime LastWriteTime
	{
		get
		{
			return LastWriteTimeUtc.ToLocalTime();
		}
		set
		{
			LastWriteTimeUtc = value.ToUniversalTime();
		}
	}

	public DateTime LastWriteTimeUtc
	{
		get
		{
			return LastWriteTimeCore.UtcDateTime;
		}
		set
		{
			LastWriteTimeCore = File.GetUtcDateTimeOffset(value);
		}
	}

	protected FileSystemInfo()
	{
		FileStatus.Initialize(ref _fileStatus, this is DirectoryInfo);
	}

	internal static FileSystemInfo Create(string fullPath, string fileName, ref FileStatus fileStatus)
	{
		FileSystemInfo obj = (fileStatus.InitiallyDirectory ? ((FileSystemInfo)new DirectoryInfo(fullPath, null, fileName, isNormalized: true)) : ((FileSystemInfo)new FileInfo(fullPath, null, fileName, isNormalized: true)));
		obj.Init(ref fileStatus);
		return obj;
	}

	internal void Invalidate()
	{
		_fileStatus.Invalidate();
	}

	internal void Init(ref FileStatus fileStatus)
	{
		_fileStatus = fileStatus;
		_fileStatus.EnsureStatInitialized(FullPath);
	}

	public void Refresh()
	{
		_fileStatus.Refresh(FullPath);
	}

	internal static void ThrowNotFound(string path)
	{
		bool isDirectory = !Directory.Exists(Path.GetDirectoryName(PathInternal.TrimEndingDirectorySeparator(path)));
		throw Interop.GetExceptionForIoErrno(new Interop.ErrorInfo(Interop.Error.ENOENT), path, isDirectory);
	}

	protected FileSystemInfo(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		FullPath = Path.GetFullPathInternal(info.GetString("FullPath"));
		OriginalPath = info.GetString("OriginalPath");
		_name = info.GetString("Name");
	}

	[ComVisible(false)]
	public virtual void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		info.AddValue("OriginalPath", OriginalPath, typeof(string));
		info.AddValue("FullPath", FullPath, typeof(string));
		info.AddValue("Name", Name, typeof(string));
	}

	public abstract void Delete();

	public override string ToString()
	{
		return OriginalPath ?? string.Empty;
	}
}
