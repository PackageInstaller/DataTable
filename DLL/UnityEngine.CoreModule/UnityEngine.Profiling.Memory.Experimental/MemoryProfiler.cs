using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Profiling.Experimental;
using UnityEngine.Scripting;

namespace UnityEngine.Profiling.Memory.Experimental;

[NativeHeader("Modules/Profiler/Runtime/MemorySnapshotManager.h")]
public sealed class MemoryProfiler
{
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private static Action<string, bool> m_SnapshotFinished;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private static Action<string, bool, DebugScreenCapture> m_SaveScreenshotToDisk;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private static Action<MetaData> createMetaData;

	[RequiredByNativeCode]
	private static byte[] PrepareMetadata()
	{
		if (createMetaData == null)
		{
			return new byte[0];
		}
		MetaData metaData = new MetaData();
		createMetaData(metaData);
		if (metaData.content == null)
		{
			metaData.content = "";
		}
		if (metaData.platform == null)
		{
			metaData.platform = "";
		}
		int num = 2 * metaData.content.Length;
		int num2 = 2 * metaData.platform.Length;
		int num3 = num + num2 + 12;
		byte[] array = new byte[num3];
		int offset = 0;
		offset = WriteIntToByteArray(array, offset, metaData.content.Length);
		offset = WriteStringToByteArray(array, offset, metaData.content);
		offset = WriteIntToByteArray(array, offset, metaData.platform.Length);
		offset = WriteStringToByteArray(array, offset, metaData.platform);
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
				arg.rawImageDataReference = rawImageDataReference;
				arg.height = height;
				arg.width = width;
				arg.imageFormat = format;
			}
			saveScreenshotToDisk(path, result, arg);
		}
	}
}
