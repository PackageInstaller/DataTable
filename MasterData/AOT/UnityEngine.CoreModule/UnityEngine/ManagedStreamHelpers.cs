using System;
using System.IO;
using UnityEngine.Scripting;

namespace UnityEngine;

internal static class ManagedStreamHelpers
{
	internal static void ValidateLoadFromStream(Stream stream)
	{
		if (stream == null)
		{
			throw new ArgumentNullException("ManagedStream object must be non-null", "stream");
		}
		if (!stream.CanRead)
		{
			throw new ArgumentException("ManagedStream object must be readable (stream.CanRead must return true)", "stream");
		}
		if (!stream.CanSeek)
		{
			throw new ArgumentException("ManagedStream object must be seekable (stream.CanSeek must return true)", "stream");
		}
	}

	[RequiredByNativeCode]
	internal unsafe static void ManagedStreamRead(byte[] buffer, int offset, int count, Stream stream, IntPtr returnValueAddress)
	{
		if (returnValueAddress == IntPtr.Zero)
		{
			throw new ArgumentException("Return value address cannot be 0.", "returnValueAddress");
		}
		ValidateLoadFromStream(stream);
		*(int*)(void*)returnValueAddress = stream.Read(buffer, offset, count);
	}

	[RequiredByNativeCode]
	internal unsafe static void ManagedStreamSeek(long offset, uint origin, Stream stream, IntPtr returnValueAddress)
	{
		if (returnValueAddress == IntPtr.Zero)
		{
			throw new ArgumentException("Return value address cannot be 0.", "returnValueAddress");
		}
		ValidateLoadFromStream(stream);
		*(long*)(void*)returnValueAddress = stream.Seek(offset, (SeekOrigin)origin);
	}

	[RequiredByNativeCode]
	internal unsafe static void ManagedStreamLength(Stream stream, IntPtr returnValueAddress)
	{
		if (returnValueAddress == IntPtr.Zero)
		{
			throw new ArgumentException("Return value address cannot be 0.", "returnValueAddress");
		}
		ValidateLoadFromStream(stream);
		*(long*)(void*)returnValueAddress = stream.Length;
	}
}
