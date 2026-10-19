using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class AnnouncementTimelineJumpButton : MonoBehaviour
{
	[Header("Resources (Activity)")]
	[SerializeField]
	private Sprite actNormal;

	[SerializeField]
	private Sprite actHighlight;

	[SerializeField]
	private Sprite actPressed;

	[SerializeField]
	private Color actGoto;

	[Header("Resources (CardPool)")]
	[SerializeField]
	private Sprite cpNormal;

	[SerializeField]
	private Sprite cpHighlight;

	[SerializeField]
	private Sprite cpPressed;

	[SerializeField]
	private Color cpGoto;

	[Header("Resources (Locked)")]
	[SerializeField]
	private Sprite cpLocked;

	[SerializeField]
	private Color disabledGoto;

	[Header("Components")]
	[SerializeField]
	private Image buttonImage;

	[SerializeField]
	private Image lockIcon;

	[SerializeField]
	private Image gotoIcon;

	[SerializeField]
	private Button button;

	public void Click()
	{
		if (button.interactable && button.gameObject.activeSelf)
		{
			button?.onClick?.Invoke();
		}
	}

	public void SetType(AnnouncementTimelineItemType type, bool locked, bool setGray)
	{
		if (locked)
		{
			button.interactable = false;
			gotoIcon.gameObject.SetActive(value: false);
			lockIcon.gameObject.SetActive(value: true);
		}
		else
		{
			button.interactable = true;
			gotoIcon.gameObject.SetActive(value: true);
			lockIcon.gameObject.SetActive(value: false);
		}
		SpriteState spriteState = button.spriteState;
		if (setGray)
		{
			buttonImage.sprite = cpLocked;
			spriteState.highlightedSprite = cpLocked;
			spriteState.pressedSprite = cpLocked;
			spriteState.selectedSprite = cpLocked;
			gotoIcon.color = disabledGoto;
			lockIcon.color = disabledGoto;
		}
		else if (type == AnnouncementTimelineItemType.Activity)
		{
			buttonImage.sprite = actNormal;
			spriteState.highlightedSprite = actHighlight;
			spriteState.pressedSprite = actPressed;
			spriteState.selectedSprite = actHighlight;
			gotoIcon.color = actGoto;
			lockIcon.color = actGoto;
		}
		else
		{
			buttonImage.sprite = cpNormal;
			spriteState.highlightedSprite = cpHighlight;
			spriteState.pressedSprite = cpPressed;
			spriteState.selectedSprite = cpHighlight;
			gotoIcon.color = cpGoto;
			lockIcon.color = cpGoto;
		}
		button.spriteState = spriteState;
	}
}
