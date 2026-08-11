using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ContentImageItem : MonoBehaviour
{
	public float itemPaddingX = 10f;

	public Vector2 bgPadding = new Vector2(10f, 10f);

	public string url;

	public UrlImage image;

	public RectTransform bgRect;

	public LayoutElement itemLayout;

	public async void SetSpriteUrl(string url)
	{
		this.url = url;
		RectTransform rectTransform = (await image.SetSpriteUrl(url)).rectTransform;
		Vector3 localScale = rectTransform.localScale;
		Vector2 sizeDelta = rectTransform.sizeDelta;
		Vector2 vector = new Vector2(sizeDelta.x * localScale.x, sizeDelta.y * localScale.y);
		bgRect.sizeDelta = new Vector2(vector.x + bgPadding.x * 2f, vector.y + bgPadding.y * 2f);
		itemLayout.preferredHeight = bgRect.sizeDelta.y;
	}

	public void SetImageWidthLimit(float widthLimit)
	{
		image.widthLimit = widthLimit - bgPadding.x * 2f - itemPaddingX * 2f;
	}
}
