using UnityEngine;
using UnityEngine.UI;

public class SelfAdaptImage : Image
{
	private Image m_image;

	private RectTransform m_rect;

	public new Sprite sprite
	{
		get
		{
			return base.sprite;
		}
		set
		{
			base.sprite = value;
			if (value != null)
			{
				AdaptImg();
			}
		}
	}

	public void AdaptImg()
	{
		if (m_image == null)
		{
			m_image = GetComponent<Image>();
		}
		if (m_rect == null)
		{
			m_rect = GetComponent<RectTransform>();
		}
		Sprite sprite = m_image.sprite;
		if (!(sprite == null))
		{
			float num = m_image.pixelsPerUnit;
			float x = sprite.rect.width / num;
			float y = sprite.rect.height / num;
			Vector2 vector = new Vector2(sprite.rect.width, sprite.rect.height);
			m_rect.anchorMax = m_rect.anchorMin;
			m_rect.sizeDelta = new Vector2(x, y);
			m_rect.pivot = sprite.pivot / vector;
			m_rect.localPosition = new Vector2(0f, 0f);
		}
	}
}
