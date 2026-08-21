using System;
using System.IO;
using ICSharpCode.SharpZipLib.GZip;
using ICSharpCode.SharpZipLib.Zip.Compression.Streams;

namespace GameFramework.Runtime;

public class DefaultCompressionHelper : Utility.Compression.ICompressionHelper
{
	private const int CachedBytesLength = 4096;

	private readonly byte[] m_CachedBytes = new byte[4096];

	public bool Compress(byte[] bytes, int offset, int length, Stream compressedStream)
	{
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Expected O, but got Unknown
		if (bytes == null)
		{
			return false;
		}
		if (offset < 0 || length < 0 || offset + length > bytes.Length)
		{
			return false;
		}
		if (compressedStream == null)
		{
			return false;
		}
		try
		{
			GZipOutputStream val = new GZipOutputStream(compressedStream);
			((Stream)(object)val).Write(bytes, offset, length);
			((DeflaterOutputStream)val).Finish();
			ProcessHeader(compressedStream);
			return true;
		}
		catch
		{
			return false;
		}
	}

	public bool Compress(Stream stream, Stream compressedStream)
	{
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Expected O, but got Unknown
		if (stream == null)
		{
			return false;
		}
		if (compressedStream == null)
		{
			return false;
		}
		try
		{
			GZipOutputStream val = new GZipOutputStream(compressedStream);
			int num = 0;
			while ((num = stream.Read(m_CachedBytes, 0, 4096)) > 0)
			{
				((Stream)(object)val).Write(m_CachedBytes, 0, num);
			}
			((DeflaterOutputStream)val).Finish();
			ProcessHeader(compressedStream);
			return true;
		}
		catch
		{
			return false;
		}
		finally
		{
			Array.Clear(m_CachedBytes, 0, 4096);
		}
	}

	public bool Decompress(byte[] bytes, int offset, int length, Stream decompressedStream)
	{
		//IL_0051: Unknown result type (might be due to invalid IL or missing references)
		//IL_0058: Expected O, but got Unknown
		if (bytes == null)
		{
			return false;
		}
		if (offset < 0 || length < 0 || offset + length > bytes.Length)
		{
			return false;
		}
		if (decompressedStream == null)
		{
			return false;
		}
		MemoryStream memoryStream = null;
		try
		{
			memoryStream = new MemoryStream(bytes, offset, length, writable: false);
			GZipInputStream val = new GZipInputStream((Stream)memoryStream);
			try
			{
				int num = 0;
				while ((num = ((Stream)(object)val).Read(m_CachedBytes, 0, 4096)) > 0)
				{
					decompressedStream.Write(m_CachedBytes, 0, num);
				}
			}
			finally
			{
				((IDisposable)val)?.Dispose();
			}
			return true;
		}
		catch
		{
			return false;
		}
		finally
		{
			if (memoryStream != null)
			{
				memoryStream.Dispose();
				memoryStream = null;
			}
			Array.Clear(m_CachedBytes, 0, 4096);
		}
	}

	public bool Decompress(Stream stream, Stream decompressedStream)
	{
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Expected O, but got Unknown
		if (stream == null)
		{
			return false;
		}
		if (decompressedStream == null)
		{
			return false;
		}
		try
		{
			GZipInputStream val = new GZipInputStream(stream);
			int num = 0;
			while ((num = ((Stream)(object)val).Read(m_CachedBytes, 0, 4096)) > 0)
			{
				decompressedStream.Write(m_CachedBytes, 0, num);
			}
			return true;
		}
		catch
		{
			return false;
		}
		finally
		{
			Array.Clear(m_CachedBytes, 0, 4096);
		}
	}

	private static void ProcessHeader(Stream compressedStream)
	{
		if (compressedStream.Length >= 8)
		{
			long position = compressedStream.Position;
			compressedStream.Position = 4L;
			compressedStream.WriteByte(25);
			compressedStream.WriteByte(134);
			compressedStream.WriteByte(2);
			compressedStream.WriteByte(32);
			compressedStream.Position = position;
		}
	}
}
