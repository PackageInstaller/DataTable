using UnityEngine;

public class AdaptiveServantSprite : MonoBehaviour
{
	public SpriteRenderer renderComps;

	private Material mat;

	public float editorScale = 1f;

	private void Awake()
	{
		mat = renderComps.material;
	}

	public void SetSprite(Sprite newSprite, bool customOffsetX = false, bool customOffsetY = false, float offsetX = 0f, float offsetY = 0f, bool customTiling = false, float tilingScale = 1f)
	{
		if (newSprite != null)
		{
			Sprite sprite = Sprite.Create(newSprite.texture, newSprite.rect, 0.5f * Vector2.one, 10f, 1u, SpriteMeshType.FullRect);
			int width = sprite.texture.width;
			int height = sprite.texture.height;
			bool flag = ((width > height) ? true : false);
			float num = 1f * (float)Mathf.Min(width, height) / (1f * (float)Mathf.Max(width, height));
			if (customTiling & customOffsetX & customOffsetY)
			{
				mat.SetTextureScale("_MainTex", new Vector2((flag ? num : 1f) * tilingScale, (flag ? 1f : num) * tilingScale));
				mat.SetTextureOffset("_MainTex", new Vector2(offsetX, offsetY));
			}
			else
			{
				mat.SetTextureScale("_MainTex", new Vector2(flag ? num : 1f, flag ? 1f : num));
				float x = 0.03f;
				float y = 0f;
				mat.SetTextureOffset("_MainTex", new Vector2(x, y));
			}
			renderComps.sprite = sprite;
		}
	}

	private void OnDestroy()
	{
		Object.DestroyImmediate(mat);
	}
}
