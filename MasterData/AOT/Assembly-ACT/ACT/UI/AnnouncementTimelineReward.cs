using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class AnnouncementTimelineReward : MonoBehaviour
{
	[SerializeField]
	private CanvasGroup canvasGroup;

	[SerializeField]
	private RawImage icon;

	[SerializeField]
	private Image background;

	[SerializeField]
	private Sprite[] backgroundSprites;

	public CanvasGroup CanvasGroup => canvasGroup;

	public void Set(Texture2D iconImage, int level)
	{
		iconImage.ignoreMipmapLimit = true;
		icon.texture = iconImage;
		background.sprite = backgroundSprites[level];
	}
}
