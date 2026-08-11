using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.InputSystem.Utilities;

internal static class SpriteUtilities
{
	public unsafe static Sprite CreateCircleSprite(int radius, Color32 colour)
	{
		int num = radius * 2;
		Texture2D texture2D = new Texture2D(num, num, DefaultFormat.LDR, TextureCreationFlags.None);
		NativeArray<Color32> rawTextureData = texture2D.GetRawTextureData<Color32>();
		Color32* unsafePtr = (Color32*)rawTextureData.GetUnsafePtr();
		UnsafeUtility.MemSet(unsafePtr, 0, rawTextureData.Length * UnsafeUtility.SizeOf<Color32>());
		uint* ptr = (uint*)UnsafeUtility.AddressOf(ref colour);
		ulong num2 = (ulong)((*(long*)ptr << 32) | *ptr);
		float num3 = radius * radius;
		for (int i = -radius; i < radius; i++)
		{
			int num4 = (int)Mathf.Sqrt(num3 - (float)(i * i));
			Color32* ptr2 = unsafePtr + (i + radius) * num + radius - num4;
			for (int j = 0; j < num4; j++)
			{
				*(ulong*)ptr2 = num2;
				ptr2 += 2;
			}
		}
		texture2D.Apply();
		return Sprite.Create(texture2D, new Rect(0f, 0f, num, num), new Vector2(radius, radius), 1f, 0u, SpriteMeshType.FullRect);
	}
}
