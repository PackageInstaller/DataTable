using System;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI.AOT;

public class AnnouncementItem : MonoBehaviour, IPointerClickHandler, IEventSystemHandler, IPointerEnterHandler, IPointerExitHandler
{
	public TextMeshProUGUI Text;

	public Image Selected;

	public Image Unselected;

	public Image PointerSelected;

	public RectTransform RedDot;

	public Color selectedTextColor;

	public Color unSelectedTextColor;

	private Action<AnnouncementData> onSelected;

	public AnnouncementData DataContext { get; private set; }

	public bool CurrentIsSelected { get; set; }

	public event Action OnClicked;

	public void Set(AnnouncementData announcement, Action<AnnouncementData> selectedEvent)
	{
		DataContext = announcement;
		Text.text = DataContext.Title;
		onSelected = selectedEvent;
		if (AnnouncementRedDot.IsRecorded(DataContext.Id.ToString()))
		{
			RedDot.gameObject.SetActive(value: false);
		}
	}

	public void SetSelected(bool isSelected)
	{
		if (CurrentIsSelected != isSelected)
		{
			CurrentIsSelected = isSelected;
			Selected.gameObject.SetActive(isSelected);
			Unselected.gameObject.SetActive(!isSelected);
			Text.color = (CurrentIsSelected ? selectedTextColor : unSelectedTextColor);
			if (isSelected && !AnnouncementRedDot.IsRecorded(DataContext.Id.ToString()))
			{
				AnnouncementRedDot.RecordRedDot(DataContext.Id.ToString());
				RedDot.gameObject.SetActive(value: false);
			}
		}
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		OnClicked?.Invoke();
		if (!CurrentIsSelected)
		{
			onSelected?.Invoke(DataContext);
		}
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		PointerSelected.gameObject.SetActive(value: true);
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		PointerSelected.gameObject.SetActive(value: false);
	}
}
