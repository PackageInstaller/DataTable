using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/CustomRenderTextureManager.h")]
public static class CustomRenderTextureManager
{
	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private static Action<CustomRenderTexture> textureLoaded;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private static Action<CustomRenderTexture> textureUnloaded;

	[RequiredByNativeCode]
	private static void InvokeOnTextureLoaded_Internal(CustomRenderTexture source)
	{
		textureLoaded?.Invoke(source);
	}

	[RequiredByNativeCode]
	private static void InvokeOnTextureUnloaded_Internal(CustomRenderTexture source)
	{
		textureUnloaded?.Invoke(source);
	}
}
