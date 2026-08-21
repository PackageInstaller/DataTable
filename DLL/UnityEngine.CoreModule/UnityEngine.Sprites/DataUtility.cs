namespace UnityEngine.Sprites;

public sealed class DataUtility
{
	public static Vector4 GetInnerUV(Sprite sprite)
	{
		return sprite.GetInnerUVs();
	}

	public static Vector4 GetOuterUV(Sprite sprite)
	{
		return sprite.GetOuterUVs();
	}

	public static Vector4 GetPadding(Sprite sprite)
	{
		return sprite.GetPadding();
	}

	public static Vector2 GetMinSize(Sprite sprite)
	{
		Vector2 result = default(Vector2);
		result.x = sprite.border.x + sprite.border.z;
		result.y = sprite.border.y + sprite.border.w;
		return result;
	}
}
