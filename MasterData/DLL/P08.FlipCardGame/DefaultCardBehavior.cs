using P08.Quiz;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.UI;

public class DefaultCardBehavior : ICardBehavior
{
	public bool CanDrag => true;

	public bool CanClick => true;

	public void OnBeginDrag(Card card, PointerEventData eventData)
	{
		if (MonoSingleton<BloodCardManager>.Instance.guideID != 108 || MonoSingleton<BloodCardManager>.Instance.stepID == 10806)
		{
			AudioManager.Instance.Play("effect", BloodCardManager.CUE_NAME, "minigame_activity_3_10_card_up", useStream: false);
			card.BeginDragEvent.Invoke(card);
			RectTransformUtility.ScreenPointToWorldPointInRectangle(card.GetCanvas().transform as RectTransform, Input.mousePosition, CanvasManager.Instance.uiCamera, out var worldPoint);
			card.SetOffset(worldPoint - card.transform.position);
			card.SetDragging(dragging: true);
			card.GetCanvas().GetComponent<GraphicRaycaster>().enabled = false;
			card.GetImageComponent().raycastTarget = false;
			card.SetCardSize("small");
			card.SetWasDragged(dragged: true);
			card.cardVisual.canvas.overrideSorting = true;
		}
	}

	public void OnDrag(Card card, PointerEventData eventData)
	{
	}

	public void OnEndDrag(Card card, PointerEventData eventData)
	{
		if (MonoSingleton<BloodCardManager>.Instance.Board.HightLightCell == null && MonoSingleton<BloodCardManager>.Instance.placingIndex == -1)
		{
			AudioManager.Instance.Play("effect", BloodCardManager.CUE_NAME, "minigame_activity_3_10_card_down", useStream: false);
		}
		card.EndDragEvent.Invoke(card);
		card.SetDragging(dragging: false);
		card.GetCanvas().GetComponent<GraphicRaycaster>().enabled = true;
		card.GetImageComponent().raycastTarget = true;
		if (MonoSingleton<BloodCardManager>.Instance.stepID != 10806)
		{
			card.cardVisual.canvas.overrideSorting = false;
		}
		card.StartCoroutine(card.FrameWait());
	}

	public void OnPointerEnter(Card card, PointerEventData eventData)
	{
		card.PointerEnterEvent.Invoke(card);
		card.SetHovering(hovering: true);
		card.cardVisual.canvas.overrideSorting = true;
	}

	public void OnPointerExit(Card card, PointerEventData eventData)
	{
		card.PointerExitEvent.Invoke(card);
		card.SetHovering(hovering: false);
		if (!card.IsDragging())
		{
			card.cardVisual.shadowCanvas.overrideSorting = false;
			if (MonoSingleton<BloodCardManager>.Instance.stepID != 10806)
			{
				card.cardVisual.canvas.overrideSorting = false;
			}
		}
	}

	public void OnPointerDown(Card card, PointerEventData eventData)
	{
		card.PointerDownEvent.Invoke(card);
		card.cardVisual.shadowCanvas.overrideSorting = true;
		card.cardVisual.canvas.overrideSorting = true;
	}

	public void OnPointerUp(Card card, PointerEventData eventData)
	{
		card.PointerUpEvent.Invoke(card, card.GetPointerDownTime() - card.GetPointerDownTime() > 0.2f);
		card.cardVisual.shadowCanvas.overrideSorting = false;
		card.cardVisual.canvas.overrideSorting = false;
	}
}
