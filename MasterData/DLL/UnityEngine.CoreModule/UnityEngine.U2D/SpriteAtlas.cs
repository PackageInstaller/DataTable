using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine.U2D;

[NativeHeader("Runtime/Graphics/SpriteFrame.h")]
[NativeType(Header = "Runtime/2D/SpriteAtlas/SpriteAtlas.h")]
public class SpriteAtlas : Object
{
	public extern bool isVariant
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("IsVariant")]
		get;
	}

	public extern string tag
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern int spriteCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern bool CanBindTo([NotNull("ArgumentNullException")] Sprite sprite);

	[MethodImpl((MethodImplOptions)4096)]
	public extern Sprite GetSprite(string name);

	public int GetSprites(Sprite[] sprites)
	{
		return GetSpritesScripting(sprites);
	}

	public int GetSprites(Sprite[] sprites, string name)
	{
		return GetSpritesWithNameScripting(sprites, name);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern int GetSpritesScripting([Unmarshalled] Sprite[] sprites);

	[MethodImpl((MethodImplOptions)4096)]
	private extern int GetSpritesWithNameScripting([Unmarshalled] Sprite[] sprites, string name);
}
