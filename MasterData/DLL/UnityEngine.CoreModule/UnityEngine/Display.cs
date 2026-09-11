using System;
using System.ComponentModel;
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

	public RenderBuffer colorBuffer
	{
		get
		{
			GetRenderingBuffersImpl(nativeDisplay, out var color, out var _);
			return color;
		}
	}

	public RenderBuffer depthBuffer
	{
		get
		{
			GetRenderingBuffersImpl(nativeDisplay, out var _, out var depth);
			return depth;
		}
	}

	public bool active => GetActiveImpl(nativeDisplay);

	public bool requiresBlitToBackbuffer
	{
		get
		{
			int num = nativeDisplay.ToInt32();
			if (num < HDROutputSettings.displays.Length && HDROutputSettings.displays[num].available && HDROutputSettings.displays[num].active)
			{
				return true;
			}
			return RequiresBlitToBackbufferImpl(nativeDisplay);
		}
	}

	public bool requiresSrgbBlitToBackbuffer => RequiresSrgbBlitToBackbufferImpl(nativeDisplay);

	public static Display main => _mainDisplay;

	public static int activeEditorGameViewTarget
	{
		get
		{
			return m_ActiveEditorGameViewTarget;
		}
		internal set
		{
			m_ActiveEditorGameViewTarget = value;
		}
	}

	public static event DisplaysUpdatedDelegate onDisplaysUpdated = null;

	internal Display()
	{
		nativeDisplay = new IntPtr(0);
	}

	internal Display(IntPtr nativeDisplay)
	{
		this.nativeDisplay = nativeDisplay;
	}

	public void Activate()
	{
		ActivateDisplayImpl(nativeDisplay, 0, 0, new RefreshRate
		{
			numerator = 60u,
			denominator = 1u
		});
	}

	public void Activate(int width, int height, RefreshRate refreshRate)
	{
		ActivateDisplayImpl(nativeDisplay, width, height, refreshRate);
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Activate(int, int, int) is deprecated. Use Activate(int, int, RefreshRate) instead.", false)]
	public void Activate(int width, int height, int refreshRate)
	{
		if (refreshRate < 0)
		{
			refreshRate = 0;
		}
		ActivateDisplayImpl(nativeDisplay, width, height, new RefreshRate
		{
			numerator = (uint)refreshRate,
			denominator = 1u
		});
	}

	public void SetParams(int width, int height, int x, int y)
	{
		SetParamsImpl(nativeDisplay, width, height, x, y);
	}

	public void SetRenderingResolution(int w, int h)
	{
		SetRenderingResolutionImpl(nativeDisplay, w, h);
	}

	[Obsolete("MultiDisplayLicense has been deprecated.", false)]
	public static bool MultiDisplayLicense()
	{
		return true;
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
	internal static void RecreateDisplayList(IntPtr[] nativeDisplay)
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
	internal static void FireDisplaysUpdated()
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
	[FreeFunction("UnityDisplayManager_GetRenderingBuffersWrapper")]
	private static extern void GetRenderingBuffersImpl(IntPtr nativeDisplay, out RenderBuffer color, out RenderBuffer depth);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityDisplayManager_SetRenderingResolution")]
	private static extern void SetRenderingResolutionImpl(IntPtr nativeDisplay, int w, int h);

	[FreeFunction("UnityDisplayManager_ActivateDisplay")]
	private static void ActivateDisplayImpl(IntPtr nativeDisplay, int width, int height, RefreshRate refreshRate)
	{
		ActivateDisplayImpl_Injected(nativeDisplay, width, height, ref refreshRate);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityDisplayManager_SetDisplayParam")]
	private static extern void SetParamsImpl(IntPtr nativeDisplay, int width, int height, int x, int y);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityDisplayManager_RelativeMouseAt")]
	private static extern int RelativeMouseAtImpl(int x, int y, out int rx, out int ry);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityDisplayManager_DisplayActive")]
	private static extern bool GetActiveImpl(IntPtr nativeDisplay);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityDisplayManager_RequiresBlitToBackbuffer")]
	private static extern bool RequiresBlitToBackbufferImpl(IntPtr nativeDisplay);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityDisplayManager_RequiresSRGBBlitToBackbuffer")]
	private static extern bool RequiresSrgbBlitToBackbufferImpl(IntPtr nativeDisplay);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void ActivateDisplayImpl_Injected(IntPtr nativeDisplay, int width, int height, ref RefreshRate refreshRate);
}
