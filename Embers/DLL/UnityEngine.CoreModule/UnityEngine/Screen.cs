using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Internal;

namespace UnityEngine;

[StaticAccessor(/*Could not decode attribute arguments.*/)]
[NativeHeader("Runtime/Graphics/GraphicsScriptBindings.h")]
[NativeHeader("Runtime/Graphics/ScreenManager.h")]
[NativeHeader("Runtime/Graphics/WindowLayout.h")]
public sealed class Screen
{
	public static extern int width
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(Name = "GetWidth", IsThreadSafe = true)]
		get;
	}

	public static extern int height
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(Name = "GetHeight", IsThreadSafe = true)]
		get;
	}

	public static extern float dpi
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("GetDPI")]
		get;
	}

	public static ScreenOrientation orientation
	{
		get
		{
			return GetScreenOrientation();
		}
		set
		{
			if (value == ScreenOrientation.Unknown)
			{
				Debug.Log("ScreenOrientation.Unknown is deprecated. Please use ScreenOrientation.AutoRotation");
				value = ScreenOrientation.AutoRotation;
			}
			RequestOrientation(value);
		}
	}

	[NativeProperty("ScreenTimeout")]
	public static extern int sleepTimeout
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static bool autorotateToPortrait
	{
		get
		{
			return IsOrientationEnabled(EnabledOrientation.kAutorotateToPortrait);
		}
		set
		{
			SetOrientationEnabled(EnabledOrientation.kAutorotateToPortrait, value);
		}
	}

	public static bool autorotateToPortraitUpsideDown
	{
		get
		{
			return IsOrientationEnabled(EnabledOrientation.kAutorotateToPortraitUpsideDown);
		}
		set
		{
			SetOrientationEnabled(EnabledOrientation.kAutorotateToPortraitUpsideDown, value);
		}
	}

	public static bool autorotateToLandscapeLeft
	{
		get
		{
			return IsOrientationEnabled(EnabledOrientation.kAutorotateToLandscapeLeft);
		}
		set
		{
			SetOrientationEnabled(EnabledOrientation.kAutorotateToLandscapeLeft, value);
		}
	}

	public static bool autorotateToLandscapeRight
	{
		get
		{
			return IsOrientationEnabled(EnabledOrientation.kAutorotateToLandscapeRight);
		}
		set
		{
			SetOrientationEnabled(EnabledOrientation.kAutorotateToLandscapeRight, value);
		}
	}

	public static Resolution currentResolution
	{
		get
		{
			get_currentResolution_Injected(out var ret);
			return ret;
		}
	}

	public static extern bool fullScreen
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("IsFullscreen")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("RequestSetFullscreenFromScript")]
		set;
	}

	public static extern FullScreenMode fullScreenMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("GetFullscreenMode")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("RequestSetFullscreenModeFromScript")]
		set;
	}

	public static Rect safeArea
	{
		get
		{
			get_safeArea_Injected(out var ret);
			return ret;
		}
	}

	public static extern Rect[] cutouts
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("ScreenScripting::GetCutouts")]
		get;
	}

	public static Vector2Int mainWindowPosition => Vector2Int.zero;

	public static DisplayInfo mainWindowDisplayInfo
	{
		get
		{
			throw new NotSupportedException("Screen.GetDisplayInfoForPoint is only supported on Linux, macOS and Windows Standalone.");
		}
	}

	public static extern Resolution[] resolutions
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("ScreenScripting::GetResolutions")]
		get;
	}

	public static extern float brightness
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Use Cursor.lockState and Cursor.visible instead.", false)]
	public static bool lockCursor
	{
		get
		{
			return CursorLockMode.Locked == Cursor.lockState;
		}
		set
		{
			if (value)
			{
				Cursor.visible = false;
				Cursor.lockState = CursorLockMode.Locked;
			}
			else
			{
				Cursor.lockState = CursorLockMode.None;
				Cursor.visible = true;
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void RequestOrientation(ScreenOrientation orient);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern ScreenOrientation GetScreenOrientation();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetIsOrientationEnabled")]
	private static extern bool IsOrientationEnabled(EnabledOrientation orient);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetIsOrientationEnabled")]
	private static extern void SetOrientationEnabled(EnabledOrientation orient, bool enabled);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("RequestResolution")]
	public static extern void SetResolution(int width, int height, FullScreenMode fullscreenMode, [UnityEngine.Internal.DefaultValue("0")] int preferredRefreshRate);

	public static void SetResolution(int width, int height, FullScreenMode fullscreenMode)
	{
		SetResolution(width, height, fullscreenMode, 0);
	}

	public static void SetResolution(int width, int height, bool fullscreen, [UnityEngine.Internal.DefaultValue("0")] int preferredRefreshRate)
	{
		SetResolution(width, height, fullscreen ? FullScreenMode.FullScreenWindow : FullScreenMode.Windowed, preferredRefreshRate);
	}

	public static void SetResolution(int width, int height, bool fullscreen)
	{
		SetResolution(width, height, fullscreen, 0);
	}

	public static void GetDisplayLayout(List<DisplayInfo> displayLayout)
	{
		if (displayLayout == null)
		{
			throw new ArgumentNullException();
		}
		throw new NotSupportedException("Screen.GetDisplayLayout() is only supported on Linux, macOS and Windows Standalone.");
	}

	public static AsyncOperation MoveMainWindowTo(in DisplayInfo display, Vector2Int position)
	{
		throw new NotSupportedException("Screen.MoveMainWindowTo() is only supported on Linux, macOS and Windows Standalone.");
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_currentResolution_Injected(out Resolution ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_safeArea_Injected(out Rect ret);
}
