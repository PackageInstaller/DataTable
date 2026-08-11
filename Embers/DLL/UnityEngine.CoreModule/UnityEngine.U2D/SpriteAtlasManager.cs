using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.U2D;

[NativeHeader("Runtime/2D/SpriteAtlas/SpriteAtlasManager.h")]
[StaticAccessor(/*Could not decode attribute arguments.*/)]
[NativeHeader("Runtime/2D/SpriteAtlas/SpriteAtlas.h")]
public class SpriteAtlasManager
{
	public static event Action<string, Action<SpriteAtlas>> atlasRequested;

	public static event Action<SpriteAtlas> atlasRegistered;

	[RequiredByNativeCode]
	private static bool RequestAtlas(string tag)
	{
		if (atlasRequested != null)
		{
			atlasRequested(tag, Register);
			return true;
		}
		return false;
	}

	[RequiredByNativeCode]
	private static void PostRegisteredAtlas(SpriteAtlas spriteAtlas)
	{
		atlasRegistered?.Invoke(spriteAtlas);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern void Register(SpriteAtlas spriteAtlas);
}
