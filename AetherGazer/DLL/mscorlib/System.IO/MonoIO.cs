using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System.IO;

internal static class MonoIO
{
	public static readonly IntPtr InvalidHandle = (IntPtr)(-1L);

	private static bool dump_handles = Environment.GetEnvironmentVariable("MONO_DUMP_HANDLES_ON_ERROR_TOO_MANY_OPEN_FILES") != null;

	public static extern IntPtr ConsoleOutput
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern IntPtr ConsoleInput
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern IntPtr ConsoleError
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern char VolumeSeparatorChar
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern char DirectorySeparatorChar
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern char AltDirectorySeparatorChar
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern char PathSeparator
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static Exception GetException(MonoIOError error)
	{
		return error switch
		{
			MonoIOError.ERROR_ACCESS_DENIED => new UnauthorizedAccessException("Access to the path is denied."), 
			MonoIOError.ERROR_FILE_EXISTS => new IOException("Cannot create a file that already exist.", -2147024816), 
			_ => GetException(string.Empty, error), 
		};
	}

	public static Exception GetException(string path, MonoIOError error)
	{
		switch (error)
		{
		case MonoIOError.ERROR_FILE_NOT_FOUND:
			return new FileNotFoundException($"Could not find file \"{path}\"", path);
		case MonoIOError.ERROR_TOO_MANY_OPEN_FILES:
			if (dump_handles)
			{
				DumpHandles();
			}
			return new IOException("Too many open files", (int)((MonoIOError)(-2147024896) | error));
		case MonoIOError.ERROR_PATH_NOT_FOUND:
			return new DirectoryNotFoundException($"Could not find a part of the path \"{path}\"");
		case MonoIOError.ERROR_ACCESS_DENIED:
			return new UnauthorizedAccessException($"Access to the path \"{path}\" is denied.");
		case MonoIOError.ERROR_INVALID_HANDLE:
			return new IOException($"Invalid handle to path \"{path}\"", (int)((MonoIOError)(-2147024896) | error));
		case MonoIOError.ERROR_INVALID_DRIVE:
			return new IOException($"Could not find the drive  '{path}'. The drive might not be ready or might not be mapped.", (int)((MonoIOError)(-2147024896) | error));
		case MonoIOError.ERROR_FILE_EXISTS:
			return new IOException($"Could not create file \"{path}\". File already exists.", (int)((MonoIOError)(-2147024896) | error));
		case MonoIOError.ERROR_FILENAME_EXCED_RANGE:
			return new PathTooLongException($"Path is too long. Path: {path}");
		case MonoIOError.ERROR_INVALID_PARAMETER:
			return new IOException($"Invalid parameter", (int)((MonoIOError)(-2147024896) | error));
		case MonoIOError.ERROR_WRITE_FAULT:
			return new IOException($"Write fault on path {path}", (int)((MonoIOError)(-2147024896) | error));
		case MonoIOError.ERROR_SHARING_VIOLATION:
			return new IOException($"Sharing violation on path {path}", (int)((MonoIOError)(-2147024896) | error));
		case MonoIOError.ERROR_LOCK_VIOLATION:
			return new IOException($"Lock violation on path {path}", (int)((MonoIOError)(-2147024896) | error));
		case MonoIOError.ERROR_HANDLE_DISK_FULL:
			return new IOException($"Disk full. Path {path}", (int)((MonoIOError)(-2147024896) | error));
		case MonoIOError.ERROR_DIR_NOT_EMPTY:
			return new IOException($"Directory {path} is not empty", (int)((MonoIOError)(-2147024896) | error));
		case MonoIOError.ERROR_ENCRYPTION_FAILED:
			return new IOException("Encryption failed", (int)((MonoIOError)(-2147024896) | error));
		case MonoIOError.ERROR_CANNOT_MAKE:
			return new IOException($"Path {path} is a directory", (int)((MonoIOError)(-2147024896) | error));
		case MonoIOError.ERROR_NOT_SAME_DEVICE:
			return new IOException("Source and destination are not on the same device", (int)((MonoIOError)(-2147024896) | error));
		case MonoIOError.ERROR_DIRECTORY:
			return new IOException("The directory name is invalid", (int)((MonoIOError)(-2147024896) | error));
		default:
			return new IOException($"Win32 IO returned {error}. Path: {path}", (int)((MonoIOError)(-2147024896) | error));
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern string GetCurrentDirectory(out MonoIOError error);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern bool SetCurrentDirectory(char* path, out MonoIOError error);

	public unsafe static bool SetCurrentDirectory(string path, out MonoIOError error)
	{
		fixed (char* path2 = path)
		{
			return SetCurrentDirectory(path2, out error);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern bool SetFileAttributes(char* path, FileAttributes attrs, out MonoIOError error);

	public unsafe static bool SetFileAttributes(string path, FileAttributes attrs, out MonoIOError error)
	{
		fixed (char* path2 = path)
		{
			return SetFileAttributes(path2, attrs, out error);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern MonoFileType GetFileType(IntPtr handle, out MonoIOError error);

	public static MonoFileType GetFileType(SafeHandle safeHandle, out MonoIOError error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			return GetFileType(safeHandle.DangerousGetHandle(), out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern bool FindCloseFile(IntPtr hnd);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern IntPtr Open(char* filename, FileMode mode, FileAccess access, FileShare share, FileOptions options, out MonoIOError error);

	public unsafe static IntPtr Open(string filename, FileMode mode, FileAccess access, FileShare share, FileOptions options, out MonoIOError error)
	{
		fixed (char* filename2 = filename)
		{
			return Open(filename2, mode, access, share, options, out error);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool Cancel_internal(IntPtr handle, out MonoIOError error);

	internal static bool Cancel(SafeHandle safeHandle, out MonoIOError error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			return Cancel_internal(safeHandle.DangerousGetHandle(), out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern bool Close(IntPtr handle, out MonoIOError error);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int Read(IntPtr handle, byte[] dest, int dest_offset, int count, out MonoIOError error);

	public static int Read(SafeHandle safeHandle, byte[] dest, int dest_offset, int count, out MonoIOError error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			return Read(safeHandle.DangerousGetHandle(), dest, dest_offset, count, out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int Write(IntPtr handle, [In] byte[] src, int src_offset, int count, out MonoIOError error);

	public static int Write(SafeHandle safeHandle, byte[] src, int src_offset, int count, out MonoIOError error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			return Write(safeHandle.DangerousGetHandle(), src, src_offset, count, out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern long Seek(IntPtr handle, long offset, SeekOrigin origin, out MonoIOError error);

	public static long Seek(SafeHandle safeHandle, long offset, SeekOrigin origin, out MonoIOError error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			return Seek(safeHandle.DangerousGetHandle(), offset, origin, out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool Flush(IntPtr handle, out MonoIOError error);

	public static bool Flush(SafeHandle safeHandle, out MonoIOError error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			return Flush(safeHandle.DangerousGetHandle(), out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern long GetLength(IntPtr handle, out MonoIOError error);

	public static long GetLength(SafeHandle safeHandle, out MonoIOError error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			return GetLength(safeHandle.DangerousGetHandle(), out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool SetLength(IntPtr handle, long length, out MonoIOError error);

	public static bool SetLength(SafeHandle safeHandle, long length, out MonoIOError error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			return SetLength(safeHandle.DangerousGetHandle(), length, out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Lock(IntPtr handle, long position, long length, out MonoIOError error);

	public static void Lock(SafeHandle safeHandle, long position, long length, out MonoIOError error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			Lock(safeHandle.DangerousGetHandle(), position, length, out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Unlock(IntPtr handle, long position, long length, out MonoIOError error);

	public static void Unlock(SafeHandle safeHandle, long position, long length, out MonoIOError error)
	{
		bool success = false;
		try
		{
			safeHandle.DangerousAddRef(ref success);
			Unlock(safeHandle.DangerousGetHandle(), position, length, out error);
		}
		finally
		{
			if (success)
			{
				safeHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern bool CreatePipe(out IntPtr read_handle, out IntPtr write_handle, out MonoIOError error);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern bool DuplicateHandle(IntPtr source_process_handle, IntPtr source_handle, IntPtr target_process_handle, out IntPtr target_handle, int access, int inherit, int options, out MonoIOError error);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DumpHandles();

	[MethodImpl((MethodImplOptions)4096)]
	public static extern bool RemapPath(string path, out string newPath);
}
