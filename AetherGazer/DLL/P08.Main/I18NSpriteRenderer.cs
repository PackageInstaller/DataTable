using UnityEngine;

[RequireComponent(typeof(SpriteRenderer))]
public class I18NSpriteRenderer : MonoBehaviour
{
	public SpriteRenderer spriteRenderer;

	[SerializeField]
	private string spriteAssetPath = "";

	[SerializeField]
	private string spriteName = "";

	[SerializeField]
	private SPRITE_ASSET_TYPE spriteType;

	private void Start()
	{
		if (spriteRenderer == null)
		{
			spriteRenderer = base.gameObject.GetComponent<SpriteRenderer>();
		}
		RefreshSprite();
	}

	private void RefreshSprite()
	{
		Sprite sprite = I18NConfigManager.GetSprite(spriteType, spriteAssetPath, spriteName);
		if (sprite != null)
		{
			spriteRenderer.sprite = sprite;
		}
	}
}
