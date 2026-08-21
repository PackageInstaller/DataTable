using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Export/Input/Cursor.bindings.h")]
public class Cursor
{
	public static extern bool visible
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern CursorLockMode lockState
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	private static void SetCursor(Texture2D texture, CursorMode cursorMode)
	{
		SetCursor(texture, Vector2.zero, cursorMode);
	}

	public static void SetCursor(Texture2D texture, Vector2 hotspot, CursorMode cursorMode)
	{
		SetCursor_Injected(texture, ref hotspot, cursorMode);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetCursor_Injected(Texture2D texture, ref Vector2 hotspot, CursorMode cursorMode);
}
