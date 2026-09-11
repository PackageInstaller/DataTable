using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Image))]
public class AdaptImage : MonoBehaviour
{
	private Image m_image;

	private RectTransform m_rect;

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
		float pixelsPerUnit = m_image.pixelsPerUnit;
		float x = sprite.rect.width / pixelsPerUnit;
		float y = sprite.rect.height / pixelsPerUnit;
		Vector2 vector = new Vector2(sprite.rect.width, sprite.rect.height);
		m_rect.anchorMax = m_rect.anchorMin;
		m_rect.sizeDelta = new Vector2(x, y);
		m_rect.pivot = sprite.pivot / vector;
		m_rect.localPosition = new Vector2(0f, 0f);
	}
}
