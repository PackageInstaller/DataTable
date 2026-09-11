using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCard : MonoBehaviour, IDragHandler, IEventSystemHandler, IBeginDragHandler, IEndDragHandler, IPointerEnterHandler, IPointerExitHandler, IPointerUpHandler, IPointerDownHandler
{
	public int index;

	private Canvas canvas;

	private Image imageComponent;

	[SerializeField]
	private bool instantiateVisual = true;

	[SerializeField]
	private RogueCardVisualCardHandler visualHandler;

	public RogueCardHolder holder;

	[Header("Movement")]
	[SerializeField]
	private float moveSpeedLimit = 50f;

	[Header("Selection")]
	public bool selected;

	private float pointerDownTime;

	private float pointerUpTime;

	[Header("Visual")]
	[SerializeField]
	private GameObject cardVisualPrefab;

	[HideInInspector]
	public VisualCardBase cardVisual;

	[Header("States")]
	public bool isHovering;

	public bool isDragging;

	[HideInInspector]
	public bool wasDragged;

	[Header("Events")]
	[HideInInspector]
	public UnityEvent<RogueCard> PointerEnterEvent;

	[HideInInspector]
	public UnityEvent<RogueCard> PointerExitEvent;

	[HideInInspector]
	public UnityEvent<RogueCard, bool> PointerUpEvent;

	[HideInInspector]
	public UnityEvent<RogueCard> PointerDownEvent;

	[HideInInspector]
	public UnityEvent<RogueCard> BeginDragEvent;

	[HideInInspector]
	public UnityEvent<RogueCard> EndDragEvent;

	[HideInInspector]
	public UnityEvent<RogueCard, int> SelectEvent;

	public int cardState;

	private void Awake()
	{
		canvas = GetComponentInParent<Canvas>();
		imageComponent = GetComponent<Image>();
	}

	public void InstantiateVisual(int cardState = 0)
	{
		if (null == visualHandler)
		{
			switch (cardState)
			{
			case 0:
				visualHandler = RogueCardGameMain.Instance.handCardHandler;
				break;
			case 1:
				visualHandler = RogueCardGameMain.Instance.wuChangPackageCardHandler;
				break;
			case 2:
				visualHandler = RogueCardGameMain.Instance.wuChangCardHandler;
				break;
			default:
				visualHandler = RogueCardGameMain.Instance.jokerCardHandler;
				break;
			}
		}
		cardVisual = Object.Instantiate(cardVisualPrefab, visualHandler ? visualHandler.transform : canvas.transform).GetComponent<VisualCardBase>();
		cardVisual.Initialize(this);
		cardVisual.visualHandler = visualHandler;
		cardVisual.holder = holder;
		this.cardState = cardState;
	}

	private void LateUpdate()
	{
		if (!isDragging)
		{
			return;
		}
		if (!Input.GetMouseButton(0))
		{
			ForceStopDrag();
			return;
		}
		_ = (Vector2)Input.mousePosition;
		RectTransformUtility.ScreenPointToWorldPointInRectangle(canvas.transform as RectTransform, Input.mousePosition, CanvasManager.Instance.uiCamera, out var worldPoint);
		base.transform.position = worldPoint;
		if (!cardVisual.CanSelect)
		{
			bool isOnUI = RectTransformUtility.RectangleContainsScreenPoint(RogueCardGameMain.Instance.jokerSellTrans, worldPoint);
			RogueCardGameMain.Instance.ChangeSellJokerState(isOnUI, ParentIndex());
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (!RogueCardGameMain.Instance.guideSystem.IsDragLocked && !RogueCardGameMain.CheckDisableInput())
		{
			BeginDragEvent.Invoke(this);
			_ = (Vector2)Camera.main.ScreenToWorldPoint(Input.mousePosition);
			isDragging = true;
			GraphicRaycaster graphicRaycaster = ((canvas != null) ? canvas.GetComponent<GraphicRaycaster>() : null);
			if (graphicRaycaster != null)
			{
				graphicRaycaster.enabled = false;
			}
			imageComponent.raycastTarget = false;
			wasDragged = true;
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		bool num = RogueCardGameMain.CheckDisableInput();
		FinishDragState();
		StartCoroutine(FrameWait());
		if (num)
		{
			return;
		}
		if (!cardVisual.CanSelect)
		{
			RectTransformUtility.ScreenPointToWorldPointInRectangle(canvas.transform as RectTransform, Input.mousePosition, CanvasManager.Instance.uiCamera, out var worldPoint);
			if (RectTransformUtility.RectangleContainsScreenPoint(RogueCardGameMain.Instance.jokerSellTrans, worldPoint))
			{
				RogueCardGameMain.Instance.SellJoker(ParentIndex(), cardVisual as VisualJokerCard);
			}
		}
		RogueCardGameMain.Instance.saveSystem.SaveGameData();
		IEnumerator FrameWait()
		{
			yield return new WaitForEndOfFrame();
			wasDragged = false;
		}
	}

	private void FinishDragState()
	{
		if (isDragging || wasDragged)
		{
			EndDragEvent.Invoke(this);
			isDragging = false;
			GraphicRaycaster graphicRaycaster = ((canvas != null) ? canvas.GetComponent<GraphicRaycaster>() : null);
			if (graphicRaycaster != null)
			{
				graphicRaycaster.enabled = true;
			}
			if (imageComponent != null)
			{
				imageComponent.raycastTarget = true;
			}
		}
	}

	private void ForceStopDrag()
	{
		FinishDragState();
		wasDragged = false;
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		PointerEnterEvent.Invoke(this);
		isHovering = true;
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		PointerExitEvent.Invoke(this);
		isHovering = false;
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			PointerDownEvent.Invoke(this);
			pointerDownTime = Time.time;
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (cardVisual.CanSelect)
		{
			if (RogueCardGameMain.CheckDisableInput(LockItemType.handCard, ParentIndex()))
			{
				return;
			}
		}
		else if (RogueCardGameMain.CheckDisableInput(LockItemType.joker, ParentIndex()))
		{
			return;
		}
		if (eventData.button != PointerEventData.InputButton.Left)
		{
			return;
		}
		pointerUpTime = Time.time;
		PointerUpEvent.Invoke(this, pointerUpTime - pointerDownTime > 0.2f);
		if (pointerUpTime - pointerDownTime > 0.2f || wasDragged)
		{
			return;
		}
		if (cardVisual.CanSelect)
		{
			if (cardState == 1 || cardState == 2)
			{
				RogueCardGameMain.GameContext.wuChangWaitCards.SelectCard(ParentIndex());
				RogueCardGameMain.Instance.RefreshUI();
				RogueCardGameMain.Instance.ShowTips(RogueCardGameMain.GameContext.wuChangWaitCards.GetCardDataAtDisplayIndex(ParentIndex()), cardVisual);
			}
			else
			{
				RogueCardGameMain.Instance.SelectCard(ParentIndex());
				RogueCardGameMain.Instance.ShowTips(RogueCardGameMain.GameContext.handData.GetCardDataAtDisplayIndex(ParentIndex()), cardVisual);
			}
		}
		else
		{
			RogueCardGameMain.Instance.gameContext.selectJokerIndex = ParentIndex();
			RogueCardGameMain.Instance.ShowTips(RogueCardGameMain.GameContext.jokerData.GetCardDataAtDisplayIndex(ParentIndex()), cardVisual);
		}
	}

	public void SetSelect(bool isSelect)
	{
		selected = isSelect;
		cardVisual.SetSelect(isSelect);
	}

	public int SiblingAmount()
	{
		if (!base.transform.parent.CompareTag("Item"))
		{
			return 0;
		}
		return base.transform.parent.parent.childCount - 1;
	}

	public int ParentIndex()
	{
		if (!base.transform.parent.CompareTag("Item"))
		{
			return -1;
		}
		return base.transform.parent.GetSiblingIndex();
	}

	public float NormalizedPosition()
	{
		if (!base.transform.parent.CompareTag("Item"))
		{
			return 0f;
		}
		return ExtensionMethods.Remap(ParentIndex(), 0f, base.transform.parent.parent.childCount - 1, 0f, 1f);
	}

	public void ShowCardData(RogueCardData data)
	{
		(cardVisual as VisualRogueCard).transform.position = base.transform.position;
		(cardVisual as VisualRogueCard).ShowCardData(data);
	}

	public void ShowJokerData(RogueCardJokerData data)
	{
		(cardVisual as VisualJokerCard).ShowCardData(data);
	}

	private void OnDestroy()
	{
		FinishDragState();
		if (cardVisual != null)
		{
			Object.Destroy(cardVisual.gameObject);
		}
	}

	private void OnDisable()
	{
		FinishDragState();
	}

	private void OnApplicationFocus(bool hasFocus)
	{
		if (!hasFocus)
		{
			ForceStopDrag();
		}
	}

	private void OnApplicationPause(bool pauseStatus)
	{
		if (pauseStatus)
		{
			ForceStopDrag();
		}
	}
}
