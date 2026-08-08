using System.Runtime.InteropServices;

namespace System.IO;

internal static class Win32Marshal
{
	internal static Exception GetExceptionForLastWin32Error(string path = "")
	{
		return GetExceptionForWin32Error(Marshal.GetLastWin32Error(), path);
	}

	internal static Exception GetExceptionForWin32Error(int errorCode, string path = "")
	{
		switch (errorCode)
		{
		case 2:
			return new FileNotFoundException(string.IsNullOrEmpty(path) ? "Unable to find the specified file." : SR.Format("Could not find file '{0}'.", path), path);
		case 3:
			return new DirectoryNotFoundException(string.IsNullOrEmpty(path) ? "Could not find a part of the path." : SR.Format("Could not find a part of the path '{0}'.", path));
		case 5:
			return new UnauthorizedAccessException(string.IsNullOrEmpty(path) ? "Access to the path is denied." : SR.Format("Access to the path '{0}' is denied.", path));
		case 183:
			if (!string.IsNullOrEmpty(path))
			{
				return new IOException(SR.Format("Cannot create '{0}' because a file or directory with the same name already exists.", path), MakeHRFromErrorCode(errorCode));
			}
			break;
		case 206:
			return new PathTooLongException(string.IsNullOrEmpty(path) ? "The specified file name or path is too long, or a component of the specified path is too long." : SR.Format("The path '{0}' is too long, or a component of the specified path is too long.", path));
		case 32:
			return new IOException(string.IsNullOrEmpty(path) ? "The process cannot access the file because it is being used by another process." : SR.Format("The process cannot access the file '{0}' because it is being used by another process.", path), MakeHRFromErrorCode(errorCode));
		case 80:
			if (!string.IsNullOrEmpty(path))
			{
				return new IOException(SR.Format("The file '{0}' already exists.", path), MakeHRFromErrorCode(errorCode));
			}
			break;
		case 995:
			return new OperationCanceledException();
		}
		return new IOException(string.IsNullOrEmpty(path) ? GetMessage(errorCode) : (GetMessage(errorCode) + " : '" + path + "'"), MakeHRFromErrorCode(errorCode));
	}

	internal static int MakeHRFromErrorCode(int errorCode)
	{
		if ((0xFFFF0000u & errorCode) != 0L)
		{
			return errorCode;
		}
		return -2147024896 | errorCode;
	}

	internal static int TryMakeWin32ErrorCodeFromHR(int hr)
	{
		if ((0xFFFF0000u & hr) == 2147942400u)
		{
			hr &= 0xFFFF;
		}
		return hr;
	}

	internal static string GetMessage(int errorCode)
	{
		return Interop.Kernel32.GetMessage(errorCode);
	}
}
