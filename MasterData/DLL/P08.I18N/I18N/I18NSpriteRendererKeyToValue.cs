using UnityEngine;

namespace I18N;

[DisallowMultipleComponent]
public class I18NSpriteRendererKeyToValue : MonoBehaviour
{
	[SerializeField]
	private string spriteAssetPath = "";

	[SerializeField]
	private string spriteName = "";

	[SerializeField]
	private SPRITE_ASSET_TYPE spriteType;

	private SpriteRenderer spriteRenderer;

	private void Awake()
	{
		if (Application.isPlaying)
		{
			RefreshSprite();
		}
	}

	private void RefreshSprite()
	{
		if (!spriteRenderer)
		{
			spriteRenderer = base.gameObject.GetComponent<SpriteRenderer>();
		}
		Sprite sprite = I18NConfigManager.GetSprite(spriteType, spriteAssetPath, spriteName);
		if (sprite != null)
		{
			spriteRenderer.sprite = sprite;
		}
	}

	public void SetSpriteAssetPath(string inputSpriteAssetPath)
	{
		spriteAssetPath = inputSpriteAssetPath;
	}

	public string GetSpriteAssetPath()
	{
		return spriteAssetPath;
	}

	public void SetSpriteName(string inputSpriteName)
	{
		spriteName = inputSpriteName;
	}

	public string GetSpriteName()
	{
		return spriteName;
	}

	public void SetSpriteType(SPRITE_ASSET_TYPE inputSpriteType)
	{
		spriteType = inputSpriteType;
	}

	public SPRITE_ASSET_TYPE GetSpriteType()
	{
		return spriteType;
	}
}
