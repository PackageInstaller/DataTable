using System;
using ACT.UI.AOT;
using TMPro;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.UI;

public class AnnouncementTabItem : MonoBehaviour
{
	[SerializeField]
	private RectTransform container;

	[SerializeField]
	private TextMeshProUGUI label;

	[SerializeField]
	private Color activeTextColor;

	[SerializeField]
	private Color inactiveTextColor;

	[SerializeField]
	private CanvasGroup redDotObject;

	[SerializeField]
	private AnnouncementType announcementType;

	[SerializeField]
	private ActButton clickButton;

	public UnityEvent onClick;

	public RectTransform RectTransform => container;

	public void Set(bool status)
	{
		label.color = (status ? activeTextColor : inactiveTextColor);
	}

	private void OnEnable()
	{
		OnRedDotChanged();
		AnnouncementRedDot.OnRedDotChanged = (Action)Delegate.Combine(AnnouncementRedDot.OnRedDotChanged, new Action(OnRedDotChanged));
		clickButton.OnClick.AddListener(OnPointerClick);
	}

	private void OnDisable()
	{
		AnnouncementRedDot.OnRedDotChanged = (Action)Delegate.Remove(AnnouncementRedDot.OnRedDotChanged, new Action(OnRedDotChanged));
		clickButton.OnClick.RemoveListener(OnPointerClick);
	}

	public void OnRedDotChanged()
	{
		if (!(redDotObject == null))
		{
			bool flag = true;
			if (announcementType == AnnouncementType.Activity)
			{
				flag = AnnouncementRedDot.IsAllRead(includeGame: false, includeActivity: true, includeTimeline: false);
			}
			else
			{
				flag = ((announcementType != AnnouncementType.Game) ? AnnouncementRedDot.IsAllRead(includeGame: false, includeActivity: false, includeTimeline: true) : AnnouncementRedDot.IsAllRead(includeGame: true, includeActivity: false, includeTimeline: false, AnnouncementPlace.HCLR));
			}
			bool flag2 = !flag;
			redDotObject.gameObject.SetActive(flag2);
			redDotObject.alpha = (flag2 ? 1 : 0);
		}
	}

	public void OnPointerClick()
	{
		onClick?.Invoke();
	}
}
