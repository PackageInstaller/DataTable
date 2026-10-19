using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMTexture_Children
{
	public static Texture2D Color(this HUMTexture.Data.Create texture, Color color)
	{
		return texture.texture.Color(color);
	}

	public static Texture2D Tint(this HUMTexture.Data.Create texture, Color color, float amount)
	{
		return texture.Tint(color, amount);
	}
}
