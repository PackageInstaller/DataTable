using DG.Tweening;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class TimelineItemTitleIcon : MonoBehaviour
{
	[SerializeField]
	private CanvasGroup group;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image upIcon;

	[SerializeField]
	private Image backdrop;

	public RectTransform rectTransform => icon.rectTransform;

	private void Awake()
	{
		group.alpha = 0f;
	}

	public void SetImage(Texture2D tex)
	{
		tex.ignoreMipmapLimit = true;
		icon.sprite = Sprite.Create(tex, new Rect(0f, 0f, tex.width, tex.height), new Vector2(0f, 0f));
		group.DOFade(1f, 0.2f);
	}

	public void SetSprite(Sprite tex)
	{
		icon.sprite = tex;
		group.DOFade(1f, 0.2f);
	}

	public void SetCardPoolStyle(bool visible)
	{
		backdrop.gameObject.SetActive(visible);
		upIcon.gameObject.SetActive(visible);
	}
}
