using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.Windows.WebCam;

[StructLayout(LayoutKind.Sequential)]
[NativeHeader("PlatformDependent/Win/Webcam/VideoCaptureBindings.h")]
[StaticAccessor("VideoCaptureBindings", StaticAccessorType.DoubleColon)]
[MovedFrom("UnityEngine.XR.WSA.WebCam")]
public class VideoCapture : IDisposable
{
	public enum CaptureResultType
	{
		Success,
		UnknownError
	}

	public struct VideoCaptureResult
	{
		public CaptureResultType resultType;

		public long hResult;
	}

	public delegate void OnVideoCaptureResourceCreatedCallback(VideoCapture captureObject);

	public delegate void OnVideoModeStartedCallback(VideoCaptureResult result);

	public delegate void OnVideoModeStoppedCallback(VideoCaptureResult result);

	public delegate void OnStartedRecordingVideoCallback(VideoCaptureResult result);

	public delegate void OnStoppedRecordingVideoCallback(VideoCaptureResult result);

	internal IntPtr m_NativePtr;

	private static readonly long HR_SUCCESS;

	private static VideoCaptureResult MakeCaptureResult(long hResult)
	{
		VideoCaptureResult result = default(VideoCaptureResult);
		CaptureResultType resultType = ((hResult != HR_SUCCESS) ? CaptureResultType.UnknownError : CaptureResultType.Success);
		result.resultType = resultType;
		result.hResult = hResult;
		return result;
	}

	[RequiredByNativeCode]
	private static void InvokeOnCreatedVideoCaptureResourceDelegate(OnVideoCaptureResourceCreatedCallback callback, IntPtr nativePtr)
	{
		if (nativePtr == IntPtr.Zero)
		{
			callback(null);
		}
		else
		{
			callback(new VideoCapture(nativePtr));
		}
	}

	private VideoCapture(IntPtr nativeCaptureObject)
	{
		m_NativePtr = nativeCaptureObject;
	}

	[RequiredByNativeCode]
	private static void InvokeOnVideoModeStartedDelegate(OnVideoModeStartedCallback callback, long hResult)
	{
		callback(MakeCaptureResult(hResult));
	}

	[RequiredByNativeCode]
	private static void InvokeOnVideoModeStoppedDelegate(OnVideoModeStoppedCallback callback, long hResult)
	{
		callback(MakeCaptureResult(hResult));
	}

	[RequiredByNativeCode]
	private static void InvokeOnStartedRecordingVideoToDiskDelegate(OnStartedRecordingVideoCallback callback, long hResult)
	{
		callback(MakeCaptureResult(hResult));
	}

	[RequiredByNativeCode]
	private static void InvokeOnStoppedRecordingVideoToDiskDelegate(OnStoppedRecordingVideoCallback callback, long hResult)
	{
		callback(MakeCaptureResult(hResult));
	}

	public void Dispose()
	{
		if (m_NativePtr != IntPtr.Zero)
		{
			Dispose_Internal();
			m_NativePtr = IntPtr.Zero;
		}
		GC.SuppressFinalize(this);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("VideoCaptureBindings::Dispose", HasExplicitThis = true)]
	[NativeConditional("(PLATFORM_WIN || PLATFORM_WINRT) && !PLATFORM_XBOXONE")]
	private extern void Dispose_Internal();

	~VideoCapture()
	{
		if (m_NativePtr != IntPtr.Zero)
		{
			DisposeThreaded_Internal();
			m_NativePtr = IntPtr.Zero;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("VideoCaptureBindings::DisposeThreaded", HasExplicitThis = true)]
	[ThreadAndSerializationSafe]
	[NativeConditional("(PLATFORM_WIN || PLATFORM_WINRT) && !PLATFORM_XBOXONE")]
	private extern void DisposeThreaded_Internal();
}
