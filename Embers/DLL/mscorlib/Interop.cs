using System;
using System.Buffers;
using System.IO;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using Microsoft.Win32.SafeHandles;

internal static class Interop
{
	internal enum Error
	{
		SUCCESS = 0,
		E2BIG = 65537,
		EACCES = 65538,
		EADDRINUSE = 65539,
		EADDRNOTAVAIL = 65540,
		EAFNOSUPPORT = 65541,
		EAGAIN = 65542,
		EALREADY = 65543,
		EBADF = 65544,
		EBADMSG = 65545,
		EBUSY = 65546,
		ECANCELED = 65547,
		ECHILD = 65548,
		ECONNABORTED = 65549,
		ECONNREFUSED = 65550,
		ECONNRESET = 65551,
		EDEADLK = 65552,
		EDESTADDRREQ = 65553,
		EDOM = 65554,
		EDQUOT = 65555,
		EEXIST = 65556,
		EFAULT = 65557,
		EFBIG = 65558,
		EHOSTUNREACH = 65559,
		EIDRM = 65560,
		EILSEQ = 65561,
		EINPROGRESS = 65562,
		EINTR = 65563,
		EINVAL = 65564,
		EIO = 65565,
		EISCONN = 65566,
		EISDIR = 65567,
		ELOOP = 65568,
		EMFILE = 65569,
		EMLINK = 65570,
		EMSGSIZE = 65571,
		EMULTIHOP = 65572,
		ENAMETOOLONG = 65573,
		ENETDOWN = 65574,
		ENETRESET = 65575,
		ENETUNREACH = 65576,
		ENFILE = 65577,
		ENOBUFS = 65578,
		ENODEV = 65580,
		ENOENT = 65581,
		ENOEXEC = 65582,
		ENOLCK = 65583,
		ENOLINK = 65584,
		ENOMEM = 65585,
		ENOMSG = 65586,
		ENOPROTOOPT = 65587,
		ENOSPC = 65588,
		ENOSYS = 65591,
		ENOTCONN = 65592,
		ENOTDIR = 65593,
		ENOTEMPTY = 65594,
		ENOTSOCK = 65596,
		ENOTSUP = 65597,
		ENOTTY = 65598,
		ENXIO = 65599,
		EOVERFLOW = 65600,
		EPERM = 65602,
		EPIPE = 65603,
		EPROTO = 65604,
		EPROTONOSUPPORT = 65605,
		EPROTOTYPE = 65606,
		ERANGE = 65607,
		EROFS = 65608,
		ESPIPE = 65609,
		ESRCH = 65610,
		ESTALE = 65611,
		ETIMEDOUT = 65613,
		ETXTBSY = 65614,
		EXDEV = 65615,
		ESOCKTNOSUPPORT = 65630,
		EPFNOSUPPORT = 65632,
		ESHUTDOWN = 65644,
		EHOSTDOWN = 65648,
		ENODATA = 65649,
		EOPNOTSUPP = ENOTSUP,
		EWOULDBLOCK = EAGAIN
	}

	internal struct ErrorInfo
	{
		private Error _error;

		private int _rawErrno;

		internal Error Error => _error;

		internal int RawErrno
		{
			get
			{
				if (_rawErrno != -1)
				{
					return _rawErrno;
				}
				return _rawErrno = Sys.ConvertErrorPalToPlatform(_error);
			}
		}

		internal ErrorInfo(int errno)
		{
			_error = Sys.ConvertErrorPlatformToPal(errno);
			_rawErrno = errno;
		}

		internal ErrorInfo(Error error)
		{
			_error = error;
			_rawErrno = -1;
		}

		internal string GetErrorMessage()
		{
			return Sys.StrError(RawErrno);
		}

		public override string ToString()
		{
			return $"RawErrno: {RawErrno} Error: {Error} GetErrorMessage: {GetErrorMessage()}";
		}
	}

	internal static class Sys
	{
		internal enum NodeType
		{
			DT_UNKNOWN = 0,
			DT_FIFO = 1,
			DT_CHR = 2,
			DT_DIR = 4,
			DT_BLK = 6,
			DT_REG = 8,
			DT_LNK = 10,
			DT_SOCK = 12,
			DT_WHT = 14
		}

		internal struct DirectoryEntry
		{
			internal unsafe byte* Name;

			internal int NameLength;

			internal NodeType InodeType;

			internal unsafe ReadOnlySpan<char> GetName(Span<char> buffer)
			{
				ReadOnlySpan<byte> bytes = ((NameLength == -1) ? new ReadOnlySpan<byte>(Name, new ReadOnlySpan<byte>(Name, 256).IndexOf((byte)0)) : new ReadOnlySpan<byte>(Name, NameLength));
				int chars = Encoding.UTF8.GetChars(bytes, buffer);
				return buffer.Slice(0, chars);
			}
		}

		internal struct FileStatus
		{
			internal FileStatusFlags Flags;

			internal int Mode;

			internal uint Uid;

			internal uint Gid;

			internal long Size;

			internal long ATime;

			internal long ATimeNsec;

			internal long MTime;

			internal long MTimeNsec;

			internal long CTime;

			internal long CTimeNsec;

			internal long BirthTime;

			internal long BirthTimeNsec;

			internal long Dev;

			internal long Ino;

			internal uint UserFlags;
		}

		[Flags]
		internal enum FileStatusFlags
		{
			None = 0,
			HasBirthTime = 1
		}

		[Flags]
		internal enum Permissions
		{
			Mask = 0x1FF,
			S_IRWXU = 0x1C0,
			S_IRUSR = 0x100,
			S_IWUSR = 0x80,
			S_IXUSR = 0x40,
			S_IRWXG = 0x38,
			S_IRGRP = 0x20,
			S_IWGRP = 0x10,
			S_IXGRP = 8,
			S_IRWXO = 7,
			S_IROTH = 4,
			S_IWOTH = 2,
			S_IXOTH = 1
		}

		internal struct TimeValPair
		{
			internal long ASec;

			internal long AUSec;

			internal long MSec;

			internal long MUSec;
		}

		internal static readonly bool CanSetHiddenFlag = LChflagsCanSetHiddenFlag() != 0;

		internal static ErrorInfo GetLastErrorInfo()
		{
			return new ErrorInfo(Marshal.GetLastWin32Error());
		}

		internal unsafe static string StrError(int platformErrno)
		{
			int num = 1024;
			byte* ptr = stackalloc byte[(int)(uint)num];
			byte* ptr2 = StrErrorR(platformErrno, ptr, num);
			if (ptr2 == null)
			{
				ptr2 = ptr;
			}
			return Marshal.PtrToStringAnsi((IntPtr)ptr2);
		}

		[DllImport("System.Native", EntryPoint = "SystemNative_ConvertErrorPlatformToPal")]
		internal static extern Error ConvertErrorPlatformToPal(int platformErrno);

		[DllImport("System.Native", EntryPoint = "SystemNative_ConvertErrorPalToPlatform")]
		internal static extern int ConvertErrorPalToPlatform(Error error);

		[DllImport("System.Native", EntryPoint = "SystemNative_StrErrorR")]
		private unsafe static extern byte* StrErrorR(int platformErrno, byte* buffer, int bufferSize);

		[DllImport("System.Native", EntryPoint = "SystemNative_GetNonCryptographicallySecureRandomBytes")]
		internal unsafe static extern void GetNonCryptographicallySecureRandomBytes(byte* buffer, int length);

		[DllImport("System.Native", EntryPoint = "SystemNative_OpenDir", SetLastError = true)]
		internal static extern IntPtr OpenDir(string path);

		[DllImport("System.Native", EntryPoint = "SystemNative_GetReadDirRBufferSize")]
		internal static extern int GetReadDirRBufferSize();

		[DllImport("System.Native", EntryPoint = "SystemNative_ReadDirR")]
		internal unsafe static extern int ReadDirR(IntPtr dir, byte* buffer, int bufferSize, out DirectoryEntry outputEntry);

		[DllImport("System.Native", EntryPoint = "SystemNative_CloseDir", SetLastError = true)]
		internal static extern int CloseDir(IntPtr dir);

		[DllImport("System.Native", EntryPoint = "SystemNative_ReadLink", SetLastError = true)]
		private static extern int ReadLink(string path, byte[] buffer, int bufferSize);

		public static string ReadLink(string path)
		{
			int num = 256;
			while (true)
			{
				byte[] array = ArrayPool<byte>.Shared.Rent(num);
				try
				{
					int num2 = ReadLink(path, array, array.Length);
					if (num2 < 0)
					{
						return null;
					}
					if (num2 < array.Length)
					{
						return Encoding.UTF8.GetString(array, 0, num2);
					}
				}
				finally
				{
					ArrayPool<byte>.Shared.Return(array);
				}
				num *= 2;
			}
		}

		[DllImport("System.Native", EntryPoint = "SystemNative_Stat2", SetLastError = true)]
		internal static extern int Stat(string path, out FileStatus output);

		[DllImport("System.Native", EntryPoint = "SystemNative_LStat2", SetLastError = true)]
		internal static extern int LStat(string path, out FileStatus output);

		[DllImport("System.Native", EntryPoint = "SystemNative_Symlink", SetLastError = true)]
		internal static extern int Symlink(string target, string linkPath);

		[DllImport("System.Native", EntryPoint = "SystemNative_ChMod", SetLastError = true)]
		internal static extern int ChMod(string path, int mode);

		[DllImport("System.Native", EntryPoint = "SystemNative_CopyFile", SetLastError = true)]
		internal static extern int CopyFile(SafeFileHandle source, SafeFileHandle destination);

		[DllImport("System.Native", EntryPoint = "SystemNative_GetEGid")]
		internal static extern uint GetEGid();

		[DllImport("System.Native", EntryPoint = "SystemNative_GetEUid")]
		internal static extern uint GetEUid();

		[DllImport("System.Native", EntryPoint = "SystemNative_LChflags", SetLastError = true)]
		internal static extern int LChflags(string path, uint flags);

		[DllImport("System.Native", EntryPoint = "SystemNative_LChflagsCanSetHiddenFlag")]
		private static extern int LChflagsCanSetHiddenFlag();

		[DllImport("System.Native", EntryPoint = "SystemNative_Link", SetLastError = true)]
		internal static extern int Link(string source, string link);

		[DllImport("System.Native", EntryPoint = "SystemNative_MkDir", SetLastError = true)]
		internal static extern int MkDir(string path, int mode);

		[DllImport("System.Native", EntryPoint = "SystemNative_Rename", SetLastError = true)]
		internal static extern int Rename(string oldPath, string newPath);

		[DllImport("System.Native", EntryPoint = "SystemNative_RmDir", SetLastError = true)]
		internal static extern int RmDir(string path);

		[DllImport("System.Native", EntryPoint = "SystemNative_Stat2", SetLastError = true)]
		internal static extern int Stat(ref byte path, out FileStatus output);

		internal unsafe static int Stat(ReadOnlySpan<char> path, out FileStatus output)
		{
			byte* pointer = stackalloc byte[256];
			ValueUtf8Converter valueUtf8Converter = new ValueUtf8Converter(new Span<byte>(pointer, 256));
			int result = Stat(ref MemoryMarshal.GetReference(valueUtf8Converter.ConvertAndTerminateString(path)), out output);
			valueUtf8Converter.Dispose();
			return result;
		}

		[DllImport("System.Native", EntryPoint = "SystemNative_LStat2", SetLastError = true)]
		internal static extern int LStat(ref byte path, out FileStatus output);

		internal unsafe static int LStat(ReadOnlySpan<char> path, out FileStatus output)
		{
			byte* pointer = stackalloc byte[256];
			ValueUtf8Converter valueUtf8Converter = new ValueUtf8Converter(new Span<byte>(pointer, 256));
			int result = LStat(ref MemoryMarshal.GetReference(valueUtf8Converter.ConvertAndTerminateString(path)), out output);
			valueUtf8Converter.Dispose();
			return result;
		}

		[DllImport("System.Native", EntryPoint = "SystemNative_UTimes", SetLastError = true)]
		internal static extern int UTimes(string path, ref TimeValPair times);

		[DllImport("System.Native", EntryPoint = "SystemNative_Unlink", SetLastError = true)]
		internal static extern int Unlink(string pathname);

		[MethodImpl((MethodImplOptions)4096)]
		internal unsafe static extern int DoubleToString(double value, byte* format, byte* buffer, int bufferLength);
	}

	private static void ThrowExceptionForIoErrno(ErrorInfo errorInfo, string path, bool isDirectory, Func<ErrorInfo, ErrorInfo> errorRewriter)
	{
		if (errorRewriter != null)
		{
			errorInfo = errorRewriter(errorInfo);
		}
		throw GetExceptionForIoErrno(errorInfo, path, isDirectory);
	}

	internal static long CheckIo(long result, string path = null, bool isDirectory = false, Func<ErrorInfo, ErrorInfo> errorRewriter = null)
	{
		if (result < 0)
		{
			ThrowExceptionForIoErrno(Sys.GetLastErrorInfo(), path, isDirectory, errorRewriter);
		}
		return result;
	}

	internal static int CheckIo(int result, string path = null, bool isDirectory = false, Func<ErrorInfo, ErrorInfo> errorRewriter = null)
	{
		CheckIo((long)result, path, isDirectory, errorRewriter);
		return result;
	}

	internal static Exception GetExceptionForIoErrno(ErrorInfo errorInfo, string path = null, bool isDirectory = false)
	{
		switch (errorInfo.Error)
		{
		case Error.ENOENT:
			if (isDirectory)
			{
				if (string.IsNullOrEmpty(path))
				{
					return new DirectoryNotFoundException("Could not find a part of the path.");
				}
				return new DirectoryNotFoundException(SR.Format("Could not find a part of the path '{0}'.", path));
			}
			if (string.IsNullOrEmpty(path))
			{
				return new FileNotFoundException("Unable to find the specified file.");
			}
			return new FileNotFoundException(SR.Format("Could not find file '{0}'.", path), path);
		case Error.EACCES:
		case Error.EBADF:
		case Error.EPERM:
		{
			Exception iOException = GetIOException(errorInfo);
			if (string.IsNullOrEmpty(path))
			{
				return new UnauthorizedAccessException("Access to the path is denied.", iOException);
			}
			return new UnauthorizedAccessException(SR.Format("Access to the path '{0}' is denied.", path), iOException);
		}
		case Error.ENAMETOOLONG:
			if (string.IsNullOrEmpty(path))
			{
				return new PathTooLongException("The specified file name or path is too long, or a component of the specified path is too long.");
			}
			return new PathTooLongException(SR.Format("The path '{0}' is too long, or a component of the specified path is too long.", path));
		case Error.EAGAIN:
			if (string.IsNullOrEmpty(path))
			{
				return new IOException("The process cannot access the file because it is being used by another process.", errorInfo.RawErrno);
			}
			return new IOException(SR.Format("The process cannot access the file '{0}' because it is being used by another process.", path), errorInfo.RawErrno);
		case Error.ECANCELED:
			return new OperationCanceledException();
		case Error.EFBIG:
			return new ArgumentOutOfRangeException("value", "Specified file length was too large for the file system.");
		case Error.EEXIST:
			if (!string.IsNullOrEmpty(path))
			{
				return new IOException(SR.Format("The file '{0}' already exists.", path), errorInfo.RawErrno);
			}
			break;
		}
		return GetIOException(errorInfo);
	}

	internal static Exception GetIOException(ErrorInfo errorInfo)
	{
		return new IOException(errorInfo.GetErrorMessage(), errorInfo.RawErrno);
	}

	internal unsafe static void GetRandomBytes(byte* buffer, int length)
	{
		Sys.GetNonCryptographicallySecureRandomBytes(buffer, length);
	}
}
