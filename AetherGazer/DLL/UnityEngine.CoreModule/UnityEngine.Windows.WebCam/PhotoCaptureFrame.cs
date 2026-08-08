using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.Windows.WebCam;

[MovedFrom("UnityEngine.XR.WSA.WebCam")]
[NativeConditional("(PLATFORM_WIN || PLATFORM_WINRT) && !PLATFORM_XBOXONE")]
[NativeHeader("PlatformDependent/Win/Webcam/PhotoCaptureFrame.h")]
public sealed class PhotoCaptureFrame : IDisposable
{
	private IntPtr m_NativePtr;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private bool _003ChasLocationData_003Ek__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private CapturePixelFormat _003CpixelFormat_003Ek__BackingField;

	public int dataLength { get; private set; }

	private bool hasLocationData
	{
		[CompilerGenerated]
		set
		{
			_003ChasLocationData_003Ek__BackingField = value;
		}
	}

	private CapturePixelFormat pixelFormat
	{
		[CompilerGenerated]
		set
		{
			_003CpixelFormat_003Ek__BackingField = value;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadAndSerializationSafe]
	private extern int GetDataLength();

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadAndSerializationSafe]
	private extern bool GetHasLocationData();

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadAndSerializationSafe]
	private extern CapturePixelFormat GetCapturePixelFormat();

	internal PhotoCaptureFrame(IntPtr nativePtr)
	{
		m_NativePtr = nativePtr;
		dataLength = GetDataLength();
		hasLocationData = GetHasLocationData();
		pixelFormat = GetCapturePixelFormat();
		GC.AddMemoryPressure(dataLength);
	}

	private void Cleanup()
	{
		if (m_NativePtr != IntPtr.Zero)
		{
			GC.RemoveMemoryPressure(dataLength);
			Dispose_Internal();
			m_NativePtr = IntPtr.Zero;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadAndSerializationSafe]
	[NativeConditional("(PLATFORM_WIN || PLATFORM_WINRT) && !PLATFORM_XBOXONE")]
	[NativeName("Dispose")]
	private extern void Dispose_Internal();

	public void Dispose()
	{
		Cleanup();
		GC.SuppressFinalize(this);
	}

	~PhotoCaptureFrame()
	{
		Cleanup();
	}
}
