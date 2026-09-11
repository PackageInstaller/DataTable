using System.Buffers;
using System.Collections.Generic;
using System.Security.AccessControl;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace System.IO;

public static class File
{
	private const int MaxByteArrayLength = 2147483591;

	private static Encoding s_UTF8NoBOM;

	internal const int DefaultBufferSize = 4096;

	private static Encoding UTF8NoBOM => s_UTF8NoBOM ?? (s_UTF8NoBOM = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false, throwOnInvalidBytes: true));

	public static StreamReader OpenText(string path)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		return new StreamReader(path);
	}

	public static StreamWriter CreateText(string path)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		return new StreamWriter(path, append: false);
	}

	public static StreamWriter AppendText(string path)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		return new StreamWriter(path, append: true);
	}

	public static void Copy(string sourceFileName, string destFileName)
	{
		Copy(sourceFileName, destFileName, overwrite: false);
	}

	public static void Copy(string sourceFileName, string destFileName, bool overwrite)
	{
		if (sourceFileName == null)
		{
			throw new ArgumentNullException("sourceFileName", "File name cannot be null.");
		}
		if (destFileName == null)
		{
			throw new ArgumentNullException("destFileName", "File name cannot be null.");
		}
		if (sourceFileName.Length == 0)
		{
			throw new ArgumentException("Empty file name is not legal.", "sourceFileName");
		}
		if (destFileName.Length == 0)
		{
			throw new ArgumentException("Empty file name is not legal.", "destFileName");
		}
		FileSystem.CopyFile(Path.GetFullPath(sourceFileName), Path.GetFullPath(destFileName), overwrite);
	}

	public static FileStream Create(string path)
	{
		return Create(path, 4096);
	}

	public static FileStream Create(string path, int bufferSize)
	{
		return new FileStream(path, FileMode.Create, FileAccess.ReadWrite, FileShare.None, bufferSize);
	}

	public static FileStream Create(string path, int bufferSize, FileOptions options)
	{
		return new FileStream(path, FileMode.Create, FileAccess.ReadWrite, FileShare.None, bufferSize, options);
	}

	public static void Delete(string path)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		FileSystem.DeleteFile(Path.GetFullPath(path));
	}

	public static bool Exists(string path)
	{
		try
		{
			if (path == null)
			{
				return false;
			}
			if (path.Length == 0)
			{
				return false;
			}
			path = Path.GetFullPath(path);
			if (path.Length > 0 && PathInternal.IsDirectorySeparator(path[path.Length - 1]))
			{
				return false;
			}
			return FileSystem.FileExists(path);
		}
		catch (ArgumentException)
		{
		}
		catch (IOException)
		{
		}
		catch (UnauthorizedAccessException)
		{
		}
		return false;
	}

	public static FileStream Open(string path, FileMode mode)
	{
		return Open(path, mode, (mode == FileMode.Append) ? FileAccess.Write : FileAccess.ReadWrite, FileShare.None);
	}

	public static FileStream Open(string path, FileMode mode, FileAccess access)
	{
		return Open(path, mode, access, FileShare.None);
	}

	public static FileStream Open(string path, FileMode mode, FileAccess access, FileShare share)
	{
		return new FileStream(path, mode, access, share);
	}

	internal static DateTimeOffset GetUtcDateTimeOffset(DateTime dateTime)
	{
		if (dateTime.Kind == DateTimeKind.Unspecified)
		{
			return DateTime.SpecifyKind(dateTime, DateTimeKind.Utc);
		}
		return dateTime.ToUniversalTime();
	}

	public static void SetCreationTime(string path, DateTime creationTime)
	{
		FileSystem.SetCreationTime(Path.GetFullPath(path), creationTime, asDirectory: false);
	}

	public static void SetCreationTimeUtc(string path, DateTime creationTimeUtc)
	{
		FileSystem.SetCreationTime(Path.GetFullPath(path), GetUtcDateTimeOffset(creationTimeUtc), asDirectory: false);
	}

	public static DateTime GetCreationTime(string path)
	{
		return FileSystem.GetCreationTime(Path.GetFullPath(path)).LocalDateTime;
	}

	public static DateTime GetCreationTimeUtc(string path)
	{
		return FileSystem.GetCreationTime(Path.GetFullPath(path)).UtcDateTime;
	}

	public static void SetLastAccessTime(string path, DateTime lastAccessTime)
	{
		FileSystem.SetLastAccessTime(Path.GetFullPath(path), lastAccessTime, asDirectory: false);
	}

	public static void SetLastAccessTimeUtc(string path, DateTime lastAccessTimeUtc)
	{
		FileSystem.SetLastAccessTime(Path.GetFullPath(path), GetUtcDateTimeOffset(lastAccessTimeUtc), asDirectory: false);
	}

	public static DateTime GetLastAccessTime(string path)
	{
		return FileSystem.GetLastAccessTime(Path.GetFullPath(path)).LocalDateTime;
	}

	public static DateTime GetLastAccessTimeUtc(string path)
	{
		return FileSystem.GetLastAccessTime(Path.GetFullPath(path)).UtcDateTime;
	}

	public static void SetLastWriteTime(string path, DateTime lastWriteTime)
	{
		FileSystem.SetLastWriteTime(Path.GetFullPath(path), lastWriteTime, asDirectory: false);
	}

	public static void SetLastWriteTimeUtc(string path, DateTime lastWriteTimeUtc)
	{
		FileSystem.SetLastWriteTime(Path.GetFullPath(path), GetUtcDateTimeOffset(lastWriteTimeUtc), asDirectory: false);
	}

	public static DateTime GetLastWriteTime(string path)
	{
		return FileSystem.GetLastWriteTime(Path.GetFullPath(path)).LocalDateTime;
	}

	public static DateTime GetLastWriteTimeUtc(string path)
	{
		return FileSystem.GetLastWriteTime(Path.GetFullPath(path)).UtcDateTime;
	}

	public static FileAttributes GetAttributes(string path)
	{
		return FileSystem.GetAttributes(Path.GetFullPath(path));
	}

	public static void SetAttributes(string path, FileAttributes fileAttributes)
	{
		if ((fileAttributes & (FileAttributes)int.MinValue) != 0)
		{
			Path.Validate(path);
			if (!MonoIO.SetFileAttributes(path, fileAttributes, out var error))
			{
				throw MonoIO.GetException(path, error);
			}
		}
		else
		{
			FileSystem.SetAttributes(Path.GetFullPath(path), fileAttributes);
		}
	}

	public static FileStream OpenRead(string path)
	{
		return new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.Read);
	}

	public static FileStream OpenWrite(string path)
	{
		return new FileStream(path, FileMode.OpenOrCreate, FileAccess.Write, FileShare.None);
	}

	public static string ReadAllText(string path)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		return InternalReadAllText(path, Encoding.UTF8);
	}

	public static string ReadAllText(string path, Encoding encoding)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (encoding == null)
		{
			throw new ArgumentNullException("encoding");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		return InternalReadAllText(path, encoding);
	}

	private static string InternalReadAllText(string path, Encoding encoding)
	{
		using StreamReader streamReader = new StreamReader(path, encoding, detectEncodingFromByteOrderMarks: true);
		return streamReader.ReadToEnd();
	}

	public static void WriteAllText(string path, string contents)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		using StreamWriter streamWriter = new StreamWriter(path);
		streamWriter.Write(contents);
	}

	public static void WriteAllText(string path, string contents, Encoding encoding)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (encoding == null)
		{
			throw new ArgumentNullException("encoding");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		using StreamWriter streamWriter = new StreamWriter(path, append: false, encoding);
		streamWriter.Write(contents);
	}

	public static byte[] ReadAllBytes(string path)
	{
		using FileStream fileStream = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.Read, 1);
		long length = fileStream.Length;
		if (length > int.MaxValue)
		{
			throw new IOException("The file is too long. This operation is currently limited to supporting files less than 2 gigabytes in size.");
		}
		if (length == 0L)
		{
			return ReadAllBytesUnknownLength(fileStream);
		}
		int num = 0;
		int num2 = (int)length;
		byte[] array = new byte[num2];
		while (num2 > 0)
		{
			int num3 = fileStream.Read(array, num, num2);
			if (num3 == 0)
			{
				throw Error.GetEndOfFile();
			}
			num += num3;
			num2 -= num3;
		}
		return array;
	}

	private static byte[] ReadAllBytesUnknownLength(FileStream fs)
	{
		byte[] array = null;
		Span<byte> span = stackalloc byte[512];
		try
		{
			int num = 0;
			while (true)
			{
				if (num == span.Length)
				{
					uint num2 = (uint)(span.Length * 2);
					if (num2 > 2147483591)
					{
						num2 = (uint)Math.Max(2147483591, span.Length + 1);
					}
					byte[] array2 = ArrayPool<byte>.Shared.Rent((int)num2);
					span.CopyTo(array2);
					if (array != null)
					{
						ArrayPool<byte>.Shared.Return(array);
					}
					span = (array = array2);
				}
				int num3 = fs.Read(span.Slice(num));
				if (num3 == 0)
				{
					break;
				}
				num += num3;
			}
			return span.Slice(0, num).ToArray();
		}
		finally
		{
			if (array != null)
			{
				ArrayPool<byte>.Shared.Return(array);
			}
		}
	}

	public static void WriteAllBytes(string path, byte[] bytes)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path", "Path cannot be null.");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		if (bytes == null)
		{
			throw new ArgumentNullException("bytes");
		}
		InternalWriteAllBytes(path, bytes);
	}

	private static void InternalWriteAllBytes(string path, byte[] bytes)
	{
		using FileStream fileStream = new FileStream(path, FileMode.Create, FileAccess.Write, FileShare.Read);
		fileStream.Write(bytes, 0, bytes.Length);
	}

	public static string[] ReadAllLines(string path)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		return InternalReadAllLines(path, Encoding.UTF8);
	}

	public static string[] ReadAllLines(string path, Encoding encoding)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (encoding == null)
		{
			throw new ArgumentNullException("encoding");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		return InternalReadAllLines(path, encoding);
	}

	private static string[] InternalReadAllLines(string path, Encoding encoding)
	{
		List<string> list = new List<string>();
		using (StreamReader streamReader = new StreamReader(path, encoding))
		{
			string item;
			while ((item = streamReader.ReadLine()) != null)
			{
				list.Add(item);
			}
		}
		return list.ToArray();
	}

	public static IEnumerable<string> ReadLines(string path)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		return ReadLinesIterator.CreateIterator(path, Encoding.UTF8);
	}

	public static IEnumerable<string> ReadLines(string path, Encoding encoding)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (encoding == null)
		{
			throw new ArgumentNullException("encoding");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		return ReadLinesIterator.CreateIterator(path, encoding);
	}

	public static void WriteAllLines(string path, string[] contents)
	{
		WriteAllLines(path, (IEnumerable<string>)contents);
	}

	public static void WriteAllLines(string path, IEnumerable<string> contents)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (contents == null)
		{
			throw new ArgumentNullException("contents");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		InternalWriteAllLines(new StreamWriter(path), contents);
	}

	public static void WriteAllLines(string path, string[] contents, Encoding encoding)
	{
		WriteAllLines(path, (IEnumerable<string>)contents, encoding);
	}

	public static void WriteAllLines(string path, IEnumerable<string> contents, Encoding encoding)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (contents == null)
		{
			throw new ArgumentNullException("contents");
		}
		if (encoding == null)
		{
			throw new ArgumentNullException("encoding");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		InternalWriteAllLines(new StreamWriter(path, append: false, encoding), contents);
	}

	private static void InternalWriteAllLines(TextWriter writer, IEnumerable<string> contents)
	{
		using (writer)
		{
			foreach (string content in contents)
			{
				writer.WriteLine(content);
			}
		}
	}

	public static void AppendAllText(string path, string contents)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		using StreamWriter streamWriter = new StreamWriter(path, append: true);
		streamWriter.Write(contents);
	}

	public static void AppendAllText(string path, string contents, Encoding encoding)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (encoding == null)
		{
			throw new ArgumentNullException("encoding");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		using StreamWriter streamWriter = new StreamWriter(path, append: true, encoding);
		streamWriter.Write(contents);
	}

	public static void AppendAllLines(string path, IEnumerable<string> contents)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (contents == null)
		{
			throw new ArgumentNullException("contents");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		InternalWriteAllLines(new StreamWriter(path, append: true), contents);
	}

	public static void AppendAllLines(string path, IEnumerable<string> contents, Encoding encoding)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (contents == null)
		{
			throw new ArgumentNullException("contents");
		}
		if (encoding == null)
		{
			throw new ArgumentNullException("encoding");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		InternalWriteAllLines(new StreamWriter(path, append: true, encoding), contents);
	}

	public static void Replace(string sourceFileName, string destinationFileName, string destinationBackupFileName)
	{
		Replace(sourceFileName, destinationFileName, destinationBackupFileName, ignoreMetadataErrors: false);
	}

	public static void Replace(string sourceFileName, string destinationFileName, string destinationBackupFileName, bool ignoreMetadataErrors)
	{
		if (sourceFileName == null)
		{
			throw new ArgumentNullException("sourceFileName");
		}
		if (destinationFileName == null)
		{
			throw new ArgumentNullException("destinationFileName");
		}
		FileSystem.ReplaceFile(Path.GetFullPath(sourceFileName), Path.GetFullPath(destinationFileName), (destinationBackupFileName != null) ? Path.GetFullPath(destinationBackupFileName) : null, ignoreMetadataErrors);
	}

	public static void Move(string sourceFileName, string destFileName)
	{
		if (sourceFileName == null)
		{
			throw new ArgumentNullException("sourceFileName", "File name cannot be null.");
		}
		if (destFileName == null)
		{
			throw new ArgumentNullException("destFileName", "File name cannot be null.");
		}
		if (sourceFileName.Length == 0)
		{
			throw new ArgumentException("Empty file name is not legal.", "sourceFileName");
		}
		if (destFileName.Length == 0)
		{
			throw new ArgumentException("Empty file name is not legal.", "destFileName");
		}
		string fullPath = Path.GetFullPath(sourceFileName);
		string fullPath2 = Path.GetFullPath(destFileName);
		if (!FileSystem.FileExists(fullPath))
		{
			throw new FileNotFoundException(SR.Format("Could not find file '{0}'.", fullPath), fullPath);
		}
		FileSystem.MoveFile(fullPath, fullPath2);
	}

	public static void Encrypt(string path)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		throw new PlatformNotSupportedException("File encryption is not supported on this platform.");
	}

	public static void Decrypt(string path)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		throw new PlatformNotSupportedException("File encryption is not supported on this platform.");
	}

	private static StreamReader AsyncStreamReader(string path, Encoding encoding)
	{
		return new StreamReader(new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.Read, 4096, FileOptions.Asynchronous | FileOptions.SequentialScan), encoding, detectEncodingFromByteOrderMarks: true);
	}

	private static StreamWriter AsyncStreamWriter(string path, Encoding encoding, bool append)
	{
		return new StreamWriter(new FileStream(path, append ? FileMode.Append : FileMode.Create, FileAccess.Write, FileShare.Read, 4096, FileOptions.Asynchronous | FileOptions.SequentialScan), encoding);
	}

	public static Task<string> ReadAllTextAsync(string path, CancellationToken cancellationToken = default(CancellationToken))
	{
		return ReadAllTextAsync(path, Encoding.UTF8, cancellationToken);
	}

	public static Task<string> ReadAllTextAsync(string path, Encoding encoding, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (encoding == null)
		{
			throw new ArgumentNullException("encoding");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		if (!cancellationToken.IsCancellationRequested)
		{
			return InternalReadAllTextAsync(path, encoding, cancellationToken);
		}
		return Task.FromCanceled<string>(cancellationToken);
	}

	private static async Task<string> InternalReadAllTextAsync(string path, Encoding encoding, CancellationToken cancellationToken)
	{
		char[] buffer = null;
		StreamReader sr = AsyncStreamReader(path, encoding);
		try
		{
			cancellationToken.ThrowIfCancellationRequested();
			buffer = ArrayPool<char>.Shared.Rent(sr.CurrentEncoding.GetMaxCharCount(4096));
			StringBuilder sb = new StringBuilder();
			while (true)
			{
				int num = await sr.ReadAsync(new Memory<char>(buffer), cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
				if (num == 0)
				{
					break;
				}
				sb.Append(buffer, 0, num);
			}
			return sb.ToString();
		}
		finally
		{
			sr.Dispose();
			if (buffer != null)
			{
				ArrayPool<char>.Shared.Return(buffer);
			}
		}
	}

	public static Task WriteAllTextAsync(string path, string contents, CancellationToken cancellationToken = default(CancellationToken))
	{
		return WriteAllTextAsync(path, contents, UTF8NoBOM, cancellationToken);
	}

	public static Task WriteAllTextAsync(string path, string contents, Encoding encoding, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (encoding == null)
		{
			throw new ArgumentNullException("encoding");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		if (cancellationToken.IsCancellationRequested)
		{
			return Task.FromCanceled(cancellationToken);
		}
		if (string.IsNullOrEmpty(contents))
		{
			new FileStream(path, FileMode.Create, FileAccess.Write, FileShare.Read).Dispose();
			return Task.CompletedTask;
		}
		return InternalWriteAllTextAsync(AsyncStreamWriter(path, encoding, append: false), contents, cancellationToken);
	}

	public static Task<byte[]> ReadAllBytesAsync(string path, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (cancellationToken.IsCancellationRequested)
		{
			return Task.FromCanceled<byte[]>(cancellationToken);
		}
		FileStream fileStream = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.Read, 1, FileOptions.Asynchronous | FileOptions.SequentialScan);
		bool flag = false;
		try
		{
			long length = fileStream.Length;
			if (length > int.MaxValue)
			{
				return Task.FromException<byte[]>(new IOException("The file is too long. This operation is currently limited to supporting files less than 2 gigabytes in size."));
			}
			flag = true;
			return (length > 0) ? InternalReadAllBytesAsync(fileStream, (int)length, cancellationToken) : InternalReadAllBytesUnknownLengthAsync(fileStream, cancellationToken);
		}
		finally
		{
			if (!flag)
			{
				fileStream.Dispose();
			}
		}
	}

	private static async Task<byte[]> InternalReadAllBytesAsync(FileStream fs, int count, CancellationToken cancellationToken)
	{
		using (fs)
		{
			int index = 0;
			byte[] bytes = new byte[count];
			do
			{
				int num = await fs.ReadAsync(new Memory<byte>(bytes, index, count - index), cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
				if (num == 0)
				{
					throw Error.GetEndOfFile();
				}
				index += num;
			}
			while (index < count);
			return bytes;
		}
	}

	private static async Task<byte[]> InternalReadAllBytesUnknownLengthAsync(FileStream fs, CancellationToken cancellationToken)
	{
		byte[] rentedArray = ArrayPool<byte>.Shared.Rent(512);
		try
		{
			int bytesRead = 0;
			while (true)
			{
				if (bytesRead == rentedArray.Length)
				{
					uint num = (uint)(rentedArray.Length * 2);
					if (num > 2147483591)
					{
						num = (uint)Math.Max(2147483591, rentedArray.Length + 1);
					}
					byte[] array = ArrayPool<byte>.Shared.Rent((int)num);
					Buffer.BlockCopy(rentedArray, 0, array, 0, bytesRead);
					ArrayPool<byte>.Shared.Return(rentedArray);
					rentedArray = array;
				}
				int num2 = await fs.ReadAsync(rentedArray.AsMemory(bytesRead), cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
				if (num2 == 0)
				{
					break;
				}
				bytesRead += num2;
			}
			return rentedArray.AsSpan(0, bytesRead).ToArray();
		}
		finally
		{
			fs.Dispose();
			ArrayPool<byte>.Shared.Return(rentedArray);
		}
	}

	public static Task WriteAllBytesAsync(string path, byte[] bytes, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (path == null)
		{
			throw new ArgumentNullException("path", "Path cannot be null.");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		if (bytes == null)
		{
			throw new ArgumentNullException("bytes");
		}
		if (!cancellationToken.IsCancellationRequested)
		{
			return InternalWriteAllBytesAsync(path, bytes, cancellationToken);
		}
		return Task.FromCanceled(cancellationToken);
	}

	private static async Task InternalWriteAllBytesAsync(string path, byte[] bytes, CancellationToken cancellationToken)
	{
		using FileStream fs = new FileStream(path, FileMode.Create, FileAccess.Write, FileShare.Read, 4096, FileOptions.Asynchronous | FileOptions.SequentialScan);
		await fs.WriteAsync(new ReadOnlyMemory<byte>(bytes), cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
		await fs.FlushAsync(cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
	}

	public static Task<string[]> ReadAllLinesAsync(string path, CancellationToken cancellationToken = default(CancellationToken))
	{
		return ReadAllLinesAsync(path, Encoding.UTF8, cancellationToken);
	}

	public static Task<string[]> ReadAllLinesAsync(string path, Encoding encoding, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (encoding == null)
		{
			throw new ArgumentNullException("encoding");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		if (!cancellationToken.IsCancellationRequested)
		{
			return InternalReadAllLinesAsync(path, encoding, cancellationToken);
		}
		return Task.FromCanceled<string[]>(cancellationToken);
	}

	private static async Task<string[]> InternalReadAllLinesAsync(string path, Encoding encoding, CancellationToken cancellationToken)
	{
		using StreamReader sr = AsyncStreamReader(path, encoding);
		cancellationToken.ThrowIfCancellationRequested();
		List<string> lines = new List<string>();
		string item;
		while ((item = await sr.ReadLineAsync().ConfigureAwait(continueOnCapturedContext: false)) != null)
		{
			lines.Add(item);
			cancellationToken.ThrowIfCancellationRequested();
		}
		return lines.ToArray();
	}

	public static Task WriteAllLinesAsync(string path, IEnumerable<string> contents, CancellationToken cancellationToken = default(CancellationToken))
	{
		return WriteAllLinesAsync(path, contents, UTF8NoBOM, cancellationToken);
	}

	public static Task WriteAllLinesAsync(string path, IEnumerable<string> contents, Encoding encoding, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (contents == null)
		{
			throw new ArgumentNullException("contents");
		}
		if (encoding == null)
		{
			throw new ArgumentNullException("encoding");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		if (!cancellationToken.IsCancellationRequested)
		{
			return InternalWriteAllLinesAsync(AsyncStreamWriter(path, encoding, append: false), contents, cancellationToken);
		}
		return Task.FromCanceled(cancellationToken);
	}

	private static async Task InternalWriteAllLinesAsync(TextWriter writer, IEnumerable<string> contents, CancellationToken cancellationToken)
	{
		using (writer)
		{
			foreach (string content in contents)
			{
				cancellationToken.ThrowIfCancellationRequested();
				await writer.WriteLineAsync(content).ConfigureAwait(continueOnCapturedContext: false);
			}
			cancellationToken.ThrowIfCancellationRequested();
			await writer.FlushAsync().ConfigureAwait(continueOnCapturedContext: false);
		}
	}

	private static async Task InternalWriteAllTextAsync(StreamWriter sw, string contents, CancellationToken cancellationToken)
	{
		char[] buffer = null;
		try
		{
			buffer = ArrayPool<char>.Shared.Rent(4096);
			int count = contents.Length;
			int batchSize;
			for (int index = 0; index < count; index += batchSize)
			{
				batchSize = Math.Min(4096, count - index);
				contents.CopyTo(index, buffer, 0, batchSize);
				await sw.WriteAsync(new ReadOnlyMemory<char>(buffer, 0, batchSize), cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			}
			cancellationToken.ThrowIfCancellationRequested();
			await sw.FlushAsync().ConfigureAwait(continueOnCapturedContext: false);
		}
		finally
		{
			sw.Dispose();
			if (buffer != null)
			{
				ArrayPool<char>.Shared.Return(buffer);
			}
		}
	}

	public static Task AppendAllTextAsync(string path, string contents, CancellationToken cancellationToken = default(CancellationToken))
	{
		return AppendAllTextAsync(path, contents, UTF8NoBOM, cancellationToken);
	}

	public static Task AppendAllTextAsync(string path, string contents, Encoding encoding, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (encoding == null)
		{
			throw new ArgumentNullException("encoding");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		if (cancellationToken.IsCancellationRequested)
		{
			return Task.FromCanceled(cancellationToken);
		}
		if (string.IsNullOrEmpty(contents))
		{
			new FileStream(path, FileMode.Append, FileAccess.Write, FileShare.Read).Dispose();
			return Task.CompletedTask;
		}
		return InternalWriteAllTextAsync(AsyncStreamWriter(path, encoding, append: true), contents, cancellationToken);
	}

	public static Task AppendAllLinesAsync(string path, IEnumerable<string> contents, CancellationToken cancellationToken = default(CancellationToken))
	{
		return AppendAllLinesAsync(path, contents, UTF8NoBOM, cancellationToken);
	}

	public static Task AppendAllLinesAsync(string path, IEnumerable<string> contents, Encoding encoding, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (contents == null)
		{
			throw new ArgumentNullException("contents");
		}
		if (encoding == null)
		{
			throw new ArgumentNullException("encoding");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Empty path name is not legal.", "path");
		}
		if (!cancellationToken.IsCancellationRequested)
		{
			return InternalWriteAllLinesAsync(AsyncStreamWriter(path, encoding, append: true), contents, cancellationToken);
		}
		return Task.FromCanceled(cancellationToken);
	}

	public static FileStream Create(string path, int bufferSize, FileOptions options, FileSecurity fileSecurity)
	{
		return new FileStream(path, FileMode.Create, FileAccess.ReadWrite, FileShare.None, bufferSize, options);
	}

	public static FileSecurity GetAccessControl(string path)
	{
		return GetAccessControl(path, AccessControlSections.Access | AccessControlSections.Owner | AccessControlSections.Group);
	}

	public static FileSecurity GetAccessControl(string path, AccessControlSections includeSections)
	{
		return new FileSecurity(path, includeSections);
	}

	public static void SetAccessControl(string path, FileSecurity fileSecurity)
	{
		if (fileSecurity == null)
		{
			throw new ArgumentNullException("fileSecurity");
		}
		fileSecurity.PersistModifications(path);
	}
}
