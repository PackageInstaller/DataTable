using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.Windows.WebCam;

[StructLayout(LayoutKind.Sequential)]
[NativeHeader("PlatformDependent/Win/Webcam/PhotoCapture.h")]
[MovedFrom("UnityEngine.XR.WSA.WebCam")]
[StaticAccessor("PhotoCapture", StaticAccessorType.DoubleColon)]
public class PhotoCapture : IDisposable
{
	public enum CaptureResultType
	{
		Success,
		UnknownError
	}

	public struct PhotoCaptureResult
	{
		public CaptureResultType resultType;

		public long hResult;
	}

	public delegate void OnCaptureResourceCreatedCallback(PhotoCapture captureObject);

	public delegate void OnPhotoModeStartedCallback(PhotoCaptureResult result);

	public delegate void OnPhotoModeStoppedCallback(PhotoCaptureResult result);

	public delegate void OnCapturedToDiskCallback(PhotoCaptureResult result);

	public delegate void OnCapturedToMemoryCallback(PhotoCaptureResult result, PhotoCaptureFrame photoCaptureFrame);

	internal IntPtr m_NativePtr;

	private static readonly long HR_SUCCESS;

	private static PhotoCaptureResult MakeCaptureResult(long hResult)
	{
		PhotoCaptureResult result = default(PhotoCaptureResult);
		CaptureResultType resultType = ((hResult != HR_SUCCESS) ? CaptureResultType.UnknownError : CaptureResultType.Success);
		result.resultType = resultType;
		result.hResult = hResult;
		return result;
	}

	[RequiredByNativeCode]
	private static void InvokeOnCreatedResourceDelegate(OnCaptureResourceCreatedCallback callback, IntPtr nativePtr)
	{
		if (nativePtr == IntPtr.Zero)
		{
			callback(null);
		}
		else
		{
			callback(new PhotoCapture(nativePtr));
		}
	}

	private PhotoCapture(IntPtr nativeCaptureObject)
	{
		m_NativePtr = nativeCaptureObject;
	}

	[RequiredByNativeCode]
	private static void InvokeOnPhotoModeStartedDelegate(OnPhotoModeStartedCallback callback, long hResult)
	{
		callback(MakeCaptureResult(hResult));
	}

	[RequiredByNativeCode]
	private static void InvokeOnPhotoModeStoppedDelegate(OnPhotoModeStoppedCallback callback, long hResult)
	{
		callback(MakeCaptureResult(hResult));
	}

	[RequiredByNativeCode]
	private static void InvokeOnCapturedPhotoToDiskDelegate(OnCapturedToDiskCallback callback, long hResult)
	{
		callback(MakeCaptureResult(hResult));
	}

	[RequiredByNativeCode]
	private static void InvokeOnCapturedPhotoToMemoryDelegate(OnCapturedToMemoryCallback callback, long hResult, IntPtr photoCaptureFramePtr)
	{
		PhotoCaptureFrame photoCaptureFrame = null;
		if (photoCaptureFramePtr != IntPtr.Zero)
		{
			photoCaptureFrame = new PhotoCaptureFrame(photoCaptureFramePtr);
		}
		callback(MakeCaptureResult(hResult), photoCaptureFrame);
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
	[NativeName("Dispose")]
	[NativeConditional("(PLATFORM_WIN || PLATFORM_WINRT) && !PLATFORM_XBOXONE")]
	private extern void Dispose_Internal();

	~PhotoCapture()
	{
		if (m_NativePtr != IntPtr.Zero)
		{
			DisposeThreaded_Internal();
			m_NativePtr = IntPtr.Zero;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadAndSerializationSafe]
	[NativeConditional("(PLATFORM_WIN || PLATFORM_WINRT) && !PLATFORM_XBOXONE")]
	[NativeName("DisposeThreaded")]
	private extern void DisposeThreaded_Internal();
}
