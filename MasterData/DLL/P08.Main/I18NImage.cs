using UnityEngine;
using UnityEngine.UI;

[AddComponentMenu("UI/I18NImage", 10)]
public class I18NImage : Image
{
	[SerializeField]
	public bool setNativeSize;

	[SerializeField]
	private string spriteAssetPath = "";

	[SerializeField]
	private string spriteName = "";

	[SerializeField]
	private SPRITE_ASSET_TYPE spriteType;

	public bool m_setNativeSize
	{
		get
		{
			return setNativeSize;
		}
		set
		{
			if (setNativeSize != value)
			{
				setNativeSize = value;
				SetVerticesDirty();
			}
		}
	}

	public new Sprite sprite
	{
		get
		{
			return base.sprite;
		}
		set
		{
			base.sprite = value;
			if (m_setNativeSize)
			{
				SetNativeSize();
			}
		}
	}

	protected override void Start()
	{
		RefreshSprite();
	}

	private void RefreshSprite()
	{
		Sprite sprite = I18NConfigManager.GetSprite(spriteType, spriteAssetPath, spriteName);
		if (sprite != null)
		{
			this.sprite = sprite;
		}
	}
}
