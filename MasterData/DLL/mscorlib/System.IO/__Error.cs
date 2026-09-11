using System.Security;
using Microsoft.Win32;

namespace System.IO;

internal static class __Error
{
	internal static void EndOfFile()
	{
		throw new EndOfStreamException(Environment.GetResourceString("Unable to read beyond the end of the stream."));
	}

	internal static void FileNotOpen()
	{
		throw new ObjectDisposedException(null, Environment.GetResourceString("Cannot access a closed file."));
	}

	internal static void StreamIsClosed()
	{
		throw new ObjectDisposedException(null, Environment.GetResourceString("Cannot access a closed Stream."));
	}

	internal static void ReaderClosed()
	{
		throw new ObjectDisposedException(null, Environment.GetResourceString("Cannot read from a closed TextReader."));
	}

	internal static string GetDisplayablePath(string path, bool isInvalidPath)
	{
		if (string.IsNullOrEmpty(path))
		{
			return string.Empty;
		}
		if (path.Length < 2)
		{
			return path;
		}
		if (PathInternal.IsPartiallyQualified(path) && !isInvalidPath)
		{
			return path;
		}
		bool flag = false;
		try
		{
			if (!isInvalidPath)
			{
				flag = true;
			}
		}
		catch (SecurityException)
		{
		}
		catch (ArgumentException)
		{
		}
		catch (NotSupportedException)
		{
		}
		if (!flag)
		{
			path = ((!Path.IsDirectorySeparator(path[path.Length - 1])) ? Path.GetFileName(path) : Environment.GetResourceString("<Path discovery permission to the specified directory was denied.>"));
		}
		return path;
	}

	internal static void WinIOError(int errorCode, string maybeFullPath)
	{
		bool isInvalidPath = errorCode == 123 || errorCode == 161;
		string displayablePath = GetDisplayablePath(maybeFullPath, isInvalidPath);
		switch (errorCode)
		{
		case 2:
			if (displayablePath.Length == 0)
			{
				throw new FileNotFoundException(Environment.GetResourceString("Unable to find the specified file."));
			}
			throw new FileNotFoundException(Environment.GetResourceString("Could not find file '{0}'.", displayablePath), displayablePath);
		case 3:
			if (displayablePath.Length == 0)
			{
				throw new DirectoryNotFoundException(Environment.GetResourceString("Could not find a part of the path."));
			}
			throw new DirectoryNotFoundException(Environment.GetResourceString("Could not find a part of the path '{0}'.", displayablePath));
		case 5:
			if (displayablePath.Length == 0)
			{
				throw new UnauthorizedAccessException(Environment.GetResourceString("Access to the path is denied."));
			}
			throw new UnauthorizedAccessException(Environment.GetResourceString("Access to the path '{0}' is denied.", displayablePath));
		case 183:
			if (displayablePath.Length != 0)
			{
				throw new IOException(Environment.GetResourceString("Cannot create \"{0}\" because a file or directory with the same name already exists.", displayablePath), Win32Native.MakeHRFromErrorCode(errorCode));
			}
			break;
		case 206:
			throw new PathTooLongException(Environment.GetResourceString("The specified path, file name, or both are too long. The fully qualified file name must be less than 260 characters, and the directory name must be less than 248 characters."));
		case 15:
			throw new DriveNotFoundException(Environment.GetResourceString("Could not find the drive '{0}'. The drive might not be ready or might not be mapped.", displayablePath));
		case 87:
			throw new IOException(Win32Native.GetMessage(errorCode), Win32Native.MakeHRFromErrorCode(errorCode));
		case 32:
			if (displayablePath.Length == 0)
			{
				throw new IOException(Environment.GetResourceString("The process cannot access the file because it is being used by another process."), Win32Native.MakeHRFromErrorCode(errorCode));
			}
			throw new IOException(Environment.GetResourceString("The process cannot access the file '{0}' because it is being used by another process.", displayablePath), Win32Native.MakeHRFromErrorCode(errorCode));
		case 80:
			if (displayablePath.Length != 0)
			{
				throw new IOException(Environment.GetResourceString("The file '{0}' already exists.", displayablePath), Win32Native.MakeHRFromErrorCode(errorCode));
			}
			break;
		case 995:
			throw new OperationCanceledException();
		}
		throw new IOException(Win32Native.GetMessage(errorCode), Win32Native.MakeHRFromErrorCode(errorCode));
	}

	internal static void WriterClosed()
	{
		throw new ObjectDisposedException(null, Environment.GetResourceString("Cannot write to a closed TextWriter."));
	}
}
