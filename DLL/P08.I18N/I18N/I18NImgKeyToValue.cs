using UnityEngine;
using UnityEngine.UI;

namespace I18N;

[DisallowMultipleComponent]
public class I18NImgKeyToValue : MonoBehaviour
{
	[SerializeField]
	private string spriteAssetPath = "";

	[SerializeField]
	private string spriteName = "";

	[SerializeField]
	private SPRITE_ASSET_TYPE spriteType;

	private Image imageComponent;

	private void Awake()
	{
		if (Application.isPlaying)
		{
			RefreshSprite();
		}
	}

	public void RefreshSprite()
	{
		if (!imageComponent)
		{
			imageComponent = base.gameObject.GetComponent<Image>();
		}
		if (!imageComponent)
		{
			Debug.LogError("I18NImgKeyToValue组件的gameobject没有对应的Image组件");
		}
		else if (!string.IsNullOrEmpty(spriteAssetPath))
		{
			Sprite sprite = I18NConfigManager.GetSprite(spriteType, spriteAssetPath, spriteName);
			if (sprite != null)
			{
				imageComponent.sprite = sprite;
				imageComponent.SetNativeSize();
			}
			else
			{
				Debug.LogError($"cant load i18n sprite, spriteType: {spriteType}, spriteAssetPath: {spriteAssetPath}, spriteName: {spriteName}");
			}
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
