using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/DisplayManager.h")]
[UsedByNativeCode]
public class Display
{
	public delegate void DisplaysUpdatedDelegate();

	internal IntPtr nativeDisplay;

	public static Display[] displays = new Display[1]
	{
		new Display()
	};

	private static Display _mainDisplay = displays[0];

	private static int m_ActiveEditorGameViewTarget = -1;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private static DisplaysUpdatedDelegate onDisplaysUpdated = null;

	public int renderingWidth
	{
		get
		{
			int w = 0;
			int h = 0;
			GetRenderingExtImpl(nativeDisplay, out w, out h);
			return w;
		}
	}

	public int renderingHeight
	{
		get
		{
			int w = 0;
			int h = 0;
			GetRenderingExtImpl(nativeDisplay, out w, out h);
			return h;
		}
	}

	public int systemWidth
	{
		get
		{
			int w = 0;
			int h = 0;
			GetSystemExtImpl(nativeDisplay, out w, out h);
			return w;
		}
	}

	public int systemHeight
	{
		get
		{
			int w = 0;
			int h = 0;
			GetSystemExtImpl(nativeDisplay, out w, out h);
			return h;
		}
	}

	public bool active => GetActiveImpl(nativeDisplay);

	public bool requiresSrgbBlitToBackbuffer => RequiresSrgbBlitToBackbufferImpl(nativeDisplay);

	public static Display main => _mainDisplay;

	internal Display()
	{
		nativeDisplay = new IntPtr(0);
	}

	internal Display(IntPtr nativeDisplay)
	{
		this.nativeDisplay = nativeDisplay;
	}

	public static Vector3 RelativeMouseAt(Vector3 inputMouseCoordinates)
	{
		int rx = 0;
		int ry = 0;
		int x = (int)inputMouseCoordinates.x;
		int y = (int)inputMouseCoordinates.y;
		Vector3 result = default(Vector3);
		result.z = RelativeMouseAtImpl(x, y, out rx, out ry);
		result.x = rx;
		result.y = ry;
		return result;
	}

	[RequiredByNativeCode]
	private static void RecreateDisplayList(IntPtr[] nativeDisplay)
	{
		if (nativeDisplay.Length != 0)
		{
			displays = new Display[nativeDisplay.Length];
			for (int i = 0; i < nativeDisplay.Length; i++)
			{
				displays[i] = new Display(nativeDisplay[i]);
			}
			_mainDisplay = displays[0];
		}
	}

	[RequiredByNativeCode]
	private static void FireDisplaysUpdated()
	{
		if (onDisplaysUpdated != null)
		{
			onDisplaysUpdated();
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityDisplayManager_DisplaySystemResolution")]
	private static extern void GetSystemExtImpl(IntPtr nativeDisplay, out int w, out int h);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityDisplayManager_DisplayRenderingResolution")]
	private static extern void GetRenderingExtImpl(IntPtr nativeDisplay, out int w, out int h);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityDisplayManager_RelativeMouseAt")]
	private static extern int RelativeMouseAtImpl(int x, int y, out int rx, out int ry);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityDisplayManager_DisplayActive")]
	private static extern bool GetActiveImpl(IntPtr nativeDisplay);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityDisplayManager_RequiresSRGBBlitToBackbuffer")]
	private static extern bool RequiresSrgbBlitToBackbufferImpl(IntPtr nativeDisplay);
}
