using System.Collections;
using System.Collections.Generic;
using ControllerExSpace;
using P08.Quiz;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.UI;

public class Card : MonoBehaviour, IDragHandler, IEventSystemHandler, IBeginDragHandler, IEndDragHandler, IPointerEnterHandler, IPointerExitHandler, IPointerUpHandler, IPointerDownHandler
{
	[HideInInspector]
	public Canvas canvas;

	[SerializeField]
	private bool instantiateVisual;

	private VisualCardsHandler visualHandler;

	private Vector3 offset;

	public RectTransform rectTransform;

	public Image imageComponent;

	private Dictionary<UnityEvent<Card>, EventListenerGroup<Card>> cardEvents = new Dictionary<UnityEvent<Card>, EventListenerGroup<Card>>();

	private Dictionary<UnityEvent<Card, bool>, EventListenerGroup<Card, bool>> cardBoolEvents = new Dictionary<UnityEvent<Card, bool>, EventListenerGroup<Card, bool>>();

	[Header("Movement")]
	[SerializeField]
	private float moveSpeedLimit = 50f;

	[Header("Selection")]
	public bool selected;

	public float selectionOffset = 50f;

	private float pointerDownTime;

	private float pointerUpTime;

	[Header("Visual")]
	[SerializeField]
	private GameObject cardVisualPrefab;

	[HideInInspector]
	public CardVisual cardVisual;

	public ControllerExCollection controller;

	[HideInInspector]
	public ControllerEx sizeController;

	[Header("States")]
	public bool isHovering;

	public bool isDragging;

	[HideInInspector]
	public bool wasDragged;

	[Header("Events")]
	[HideInInspector]
	public UnityEvent<Card> PointerEnterEvent;

	[HideInInspector]
	public UnityEvent<Card> PointerExitEvent;

	[HideInInspector]
	public UnityEvent<Card, bool> PointerUpEvent;

	[HideInInspector]
	public UnityEvent<Card> PointerDownEvent;

	[HideInInspector]
	public UnityEvent<Card> BeginDragEvent;

	[HideInInspector]
	public UnityEvent<Card> EndDragEvent;

	[HideInInspector]
	public UnityEvent<Card, bool> SelectEvent;

	[Header("Data")]
	[SerializeField]
	public int index;

	[SerializeField]
	public CardHolder holder;

	[SerializeField]
	private CardData data;

	[SerializeField]
	private ICardBehavior cardBehavior;

	[SerializeField]
	private ICardBehavior roundBehavior;

	[SerializeField]
	public bool isFree;

	[SerializeField]
	public BloodCardEnum.PlayerRole belongs;

	[SerializeField]
	public BloodCardEnum.PlaceType place;

	public Canvas GetCanvas()
	{
		return canvas;
	}

	public Image GetImageComponent()
	{
		return imageComponent;
	}

	public Vector3 GetOffset()
	{
		return offset;
	}

	public void SetOffset(Vector3 offset)
	{
		this.offset = offset;
	}

	public bool IsDragging()
	{
		return isDragging;
	}

	public void SetDragging(bool dragging)
	{
		isDragging = dragging;
	}

	public bool IsHovering()
	{
		return isHovering;
	}

	public void SetHovering(bool hovering)
	{
		isHovering = hovering;
	}

	public bool WasDragged()
	{
		return wasDragged;
	}

	public void SetWasDragged(bool dragged)
	{
		wasDragged = dragged;
	}

	public bool Selected()
	{
		return selected;
	}

	public void SetSelected(bool selected)
	{
		this.selected = selected;
	}

	public float GetPointerDownTime()
	{
		return pointerDownTime;
	}

	public void SetPointerDownTime(float time)
	{
		pointerDownTime = time;
	}

	public float GetPointerUpTime()
	{
		return pointerUpTime;
	}

	public void SetPointerUpTime(float time)
	{
		pointerUpTime = time;
	}

	public CardVisual GetCardVisual()
	{
		return cardVisual;
	}

	private void Awake()
	{
		if (!instantiateVisual)
		{
			sizeController = controller.GetController("size");
			visualHandler = Object.FindObjectOfType<VisualCardsHandler>();
			cardVisual = Object.Instantiate(cardVisualPrefab, visualHandler ? visualHandler.transform : canvas.transform).GetComponent<CardVisual>();
			cardVisual.Initialize(this);
			instantiateVisual = true;
		}
	}

	private void Start()
	{
		canvas = GetComponentInParent<Canvas>();
	}

	private void LateUpdate()
	{
		ClampPosition();
		if (isDragging && cardBehavior.CanDrag && roundBehavior.CanDrag)
		{
			if (Input.GetKeyDown(KeyCode.Escape))
			{
				EventSystem.current.SetSelectedGameObject(null);
				PointerEventData eventData = new PointerEventData(EventSystem.current);
				OnEndDrag(eventData);
			}
			Vector2 screenPoint = Input.mousePosition;
			RectTransformUtility.ScreenPointToWorldPointInRectangle(canvas.transform as RectTransform, screenPoint, CanvasManager.Instance.uiCamera, out var worldPoint);
			Vector2 vector = worldPoint - offset;
			Vector2 vector2 = (vector - (Vector2)base.transform.position).normalized * Mathf.Min(moveSpeedLimit, Vector2.Distance(base.transform.position, vector) / Time.deltaTime);
			base.transform.Translate(vector2 * Time.deltaTime);
		}
	}

	private void ClampPosition()
	{
		RectTransformUtility.ScreenPointToWorldPointInRectangle(canvas.transform as RectTransform, new Vector3(Screen.width, Screen.height, CanvasManager.Instance.uiCamera.transform.position.z), CanvasManager.Instance.uiCamera, out var worldPoint);
		Vector3 position = base.transform.position;
		position.x = Mathf.Clamp(position.x, 0f - worldPoint.x, worldPoint.x);
		position.y = Mathf.Clamp(position.y, 0f - worldPoint.y, worldPoint.y);
		base.transform.position = new Vector3(position.x, position.y, 3f);
	}

	public void SetCardBehavior(ICardBehavior behavior)
	{
		cardBehavior = behavior;
	}

	public void SetRoundBehavior(ICardBehavior behavior)
	{
		roundBehavior = behavior;
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (cardBehavior != null && cardBehavior.CanDrag && roundBehavior.CanDrag)
		{
			cardBehavior.OnBeginDrag(this, eventData);
		}
		roundBehavior.OnBeginDrag(this, eventData);
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (cardBehavior != null && cardBehavior.CanDrag)
		{
			cardBehavior.OnDrag(this, eventData);
		}
		if (roundBehavior != null && roundBehavior.CanDrag)
		{
			roundBehavior.OnDrag(this, eventData);
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		if (cardBehavior != null && cardBehavior.CanDrag)
		{
			cardBehavior.OnEndDrag(this, eventData);
		}
		if (roundBehavior != null && roundBehavior.CanDrag)
		{
			roundBehavior.OnEndDrag(this, eventData);
		}
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		if (cardBehavior != null && cardBehavior.CanClick)
		{
			cardBehavior.OnPointerEnter(this, eventData);
		}
		if (roundBehavior != null && roundBehavior.CanClick)
		{
			roundBehavior.OnPointerEnter(this, eventData);
		}
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		if (cardBehavior != null && cardBehavior.CanClick)
		{
			cardBehavior.OnPointerExit(this, eventData);
		}
		if (roundBehavior != null && roundBehavior.CanClick)
		{
			roundBehavior.OnPointerExit(this, eventData);
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (cardBehavior.CanClick)
		{
			cardBehavior.OnPointerDown(this, eventData);
		}
		if (roundBehavior != null && roundBehavior.CanClick)
		{
			roundBehavior.OnPointerDown(this, eventData);
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (cardBehavior != null && cardBehavior.CanClick)
		{
			cardBehavior.OnPointerUp(this, eventData);
		}
		if (roundBehavior != null && roundBehavior.CanClick)
		{
			roundBehavior.OnPointerUp(this, eventData);
		}
	}

	public void Deselect()
	{
	}

	public IEnumerator FrameWait()
	{
		yield return null;
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
			return 0;
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

	private void OnDestroy()
	{
		if (cardVisual != null)
		{
			Object.Destroy(cardVisual.gameObject);
		}
		StopAllCoroutines();
	}

	public void SetCardSize(string size)
	{
		sizeController?.SetSelectedState(size);
		cardVisual?.sizeController?.SetSelectedState(size);
	}

	public IEnumerator PlaceCardCorutine(CardCell cell)
	{
		cardVisual.playingAnimation = true;
		cardVisual.transform.SetAsLastSibling();
		SetCardBehavior(new NoInteractionCardBehavior());
		if (data.rare == BloodCardEnum.CardRarity.GOLD)
		{
			PlayGoldPrePlaceEffect();
			yield return new WaitForSeconds(2.15f + MonoSingleton<BloodCardManager>.Instance.BezierTime);
		}
		if (cell.CurrentCard != null && data.type == 2)
		{
			cell.CurrentCard.cardVisual.PlayHideEffectAni();
			yield return new WaitForSeconds(0.3f);
		}
		if (cell.PlaceCard(this))
		{
			holder?.cards?.Remove(this);
			holder = null;
			place = BloodCardEnum.PlaceType.BOARD;
		}
	}

	public void PlayBreakCard(CardCell cell)
	{
		StartCoroutine(BreakCard(cell));
	}

	private IEnumerator BreakCard(CardCell cell)
	{
		cardVisual.PlayCardVisualEffect(BloodCardEnum.PlayEffectType.BREAK);
		foreach (Effect effect in cell.CurrentCard.Data().effects)
		{
			EffectData effectData = LazySingleton<LuaEffectLoader>.Instance.GetEffectData(effect.id);
			if (effectData.type != 1 || effectData.launchTime != 11)
			{
				continue;
			}
			foreach (Vector2 effectPos in effect.effectPosList)
			{
				int num = MonoSingleton<BloodCardManager>.Instance.ConverPosToIndex(cell.index, effectPos, MonoSingleton<BloodCardManager>.Instance.Board.rows, MonoSingleton<BloodCardManager>.Instance.Board.columns - 2);
				MonoSingleton<BloodCardManager>.Instance.Board.cardCells[num].SetBuffEffectActive(flag: false, BloodCardEnum.PlayerRole.SYSTEM);
			}
		}
		yield return new WaitForSeconds(0.5f);
		cell.RemoveCard();
		Hide();
		MonoSingleton<BloodCardManager>.Instance.Board.UpdateBoard();
		MonoSingleton<BloodCardManager>.Instance.MoveCardToList(null, MonoSingleton<BloodCardManager>.Instance.CardPoolDeck, this, immediately: true);
	}

	public void PlayChangePower(bool isRemove, CardCell cell)
	{
		StartCoroutine(PlayChangePowerEffect(isRemove, cell));
	}

	private IEnumerator PlayChangePowerEffect(bool isRemove, CardCell cell)
	{
		GameObject gameObject = cardVisual.effectGameObjectList[(belongs == BloodCardEnum.PlayerRole.SELF) ? 5 : 4];
		if (isRemove)
		{
			gameObject.SetActive(value: false);
		}
		else
		{
			gameObject.SetActive(value: true);
		}
		AudioManager.Instance.Play("effect", BloodCardManager.CUE_NAME, "minigame_activity_3_10_card_buff02", useStream: false);
		yield return new WaitForSeconds(1f);
		if (Data().power <= 0)
		{
			PlayBreakCard(cell);
		}
	}

	public void PlayGoldPrePlaceEffect()
	{
		base.transform.parent.SetParent(MonoSingleton<BloodCardManager>.Instance.ScreenAniRoot.transform);
		base.transform.parent.localPosition = Vector3.zero;
		base.transform.localPosition = Vector3.zero;
		place = BloodCardEnum.PlaceType.BOARD;
		cardVisual.transform.position = base.transform.position;
		cardVisual.PlayPrePlaceEffectAni();
	}

	public void PlayPlaceEffect()
	{
		if (!(cardVisual == null) && data != null)
		{
			StartCoroutine(PlayPlacingEffect());
		}
	}

	private IEnumerator PlayPlacingEffect()
	{
		canvas.overrideSorting = true;
		cardVisual.ResetPrePlaceAni();
		cardVisual.PlayPlacingPlaceEffectAni();
		yield return new WaitForSeconds(0.1f);
		if (belongs == BloodCardEnum.PlayerRole.SELF)
		{
			if (data.rare == BloodCardEnum.CardRarity.GOLD)
			{
				cardVisual.PlayCardVisualEffect(BloodCardEnum.PlayEffectType.SELFGOLDPLACE);
			}
			else
			{
				cardVisual.PlayCardVisualEffect(BloodCardEnum.PlayEffectType.SELFPLACE);
			}
		}
		else if (belongs == BloodCardEnum.PlayerRole.ENEMY)
		{
			if (data.rare == BloodCardEnum.CardRarity.GOLD)
			{
				cardVisual.PlayCardVisualEffect(BloodCardEnum.PlayEffectType.ENEMYGOLDPLACE);
			}
			else
			{
				cardVisual.PlayCardVisualEffect(BloodCardEnum.PlayEffectType.ENEMYPLACE);
			}
		}
		yield return new WaitForSeconds(1.1f);
		if (belongs == BloodCardEnum.PlayerRole.ENEMY)
		{
			MonoSingleton<BloodCardManager>.Instance.enemyPlaceCardDone = true;
		}
		else
		{
			MonoSingleton<BloodCardManager>.Instance.selfPlaceCardDone = true;
		}
		cardVisual.canvas.overrideSorting = false;
		cardVisual.playingAnimation = false;
		SetCardBehavior(new CardBoardCardBehavior());
		canvas.overrideSorting = false;
	}

	public void Show()
	{
		cardVisual.gameObject.SetActive(value: true);
		isFree = false;
	}

	public void Hide()
	{
		cardVisual.gameObject.SetActive(value: false);
		cardVisual.ResetPrePlaceAni();
		isFree = true;
		StopAllCoroutines();
		ResetData();
	}

	public void ResetData()
	{
		cardBehavior = null;
		roundBehavior = null;
		isDragging = false;
		isHovering = false;
		data = null;
		SetCardSize("big");
	}

	public CardData Data()
	{
		return data;
	}

	public void SetCardData(CardData cardData)
	{
		data = cardData;
		cardVisual.SetCardCells();
	}

	public void RemoveAllListeners()
	{
		foreach (KeyValuePair<UnityEvent<Card>, EventListenerGroup<Card>> cardEvent in cardEvents)
		{
			if (cardEvent.Value.Event != null && cardEvent.Value.Event.GetPersistentEventCount() > 0)
			{
				cardEvent.Value.RemoveAllListeners();
			}
		}
		foreach (KeyValuePair<UnityEvent<Card, bool>, EventListenerGroup<Card, bool>> cardBoolEvent in cardBoolEvents)
		{
			if (cardBoolEvent.Value.Event != null && cardBoolEvent.Value.Event.GetPersistentEventCount() > 0)
			{
				cardBoolEvent.Value.RemoveAllListeners();
			}
		}
	}

	public void RemoveAllTagListeners(string groupTag)
	{
		foreach (KeyValuePair<UnityEvent<Card>, EventListenerGroup<Card>> cardEvent in cardEvents)
		{
			if (cardEvent.Value.Event != null && string.Equals(groupTag, cardEvent.Value.GroupTag))
			{
				for (int num = cardEvent.Value.Listeners.Count - 1; num > 0; num--)
				{
					cardEvent.Value.RemoveListener(cardEvent.Value.Listeners[num]);
				}
			}
		}
		foreach (KeyValuePair<UnityEvent<Card, bool>, EventListenerGroup<Card, bool>> cardBoolEvent in cardBoolEvents)
		{
			if (cardBoolEvent.Value.Event != null && string.Equals(groupTag, cardBoolEvent.Value.GroupTag))
			{
				for (int num2 = cardBoolEvent.Value.Listeners.Count - 1; num2 > 0; num2--)
				{
					cardBoolEvent.Value.RemoveListener(cardBoolEvent.Value.Listeners[num2]);
				}
			}
		}
	}

	public void AddEventListeners(UnityEvent<Card> e, UnityAction<Card> a, string groupTag)
	{
		if (!cardEvents.ContainsKey(e))
		{
			cardEvents[e] = new EventListenerGroup<Card>
			{
				Event = e,
				GroupTag = groupTag
			};
		}
		cardEvents[e].AddListener(a);
	}

	public void AddEventListeners(UnityEvent<Card, bool> e, UnityAction<Card, bool> a, string groupTag)
	{
		if (!cardBoolEvents.ContainsKey(e))
		{
			cardBoolEvents[e] = new EventListenerGroup<Card, bool>
			{
				Event = e,
				GroupTag = groupTag
			};
		}
		cardBoolEvents[e].AddListener(a);
	}
}
