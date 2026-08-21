using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace Unity.Profiling.Memory;

[NativeHeader("Modules/Profiler/Runtime/MemorySnapshotManager.h")]
public static class MemoryProfiler
{
	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private static Action<string, bool> m_SnapshotFinished;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private static Action<string, bool, DebugScreenCapture> m_SaveScreenshotToDisk;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private static Action<MemorySnapshotMetadata> CreatingMetadata;

	[RequiredByNativeCode]
	private unsafe static byte[] PrepareMetadata()
	{
		if (CreatingMetadata == null)
		{
			return new byte[0];
		}
		MemorySnapshotMetadata memorySnapshotMetadata = new MemorySnapshotMetadata();
		memorySnapshotMetadata.Description = string.Empty;
		CreatingMetadata(memorySnapshotMetadata);
		if (memorySnapshotMetadata.Description == null)
		{
			memorySnapshotMetadata.Description = "";
		}
		int num = 2 * memorySnapshotMetadata.Description.Length;
		int num2 = ((memorySnapshotMetadata.Data != null) ? memorySnapshotMetadata.Data.Length : 0);
		int num3 = num + num2 + 12;
		byte[] array = new byte[num3];
		int offset = 0;
		offset = WriteIntToByteArray(array, offset, memorySnapshotMetadata.Description.Length);
		offset = WriteStringToByteArray(array, offset, memorySnapshotMetadata.Description);
		offset = WriteIntToByteArray(array, offset, num2);
		fixed (byte* data = memorySnapshotMetadata.Data)
		{
			fixed (byte* ptr = array)
			{
				byte* destination = ptr + offset;
				UnsafeUtility.MemCpy(destination, data, num2);
			}
		}
		return array;
	}

	internal unsafe static int WriteIntToByteArray(byte[] array, int offset, int value)
	{
		byte* ptr = (byte*)(&value);
		array[offset++] = *ptr;
		array[offset++] = ptr[1];
		array[offset++] = ptr[2];
		array[offset++] = ptr[3];
		return offset;
	}

	internal unsafe static int WriteStringToByteArray(byte[] array, int offset, string value)
	{
		if (value.Length != 0)
		{
			fixed (char* ptr = value)
			{
				char* ptr2 = ptr;
				for (char* ptr3 = ptr + value.Length; ptr2 != ptr3; ptr2++)
				{
					for (int i = 0; i < 2; i++)
					{
						array[offset++] = ((byte*)ptr2)[i];
					}
				}
			}
		}
		return offset;
	}

	[RequiredByNativeCode]
	private static void FinalizeSnapshot(string path, bool result)
	{
		if (m_SnapshotFinished != null)
		{
			Action<string, bool> snapshotFinished = m_SnapshotFinished;
			m_SnapshotFinished = null;
			snapshotFinished(path, result);
		}
	}

	[RequiredByNativeCode]
	private unsafe static void SaveScreenshotToDisk(string path, bool result, IntPtr pixelsPtr, int pixelsCount, TextureFormat format, int width, int height)
	{
		if (m_SaveScreenshotToDisk != null)
		{
			Action<string, bool, DebugScreenCapture> saveScreenshotToDisk = m_SaveScreenshotToDisk;
			m_SaveScreenshotToDisk = null;
			DebugScreenCapture arg = default(DebugScreenCapture);
			if (result)
			{
				NativeArray<byte> rawImageDataReference = NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<byte>(pixelsPtr.ToPointer(), pixelsCount, Allocator.Persistent);
				arg.RawImageDataReference = rawImageDataReference;
				arg.Height = height;
				arg.Width = width;
				arg.ImageFormat = format;
			}
			saveScreenshotToDisk(path, result, arg);
		}
	}
}
