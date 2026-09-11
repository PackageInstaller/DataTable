using System;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;
using Microsoft.Win32.SafeHandles;

internal static class Interop
{
	internal static class Kernel32
	{
		[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
		internal struct WIN32_FIND_DATA
		{
			internal uint dwFileAttributes;

			internal FILE_TIME ftCreationTime;

			internal FILE_TIME ftLastAccessTime;

			internal FILE_TIME ftLastWriteTime;

			internal uint nFileSizeHigh;

			internal uint nFileSizeLow;

			internal uint dwReserved0;

			internal uint dwReserved1;

			private unsafe fixed char _cFileName[260];

			private unsafe fixed char _cAlternateFileName[14];

			internal unsafe ReadOnlySpan<char> cFileName
			{
				get
				{
					fixed (char* pointer = _cFileName)
					{
						return new ReadOnlySpan<char>(pointer, 260);
					}
				}
			}

			internal unsafe void SetFileName(string fileName)
			{
				fixed (char* ptr = fileName)
				{
					int num = Math.Min(fileName.Length, 259);
					for (int i = 0; i < num; i++)
					{
						_cFileName[i] = ptr[i];
					}
					_cFileName[num] = '\0';
				}
			}
		}

		internal struct REG_TZI_FORMAT
		{
			internal int Bias;

			internal int StandardBias;

			internal int DaylightBias;

			internal SYSTEMTIME StandardDate;

			internal SYSTEMTIME DaylightDate;

			internal REG_TZI_FORMAT(in TIME_ZONE_INFORMATION tzi)
			{
				Bias = tzi.Bias;
				StandardDate = tzi.StandardDate;
				StandardBias = tzi.StandardBias;
				DaylightDate = tzi.DaylightDate;
				DaylightBias = tzi.DaylightBias;
			}
		}

		internal struct SYSTEMTIME
		{
			internal ushort Year;

			internal ushort Month;

			internal ushort DayOfWeek;

			internal ushort Day;

			internal ushort Hour;

			internal ushort Minute;

			internal ushort Second;

			internal ushort Milliseconds;

			internal bool Equals(in SYSTEMTIME other)
			{
				if (Year == other.Year && Month == other.Month && DayOfWeek == other.DayOfWeek && Day == other.Day && Hour == other.Hour && Minute == other.Minute && Second == other.Second)
				{
					return Milliseconds == other.Milliseconds;
				}
				return false;
			}
		}

		[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
		internal struct TIME_DYNAMIC_ZONE_INFORMATION
		{
			internal int Bias;

			internal unsafe fixed char StandardName[32];

			internal SYSTEMTIME StandardDate;

			internal int StandardBias;

			internal unsafe fixed char DaylightName[32];

			internal SYSTEMTIME DaylightDate;

			internal int DaylightBias;

			internal unsafe fixed char TimeZoneKeyName[128];

			internal byte DynamicDaylightTimeDisabled;

			internal unsafe string GetTimeZoneKeyName()
			{
				fixed (char* timeZoneKeyName = TimeZoneKeyName)
				{
					return new string(timeZoneKeyName);
				}
			}
		}

		[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
		internal struct TIME_ZONE_INFORMATION
		{
			internal int Bias;

			internal unsafe fixed char StandardName[32];

			internal SYSTEMTIME StandardDate;

			internal int StandardBias;

			internal unsafe fixed char DaylightName[32];

			internal SYSTEMTIME DaylightDate;

			internal int DaylightBias;

			internal unsafe TIME_ZONE_INFORMATION(in TIME_DYNAMIC_ZONE_INFORMATION dtzi)
			{
				fixed (TIME_ZONE_INFORMATION* ptr = &this)
				{
					fixed (TIME_DYNAMIC_ZONE_INFORMATION* ptr2 = &dtzi)
					{
						*ptr = *(TIME_ZONE_INFORMATION*)ptr2;
					}
				}
			}

			internal unsafe string GetStandardName()
			{
				fixed (char* standardName = StandardName)
				{
					return new string(standardName);
				}
			}

			internal unsafe string GetDaylightName()
			{
				fixed (char* daylightName = DaylightName)
				{
					return new string(daylightName);
				}
			}
		}

		internal struct COPYFILE2_EXTENDED_PARAMETERS
		{
			internal uint dwSize;

			internal uint dwCopyFlags;

			internal IntPtr pfCancel;

			internal IntPtr pProgressRoutine;

			internal IntPtr pvCallbackContext;
		}

		internal enum FILE_INFO_BY_HANDLE_CLASS : uint
		{
			FileBasicInfo,
			FileStandardInfo,
			FileNameInfo,
			FileRenameInfo,
			FileDispositionInfo,
			FileAllocationInfo,
			FileEndOfFileInfo,
			FileStreamInfo,
			FileCompressionInfo,
			FileAttributeTagInfo,
			FileIdBothDirectoryInfo,
			FileIdBothDirectoryRestartInfo,
			FileIoPriorityHintInfo,
			FileRemoteProtocolInfo,
			FileFullDirectoryInfo,
			FileFullDirectoryRestartInfo
		}

		internal struct FILE_TIME
		{
			internal uint dwLowDateTime;

			internal uint dwHighDateTime;

			internal long ToTicks()
			{
				return (long)(((ulong)dwHighDateTime << 32) + dwLowDateTime);
			}

			internal DateTimeOffset ToDateTimeOffset()
			{
				return DateTimeOffset.FromFileTime(ToTicks());
			}
		}

		internal enum FINDEX_INFO_LEVELS : uint
		{
			FindExInfoStandard,
			FindExInfoBasic,
			FindExInfoMaxInfoLevel
		}

		internal enum FINDEX_SEARCH_OPS : uint
		{
			FindExSearchNameMatch,
			FindExSearchLimitToDirectories,
			FindExSearchLimitToDevices,
			FindExSearchMaxSearchOp
		}

		internal enum GET_FILEEX_INFO_LEVELS : uint
		{
			GetFileExInfoStandard,
			GetFileExMaxInfoLevel
		}

		internal struct SECURITY_ATTRIBUTES
		{
			internal uint nLength;

			internal IntPtr lpSecurityDescriptor;

			internal BOOL bInheritHandle;
		}

		internal struct FILE_BASIC_INFO
		{
			internal long CreationTime;

			internal long LastAccessTime;

			internal long LastWriteTime;

			internal long ChangeTime;

			internal uint FileAttributes;
		}

		internal struct WIN32_FILE_ATTRIBUTE_DATA
		{
			internal int dwFileAttributes;

			internal FILE_TIME ftCreationTime;

			internal FILE_TIME ftLastAccessTime;

			internal FILE_TIME ftLastWriteTime;

			internal uint nFileSizeHigh;

			internal uint nFileSizeLow;

			internal void PopulateFrom(ref WIN32_FIND_DATA findData)
			{
				dwFileAttributes = (int)findData.dwFileAttributes;
				ftCreationTime = findData.ftCreationTime;
				ftLastAccessTime = findData.ftLastAccessTime;
				ftLastWriteTime = findData.ftLastWriteTime;
				nFileSizeHigh = findData.nFileSizeHigh;
				nFileSizeLow = findData.nFileSizeLow;
			}
		}

		private static bool useUWPFallback;

		internal static int CopyFileUWP(string src, string dst, bool failIfExists)
		{
			uint dwCopyFlags = (failIfExists ? 1u : 0u);
			COPYFILE2_EXTENDED_PARAMETERS pExtendedParameters = new COPYFILE2_EXTENDED_PARAMETERS
			{
				dwSize = (uint)Marshal.SizeOf<COPYFILE2_EXTENDED_PARAMETERS>(),
				dwCopyFlags = dwCopyFlags
			};
			return Win32Marshal.TryMakeWin32ErrorCodeFromHR(CopyFile2(src, dst, ref pExtendedParameters));
		}

		internal static int CopyFile(string src, string dst, bool failIfExists)
		{
			int flags = (failIfExists ? 1 : 0);
			int cancel = 0;
			if (useUWPFallback)
			{
				return CopyFileUWP(src, dst, failIfExists);
			}
			try
			{
				if (!CopyFileEx(src, dst, IntPtr.Zero, IntPtr.Zero, ref cancel, flags))
				{
					return Marshal.GetLastWin32Error();
				}
			}
			catch (DllNotFoundException)
			{
				useUWPFallback = true;
				return CopyFileUWP(src, dst, failIfExists);
			}
			return 0;
		}

		[DllImport("kernel32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "DeleteVolumeMountPointW", SetLastError = true)]
		internal static extern bool DeleteVolumeMountPointPrivate(string mountPoint);

		internal static bool DeleteVolumeMountPoint(string mountPoint)
		{
			mountPoint = PathInternal.EnsureExtendedPrefixIfNeeded(mountPoint);
			try
			{
				return DeleteVolumeMountPointPrivate(mountPoint);
			}
			catch (DllNotFoundException)
			{
				throw new UnauthorizedAccessException();
			}
		}

		[DllImport("kernel32.dll", CharSet = CharSet.Unicode, ExactSpelling = true, SetLastError = true)]
		internal static extern bool FreeLibrary(IntPtr hModule);

		[DllImport("kernel32.dll", CharSet = CharSet.Unicode, EntryPoint = "LoadLibraryExW", SetLastError = true)]
		internal static extern SafeLibraryHandle LoadLibraryEx(string libFilename, IntPtr reserved, int flags);

		[DllImport("kernel32.dll", CharSet = CharSet.Unicode, ExactSpelling = true, SetLastError = true)]
		internal static extern bool GetFileMUIPath(uint flags, string filePath, [Out] StringBuilder language, ref int languageLength, [Out] StringBuilder fileMuiPath, ref int fileMuiPathLength, ref long enumerator);

		[DllImport("kernel32.dll", CharSet = CharSet.Unicode, ExactSpelling = true, SetLastError = true)]
		internal static extern uint GetDynamicTimeZoneInformation(out TIME_DYNAMIC_ZONE_INFORMATION pTimeZoneInformation);

		[DllImport("kernel32.dll", CharSet = CharSet.Unicode, ExactSpelling = true, SetLastError = true)]
		internal static extern uint GetTimeZoneInformation(out TIME_ZONE_INFORMATION lpTimeZoneInformation);

		[DllImport("kernel32.dll", SetLastError = true)]
		[return: MarshalAs(UnmanagedType.Bool)]
		internal static extern bool CloseHandle(IntPtr handle);

		[DllImport("kernel32.dll", BestFitMapping = false, CharSet = CharSet.Unicode)]
		internal static extern int CopyFile2(string pwszExistingFileName, string pwszNewFileName, ref COPYFILE2_EXTENDED_PARAMETERS pExtendedParameters);

		[DllImport("kernel32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "CopyFileExW", SetLastError = true)]
		private static extern bool CopyFileExPrivate(string src, string dst, IntPtr progressRoutine, IntPtr progressData, ref int cancel, int flags);

		internal static bool CopyFileEx(string src, string dst, IntPtr progressRoutine, IntPtr progressData, ref int cancel, int flags)
		{
			src = PathInternal.EnsureExtendedPrefixIfNeeded(src);
			dst = PathInternal.EnsureExtendedPrefixIfNeeded(dst);
			return CopyFileExPrivate(src, dst, progressRoutine, progressData, ref cancel, flags);
		}

		[DllImport("kernel32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "CreateDirectoryW", SetLastError = true)]
		private static extern bool CreateDirectoryPrivate(string path, ref SECURITY_ATTRIBUTES lpSecurityAttributes);

		internal static bool CreateDirectory(string path, ref SECURITY_ATTRIBUTES lpSecurityAttributes)
		{
			path = PathInternal.EnsureExtendedPrefix(path);
			return CreateDirectoryPrivate(path, ref lpSecurityAttributes);
		}

		[DllImport("kernel32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "CreateFileW", ExactSpelling = true, SetLastError = true)]
		private unsafe static extern IntPtr CreateFilePrivate(string lpFileName, int dwDesiredAccess, FileShare dwShareMode, SECURITY_ATTRIBUTES* securityAttrs, FileMode dwCreationDisposition, int dwFlagsAndAttributes, IntPtr hTemplateFile);

		internal static SafeFileHandle CreateFile(string lpFileName, int dwDesiredAccess, FileShare dwShareMode, FileMode dwCreationDisposition, int dwFlagsAndAttributes)
		{
			IntPtr intPtr = CreateFile_IntPtr(lpFileName, dwDesiredAccess, dwShareMode, dwCreationDisposition, dwFlagsAndAttributes);
			try
			{
				return new SafeFileHandle(intPtr, ownsHandle: true);
			}
			catch
			{
				CloseHandle(intPtr);
				throw;
			}
		}

		internal unsafe static IntPtr CreateFile_IntPtr(string lpFileName, int dwDesiredAccess, FileShare dwShareMode, FileMode dwCreationDisposition, int dwFlagsAndAttributes)
		{
			lpFileName = PathInternal.EnsureExtendedPrefixIfNeeded(lpFileName);
			return CreateFilePrivate(lpFileName, dwDesiredAccess, dwShareMode, null, dwCreationDisposition, dwFlagsAndAttributes, IntPtr.Zero);
		}

		[DllImport("kernel32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "DeleteFileW", SetLastError = true)]
		private static extern bool DeleteFilePrivate(string path);

		internal static bool DeleteFile(string path)
		{
			path = PathInternal.EnsureExtendedPrefixIfNeeded(path);
			return DeleteFilePrivate(path);
		}

		[DllImport("kernel32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "FindFirstFileExW", SetLastError = true)]
		private static extern SafeFindHandle FindFirstFileExPrivate(string lpFileName, FINDEX_INFO_LEVELS fInfoLevelId, ref WIN32_FIND_DATA lpFindFileData, FINDEX_SEARCH_OPS fSearchOp, IntPtr lpSearchFilter, int dwAdditionalFlags);

		internal static SafeFindHandle FindFirstFile(string fileName, ref WIN32_FIND_DATA data)
		{
			fileName = PathInternal.EnsureExtendedPrefixIfNeeded(fileName);
			return FindFirstFileExPrivate(fileName, FINDEX_INFO_LEVELS.FindExInfoBasic, ref data, FINDEX_SEARCH_OPS.FindExSearchNameMatch, IntPtr.Zero, 0);
		}

		[DllImport("kernel32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "FindNextFileW", SetLastError = true)]
		internal static extern bool FindNextFile(SafeFindHandle hndFindFile, ref WIN32_FIND_DATA lpFindFileData);

		[DllImport("kernel32.dll", BestFitMapping = true, CharSet = CharSet.Unicode, EntryPoint = "FormatMessageW", SetLastError = true)]
		private unsafe static extern int FormatMessage(int dwFlags, IntPtr lpSource, uint dwMessageId, int dwLanguageId, char* lpBuffer, int nSize, IntPtr[] arguments);

		internal static string GetMessage(int errorCode)
		{
			return GetMessage(IntPtr.Zero, errorCode);
		}

		internal static string GetMessage(IntPtr moduleHandle, int errorCode)
		{
			Span<char> buffer = stackalloc char[256];
			do
			{
				if (TryGetErrorMessage(moduleHandle, errorCode, buffer, out var errorMsg))
				{
					return errorMsg;
				}
				buffer = new char[buffer.Length * 4];
			}
			while (buffer.Length < 66560);
			return $"Unknown error (0x{errorCode:x})";
		}

		private unsafe static bool TryGetErrorMessage(IntPtr moduleHandle, int errorCode, Span<char> buffer, out string errorMsg)
		{
			int num = 12800;
			if (moduleHandle != IntPtr.Zero)
			{
				num |= 0x800;
			}
			int num2;
			fixed (char* reference = &MemoryMarshal.GetReference(buffer))
			{
				num2 = FormatMessage(num, moduleHandle, (uint)errorCode, 0, reference, buffer.Length, null);
			}
			if (num2 != 0)
			{
				int num3;
				for (num3 = num2; num3 > 0; num3--)
				{
					char c = buffer[num3 - 1];
					if (c > ' ' && c != '.')
					{
						break;
					}
				}
				errorMsg = buffer.Slice(0, num3).ToString();
			}
			else
			{
				if (Marshal.GetLastWin32Error() == 122)
				{
					errorMsg = "";
					return false;
				}
				errorMsg = $"Unknown error (0x{errorCode:x})";
			}
			return true;
		}

		[DllImport("kernel32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "GetFileAttributesExW", SetLastError = true)]
		private static extern bool GetFileAttributesExPrivate(string name, GET_FILEEX_INFO_LEVELS fileInfoLevel, ref WIN32_FILE_ATTRIBUTE_DATA lpFileInformation);

		internal static bool GetFileAttributesEx(string name, GET_FILEEX_INFO_LEVELS fileInfoLevel, ref WIN32_FILE_ATTRIBUTE_DATA lpFileInformation)
		{
			name = PathInternal.EnsureExtendedPrefixIfNeeded(name);
			return GetFileAttributesExPrivate(name, fileInfoLevel, ref lpFileInformation);
		}

		[DllImport("kernel32.dll", CharSet = CharSet.Unicode, ExactSpelling = true, SetLastError = true)]
		public static extern bool GetFileInformationByHandleEx(IntPtr hFile, FILE_INFO_BY_HANDLE_CLASS FileInformationClass, IntPtr lpFileInformation, uint dwBufferSize);

		[DllImport("kernel32.dll", SetLastError = true)]
		internal static extern int GetLogicalDrives();

		[DllImport("kernel32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "MoveFileExW", SetLastError = true)]
		private static extern bool MoveFileExPrivate(string src, string dst, uint flags);

		internal static bool MoveFile(string src, string dst)
		{
			src = PathInternal.EnsureExtendedPrefixIfNeeded(src);
			dst = PathInternal.EnsureExtendedPrefixIfNeeded(dst);
			return MoveFileExPrivate(src, dst, 2u);
		}

		[DllImport("kernel32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "RemoveDirectoryW", SetLastError = true)]
		private static extern bool RemoveDirectoryPrivate(string path);

		internal static bool RemoveDirectory(string path)
		{
			path = PathInternal.EnsureExtendedPrefixIfNeeded(path);
			return RemoveDirectoryPrivate(path);
		}

		[DllImport("kernel32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "ReplaceFileW", SetLastError = true)]
		private static extern bool ReplaceFilePrivate(string replacedFileName, string replacementFileName, string backupFileName, int dwReplaceFlags, IntPtr lpExclude, IntPtr lpReserved);

		internal static bool ReplaceFile(string replacedFileName, string replacementFileName, string backupFileName, int dwReplaceFlags, IntPtr lpExclude, IntPtr lpReserved)
		{
			replacedFileName = PathInternal.EnsureExtendedPrefixIfNeeded(replacedFileName);
			replacementFileName = PathInternal.EnsureExtendedPrefixIfNeeded(replacementFileName);
			backupFileName = PathInternal.EnsureExtendedPrefixIfNeeded(backupFileName);
			return ReplaceFilePrivate(replacedFileName, replacementFileName, backupFileName, dwReplaceFlags, lpExclude, lpReserved);
		}

		[DllImport("kernel32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "SetFileAttributesW", SetLastError = true)]
		private static extern bool SetFileAttributesPrivate(string name, int attr);

		internal static bool SetFileAttributes(string name, int attr)
		{
			name = PathInternal.EnsureExtendedPrefixIfNeeded(name);
			return SetFileAttributesPrivate(name, attr);
		}

		[DllImport("kernel32.dll", ExactSpelling = true, SetLastError = true)]
		internal static extern bool SetFileInformationByHandle(SafeFileHandle hFile, FILE_INFO_BY_HANDLE_CLASS FileInformationClass, ref FILE_BASIC_INFO lpFileInformation, uint dwBufferSize);

		internal unsafe static bool SetFileTime(SafeFileHandle hFile, long creationTime = -1L, long lastAccessTime = -1L, long lastWriteTime = -1L, long changeTime = -1L, uint fileAttributes = 0u)
		{
			FILE_BASIC_INFO lpFileInformation = new FILE_BASIC_INFO
			{
				CreationTime = creationTime,
				LastAccessTime = lastAccessTime,
				LastWriteTime = lastWriteTime,
				ChangeTime = changeTime,
				FileAttributes = fileAttributes
			};
			return SetFileInformationByHandle(hFile, FILE_INFO_BY_HANDLE_CLASS.FileBasicInfo, ref lpFileInformation, (uint)sizeof(FILE_BASIC_INFO));
		}

		[DllImport("kernel32.dll", ExactSpelling = true, SetLastError = true)]
		internal static extern bool SetThreadErrorMode(uint dwNewMode, out uint lpOldMode);
	}

	internal class BCrypt
	{
		internal enum NTSTATUS : uint
		{
			STATUS_SUCCESS = 0u,
			STATUS_NOT_FOUND = 3221226021u,
			STATUS_INVALID_PARAMETER = 3221225485u,
			STATUS_NO_MEMORY = 3221225495u
		}

		[DllImport("BCrypt.dll", CharSet = CharSet.Unicode)]
		internal unsafe static extern NTSTATUS BCryptGenRandom(IntPtr hAlgorithm, byte* pbBuffer, int cbBuffer, int dwFlags);
	}

	internal class User32
	{
		[DllImport("user32.dll", CharSet = CharSet.Unicode, EntryPoint = "LoadStringW", SetLastError = true)]
		internal static extern int LoadString(SafeLibraryHandle handle, int id, [Out] StringBuilder buffer, int bufferLength);
	}

	internal enum BOOL
	{
		FALSE,
		TRUE
	}

	internal enum BOOLEAN : byte
	{
		FALSE,
		TRUE
	}

	internal struct LongFileTime
	{
		internal long TicksSince1601;
	}

	internal struct UNICODE_STRING
	{
		internal ushort Length;

		internal ushort MaximumLength;

		internal IntPtr Buffer;
	}

	internal class NtDll
	{
		[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
		public struct FILE_FULL_DIR_INFORMATION
		{
			public uint NextEntryOffset;

			public uint FileIndex;

			public LongFileTime CreationTime;

			public LongFileTime LastAccessTime;

			public LongFileTime LastWriteTime;

			public LongFileTime ChangeTime;

			public long EndOfFile;

			public long AllocationSize;

			public FileAttributes FileAttributes;

			public uint FileNameLength;

			public uint EaSize;

			private char _fileName;

			public unsafe ReadOnlySpan<char> FileName
			{
				get
				{
					fixed (char* fileName = &_fileName)
					{
						return new ReadOnlySpan<char>(fileName, (int)FileNameLength / 2);
					}
				}
			}

			public unsafe static FILE_FULL_DIR_INFORMATION* GetNextInfo(FILE_FULL_DIR_INFORMATION* info)
			{
				if (info == null)
				{
					return null;
				}
				uint nextEntryOffset = info->NextEntryOffset;
				if (nextEntryOffset == 0)
				{
					return null;
				}
				return (FILE_FULL_DIR_INFORMATION*)((byte*)info + nextEntryOffset);
			}
		}

		public enum FILE_INFORMATION_CLASS : uint
		{
			FileDirectoryInformation = 1u,
			FileFullDirectoryInformation,
			FileBothDirectoryInformation,
			FileBasicInformation,
			FileStandardInformation,
			FileInternalInformation,
			FileEaInformation,
			FileAccessInformation,
			FileNameInformation,
			FileRenameInformation,
			FileLinkInformation,
			FileNamesInformation,
			FileDispositionInformation,
			FilePositionInformation,
			FileFullEaInformation,
			FileModeInformation,
			FileAlignmentInformation,
			FileAllInformation,
			FileAllocationInformation,
			FileEndOfFileInformation,
			FileAlternateNameInformation,
			FileStreamInformation,
			FilePipeInformation,
			FilePipeLocalInformation,
			FilePipeRemoteInformation,
			FileMailslotQueryInformation,
			FileMailslotSetInformation,
			FileCompressionInformation,
			FileObjectIdInformation,
			FileCompletionInformation,
			FileMoveClusterInformation,
			FileQuotaInformation,
			FileReparsePointInformation,
			FileNetworkOpenInformation,
			FileAttributeTagInformation,
			FileTrackingInformation,
			FileIdBothDirectoryInformation,
			FileIdFullDirectoryInformation,
			FileValidDataLengthInformation,
			FileShortNameInformation,
			FileIoCompletionNotificationInformation,
			FileIoStatusBlockRangeInformation,
			FileIoPriorityHintInformation,
			FileSfioReserveInformation,
			FileSfioVolumeInformation,
			FileHardLinkInformation,
			FileProcessIdsUsingFileInformation,
			FileNormalizedNameInformation,
			FileNetworkPhysicalNameInformation,
			FileIdGlobalTxDirectoryInformation,
			FileIsRemoteDeviceInformation,
			FileUnusedInformation,
			FileNumaNodeInformation,
			FileStandardLinkInformation,
			FileRemoteProtocolInformation,
			FileRenameInformationBypassAccessCheck,
			FileLinkInformationBypassAccessCheck,
			FileVolumeNameInformation,
			FileIdInformation,
			FileIdExtdDirectoryInformation,
			FileReplaceCompletionInformation,
			FileHardLinkFullIdInformation,
			FileIdExtdBothDirectoryInformation,
			FileDispositionInformationEx,
			FileRenameInformationEx,
			FileRenameInformationExBypassAccessCheck,
			FileDesiredStorageClassInformation,
			FileStatInformation
		}

		public struct IO_STATUS_BLOCK
		{
			[StructLayout(LayoutKind.Explicit)]
			public struct IO_STATUS
			{
				[FieldOffset(0)]
				public uint Status;

				[FieldOffset(0)]
				public IntPtr Pointer;
			}

			public IO_STATUS Status;

			public IntPtr Information;
		}

		public unsafe struct OBJECT_ATTRIBUTES(UNICODE_STRING* objectName, ObjectAttributes attributes, IntPtr rootDirectory)
		{
			public unsafe uint Length = (uint)sizeof(OBJECT_ATTRIBUTES);

			public IntPtr RootDirectory = rootDirectory;

			public unsafe UNICODE_STRING* ObjectName = objectName;

			public ObjectAttributes Attributes = attributes;

			public unsafe void* SecurityDescriptor = null;

			public unsafe void* SecurityQualityOfService = null;
		}

		[Flags]
		public enum ObjectAttributes : uint
		{
			OBJ_INHERIT = 2u,
			OBJ_PERMANENT = 0x10u,
			OBJ_EXCLUSIVE = 0x20u,
			OBJ_CASE_INSENSITIVE = 0x40u,
			OBJ_OPENIF = 0x80u,
			OBJ_OPENLINK = 0x100u
		}

		public enum CreateDisposition : uint
		{
			FILE_SUPERSEDE,
			FILE_OPEN,
			FILE_CREATE,
			FILE_OPEN_IF,
			FILE_OVERWRITE,
			FILE_OVERWRITE_IF
		}

		public enum CreateOptions : uint
		{
			FILE_DIRECTORY_FILE = 1u,
			FILE_WRITE_THROUGH = 2u,
			FILE_SEQUENTIAL_ONLY = 4u,
			FILE_NO_INTERMEDIATE_BUFFERING = 8u,
			FILE_SYNCHRONOUS_IO_ALERT = 0x10u,
			FILE_SYNCHRONOUS_IO_NONALERT = 0x20u,
			FILE_NON_DIRECTORY_FILE = 0x40u,
			FILE_CREATE_TREE_CONNECTION = 0x80u,
			FILE_COMPLETE_IF_OPLOCKED = 0x100u,
			FILE_NO_EA_KNOWLEDGE = 0x200u,
			FILE_RANDOM_ACCESS = 0x800u,
			FILE_DELETE_ON_CLOSE = 0x1000u,
			FILE_OPEN_BY_FILE_ID = 0x2000u,
			FILE_OPEN_FOR_BACKUP_INTENT = 0x4000u,
			FILE_NO_COMPRESSION = 0x8000u,
			FILE_OPEN_REQUIRING_OPLOCK = 0x10000u,
			FILE_DISALLOW_EXCLUSIVE = 0x20000u,
			FILE_SESSION_AWARE = 0x40000u,
			FILE_RESERVE_OPFILTER = 0x100000u,
			FILE_OPEN_REPARSE_POINT = 0x200000u,
			FILE_OPEN_NO_RECALL = 0x400000u
		}

		[Flags]
		public enum DesiredAccess : uint
		{
			FILE_READ_DATA = 1u,
			FILE_LIST_DIRECTORY = FILE_READ_DATA,
			FILE_WRITE_DATA = 2u,
			FILE_ADD_FILE = FILE_WRITE_DATA,
			FILE_APPEND_DATA = 4u,
			FILE_ADD_SUBDIRECTORY = FILE_APPEND_DATA,
			FILE_CREATE_PIPE_INSTANCE = FILE_APPEND_DATA,
			FILE_READ_EA = 8u,
			FILE_WRITE_EA = 0x10u,
			FILE_EXECUTE = 0x20u,
			FILE_TRAVERSE = FILE_EXECUTE,
			FILE_DELETE_CHILD = 0x40u,
			FILE_READ_ATTRIBUTES = 0x80u,
			FILE_WRITE_ATTRIBUTES = 0x100u,
			FILE_ALL_ACCESS = 0xF01FFu,
			DELETE = 0x10000u,
			READ_CONTROL = 0x20000u,
			WRITE_DAC = 0x40000u,
			WRITE_OWNER = 0x80000u,
			SYNCHRONIZE = 0x100000u,
			STANDARD_RIGHTS_READ = READ_CONTROL,
			STANDARD_RIGHTS_WRITE = READ_CONTROL,
			STANDARD_RIGHTS_EXECUTE = READ_CONTROL,
			FILE_GENERIC_READ = 0x80000000u,
			FILE_GENERIC_WRITE = 0x40000000u,
			FILE_GENERIC_EXECUTE = 0x20000000u
		}

		[DllImport("ntdll.dll", CharSet = CharSet.Unicode, ExactSpelling = true)]
		private unsafe static extern int NtCreateFile(out IntPtr FileHandle, DesiredAccess DesiredAccess, ref OBJECT_ATTRIBUTES ObjectAttributes, out IO_STATUS_BLOCK IoStatusBlock, long* AllocationSize, FileAttributes FileAttributes, FileShare ShareAccess, CreateDisposition CreateDisposition, CreateOptions CreateOptions, void* EaBuffer, uint EaLength);

		internal unsafe static (int status, IntPtr handle) CreateFile(ReadOnlySpan<char> path, IntPtr rootDirectory, CreateDisposition createDisposition, DesiredAccess desiredAccess = DesiredAccess.SYNCHRONIZE | DesiredAccess.FILE_GENERIC_READ, FileShare shareAccess = FileShare.ReadWrite | FileShare.Delete, FileAttributes fileAttributes = (FileAttributes)0, CreateOptions createOptions = CreateOptions.FILE_SYNCHRONOUS_IO_NONALERT, ObjectAttributes objectAttributes = NtDll.ObjectAttributes.OBJ_CASE_INSENSITIVE)
		{
			fixed (char* reference = &MemoryMarshal.GetReference(path))
			{
				UNICODE_STRING uNICODE_STRING = checked(new UNICODE_STRING
				{
					Length = (ushort)(path.Length * 2),
					MaximumLength = (ushort)(path.Length * 2),
					Buffer = (IntPtr)reference
				});
				OBJECT_ATTRIBUTES ObjectAttributes = new OBJECT_ATTRIBUTES(&uNICODE_STRING, objectAttributes, rootDirectory);
				IntPtr FileHandle;
				IO_STATUS_BLOCK IoStatusBlock;
				return (status: NtCreateFile(out FileHandle, desiredAccess, ref ObjectAttributes, out IoStatusBlock, null, fileAttributes, shareAccess, createDisposition, createOptions, null, 0u), handle: FileHandle);
			}
		}

		[DllImport("ntdll.dll", CharSet = CharSet.Unicode, ExactSpelling = true)]
		public unsafe static extern int NtQueryDirectoryFile(IntPtr FileHandle, IntPtr Event, IntPtr ApcRoutine, IntPtr ApcContext, out IO_STATUS_BLOCK IoStatusBlock, IntPtr FileInformation, uint Length, FILE_INFORMATION_CLASS FileInformationClass, BOOLEAN ReturnSingleEntry, UNICODE_STRING* FileName, BOOLEAN RestartScan);

		[DllImport("ntdll.dll", ExactSpelling = true)]
		public static extern uint RtlNtStatusToDosError(int Status);
	}

	internal class Advapi32
	{
		[DllImport("advapi32.dll")]
		internal static extern int RegCloseKey(IntPtr hKey);

		[DllImport("advapi32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "RegEnumKeyExW")]
		internal static extern int RegEnumKeyEx(SafeRegistryHandle hKey, int dwIndex, char[] lpName, ref int lpcbName, int[] lpReserved, [Out] StringBuilder lpClass, int[] lpcbClass, long[] lpftLastWriteTime);

		[DllImport("advapi32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "RegOpenKeyExW")]
		internal static extern int RegOpenKeyEx(SafeRegistryHandle hKey, string lpSubKey, int ulOptions, int samDesired, out SafeRegistryHandle hkResult);

		[DllImport("advapi32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "RegQueryInfoKeyW")]
		internal static extern int RegQueryInfoKey(SafeRegistryHandle hKey, [Out] StringBuilder lpClass, int[] lpcbClass, IntPtr lpReserved_MustBeZero, ref int lpcSubKeys, int[] lpcbMaxSubKeyLen, int[] lpcbMaxClassLen, ref int lpcValues, int[] lpcbMaxValueNameLen, int[] lpcbMaxValueLen, int[] lpcbSecurityDescriptor, int[] lpftLastWriteTime);

		[DllImport("advapi32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "RegQueryValueExW")]
		internal static extern int RegQueryValueEx(SafeRegistryHandle hKey, string lpValueName, int[] lpReserved, ref int lpType, [Out] byte[] lpData, ref int lpcbData);

		[DllImport("advapi32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "RegQueryValueExW")]
		internal static extern int RegQueryValueEx(SafeRegistryHandle hKey, string lpValueName, int[] lpReserved, ref int lpType, ref int lpData, ref int lpcbData);

		[DllImport("advapi32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "RegQueryValueExW")]
		internal static extern int RegQueryValueEx(SafeRegistryHandle hKey, string lpValueName, int[] lpReserved, ref int lpType, ref long lpData, ref int lpcbData);

		[DllImport("advapi32.dll", BestFitMapping = false, CharSet = CharSet.Unicode, EntryPoint = "RegQueryValueExW")]
		internal static extern int RegQueryValueEx(SafeRegistryHandle hKey, string lpValueName, int[] lpReserved, ref int lpType, [Out] char[] lpData, ref int lpcbData);
	}

	internal unsafe static void GetRandomBytes(byte* buffer, int length)
	{
		switch (BCrypt.BCryptGenRandom(IntPtr.Zero, buffer, length, 2))
		{
		case BCrypt.NTSTATUS.STATUS_NO_MEMORY:
			throw new OutOfMemoryException();
		default:
			throw new InvalidOperationException();
		case BCrypt.NTSTATUS.STATUS_SUCCESS:
			break;
		}
	}
}
