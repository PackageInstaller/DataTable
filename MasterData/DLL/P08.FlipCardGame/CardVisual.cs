using System.Collections;
using System.Collections.Generic;
using System.Linq;
using ControllerExSpace;
using P08.Quiz;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.UI;

public class CardVisual : MonoBehaviour
{
	private bool initalize;

	[Header("Card")]
	public Card parentCard;

	private Transform cardTransform;

	private Vector3 rotationDelta;

	private int savedIndex;

	private Vector3 movementDelta;

	public Canvas canvas;

	public Image icon;

	[Header("References")]
	public Transform visualShadow;

	private float shadowOffset = 20f;

	private Vector2 shadowDistance;

	public Canvas shadowCanvas;

	[SerializeField]
	private Transform shakeParent;

	[SerializeField]
	public Transform tiltParent;

	public Text needPointText;

	public Text powerText;

	public Text nameText;

	public Text descText;

	public GameObject descriptionGo;

	public GameObject cells;

	private List<ControllerExCollection> cellControllerList;

	public ControllerExCollection controller;

	[Header("Follow Parameters")]
	[SerializeField]
	public float followSpeed = 30f;

	[Header("Rotation Parameters")]
	[SerializeField]
	private float rotationAmount = 20f;

	[SerializeField]
	private float rotationSpeed = 20f;

	[SerializeField]
	private float autoTiltAmount = 30f;

	[SerializeField]
	private float manualTiltAmount = 20f;

	[SerializeField]
	private float tiltSpeed = 20f;

	[Header("Scale Parameters")]
	[SerializeField]
	private bool scaleAnimations = true;

	[SerializeField]
	private float scaleOnHover = 1.15f;

	[SerializeField]
	private float scaleOnSelect = 1.25f;

	[SerializeField]
	private float scaleTransition = 0.15f;

	[Header("Select Parameters")]
	[SerializeField]
	private float selectPunchAmount = 20f;

	[Header("Hover Parameters")]
	[SerializeField]
	private float hoverPunchAngle = 5f;

	[SerializeField]
	private float hoverTransition = 0.15f;

	[Header("Swap Parameters")]
	[SerializeField]
	private bool swapAnimations = true;

	[SerializeField]
	private float swapRotationAngle = 30f;

	[SerializeField]
	private float swapTransition = 0.15f;

	[SerializeField]
	private int swapVibrato = 5;

	[Header("Curve")]
	[SerializeField]
	public bool shaking = true;

	[SerializeField]
	private CurveParameters curve;

	[SerializeField]
	private LeanTweenType scaleEase = LeanTweenType.easeOutBack;

	[HideInInspector]
	public float curveYOffset;

	[HideInInspector]
	public float curveRotationOffset;

	[HideInInspector]
	public ControllerEx needPointController;

	[HideInInspector]
	public ControllerEx cardController;

	[HideInInspector]
	public ControllerEx sizeController;

	[HideInInspector]
	public ControllerEx skillController;

	[HideInInspector]
	public ControllerEx flippingController;

	[HideInInspector]
	public ControllerEx setController;

	[HideInInspector]
	public ControllerEx lightController;

	[HideInInspector]
	public ControllerEx dragController;

	[HideInInspector]
	public ControllerEx changeController;

	[HideInInspector]
	public ControllerEx changeFrameController;

	[Header("effectGameObject")]
	public bool playingAnimation;

	public List<GameObject> effectGameObjectList;

	public Animator scaleAni;

	public Animator goldPrePlaceAni;

	private void Awake()
	{
		shadowDistance = visualShadow.localPosition;
		needPointController = controller.GetController("needPoint");
		cardController = controller.GetController("card");
		sizeController = controller.GetController("size");
		skillController = controller.GetController("skill");
		flippingController = controller.GetController("flipping");
		setController = controller.GetController("set");
		lightController = controller.GetController("light");
		dragController = controller.GetController("drag");
		changeController = controller.GetController("change");
		changeFrameController = controller.GetController("changeFrame");
	}

	public void Initialize(Card target, int index = 0)
	{
		parentCard = target;
		cardTransform = target.transform;
		canvas = GetComponent<Canvas>();
		shadowCanvas = visualShadow.GetComponent<Canvas>();
		cellControllerList = cells.GetComponentsInChildren<ControllerExCollection>().ToList();
		AddListeners();
		initalize = true;
	}

	public void AddListeners()
	{
		parentCard.AddEventListeners(parentCard.SelectEvent, Select, "CardVisul");
		parentCard.AddEventListeners(parentCard.PointerEnterEvent, PointerEnter, "CardVisul");
		parentCard.AddEventListeners(parentCard.PointerExitEvent, PointerExit, "CardVisul");
		parentCard.AddEventListeners(parentCard.BeginDragEvent, BeginDrag, "CardVisul");
		parentCard.AddEventListeners(parentCard.EndDragEvent, EndDrag, "CardVisul");
		parentCard.AddEventListeners(parentCard.PointerDownEvent, PointerDown, "CardVisul");
		parentCard.AddEventListeners(parentCard.PointerUpEvent, PointerUp, "CardVisul");
	}

	public void UpdateIndex(int length)
	{
		base.transform.SetSiblingIndex(parentCard.transform.parent.GetSiblingIndex() + length);
	}

	private void LateUpdate()
	{
		if (initalize && !(parentCard == null) && base.gameObject.activeInHierarchy)
		{
			HandPositioning();
			if (!playingAnimation)
			{
				SmoothFollow();
				FollowRotation();
			}
			CardTilt();
			UpdateShowInfo();
			if (parentCard.place == BloodCardEnum.PlaceType.BOARD && base.transform.GetSiblingIndex() > MonoSingleton<BloodCardManager>.Instance.Board.boardCardNum && !playingAnimation)
			{
				base.transform.SetAsFirstSibling();
			}
		}
	}

	private void UpdateShowInfo()
	{
		if (parentCard.place == BloodCardEnum.PlaceType.BOARD || parentCard.place == BloodCardEnum.PlaceType.CHANGE || (parentCard.place == BloodCardEnum.PlaceType.HAND && parentCard.belongs == BloodCardEnum.PlayerRole.SELF))
		{
			flippingController.SetSelectedState("false");
			if (parentCard.Data() != null)
			{
				powerText.text = parentCard.Data().power.ToString();
				nameText.text = parentCard.Data().name.ToString();
				descText.text = parentCard.Data().desc.ToString();
				needPointController.SetSelectedState(parentCard.Data().needPoint.ToString());
				if (parentCard.belongs == BloodCardEnum.PlayerRole.ENEMY)
				{
					cardController.SetSelectedState((parentCard.Data().rare == BloodCardEnum.CardRarity.GOLD) ? "redGold" : "red");
				}
				else
				{
					cardController.SetSelectedState((parentCard.Data().rare == BloodCardEnum.CardRarity.GOLD) ? "blueGold" : "blue");
				}
				skillController.SetSelectedState((parentCard.Data().effects.Count > 0) ? "true" : "false");
				changeFrameController.SetSelectedState((parentCard.Data().rare == BloodCardEnum.CardRarity.GOLD) ? "gold" : "normal");
			}
			else
			{
				Debug.LogError("LHL 卡牌数据不存在 name:" + parentCard.name);
			}
		}
		else
		{
			if (parentCard.belongs == BloodCardEnum.PlayerRole.ENEMY)
			{
				cardController.SetSelectedState("red");
			}
			else
			{
				cardController.SetSelectedState("blue");
			}
			flippingController.SetSelectedState("true");
		}
	}

	public void SetCardCells()
	{
		if (parentCard.Data() == null)
		{
			return;
		}
		foreach (ControllerExCollection cellController in cellControllerList)
		{
			cellController.GetController("middle").SetSelectedState("false");
			cellController.GetController("grid").SetSelectedState("false");
			cellController.GetController("skill").SetSelectedState("false");
		}
		cellControllerList[12].GetController("middle").SetSelectedState("true");
		if (parentCard.Data().controllEffects != null)
		{
			foreach (Vector2 controllEffect in parentCard.Data().controllEffects)
			{
				int num = MonoSingleton<BloodCardManager>.Instance.ConverPosToIndex(12, controllEffect, 5, 5);
				if (num != -1)
				{
					cellControllerList[num].GetController("grid").SetSelectedState("true");
				}
			}
		}
		if (parentCard.Data().effects != null)
		{
			foreach (Effect effect in parentCard.Data().effects)
			{
				if (effect.effectPosList == null)
				{
					continue;
				}
				foreach (Vector2 effectPos in effect.effectPosList)
				{
					int num2 = MonoSingleton<BloodCardManager>.Instance.ConverPosToIndex(12, effectPos, 5, 5);
					if (num2 != -1)
					{
						cellControllerList[num2].GetController("skill").SetSelectedState("true");
					}
				}
			}
		}
		icon.sprite = AtlasManager.GetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_Com/CORGUI_3_10_BloodCardUI/" + parentCard.Data().icon);
	}

	private void HandPositioning()
	{
		curveYOffset = curve.positioning.Evaluate(parentCard.NormalizedPosition()) * curve.positioningInfluence * (float)parentCard.SiblingAmount();
		curveYOffset = ((parentCard.SiblingAmount() < 5 || parentCard.place == BloodCardEnum.PlaceType.BOARD || parentCard.place == BloodCardEnum.PlaceType.DECK || parentCard.belongs == BloodCardEnum.PlayerRole.ENEMY || parentCard.belongs == BloodCardEnum.PlayerRole.SYSTEM) ? 0f : curveYOffset);
		curveRotationOffset = curve.rotation.Evaluate(parentCard.NormalizedPosition());
	}

	private void SmoothFollow()
	{
		Vector3 vector = Vector3.up * (parentCard.IsDragging() ? 0f : curveYOffset);
		base.transform.position = Vector3.Lerp(base.transform.position, cardTransform.position + vector, followSpeed * Time.deltaTime);
	}

	private void FollowRotation()
	{
		Vector3 vector = base.transform.position - cardTransform.position;
		movementDelta = Vector3.Lerp(movementDelta, vector, 25f * Time.deltaTime);
		Vector3 b = (parentCard.IsDragging() ? movementDelta : vector) * rotationAmount;
		rotationDelta = Vector3.Lerp(rotationDelta, b, rotationSpeed * Time.deltaTime);
		base.transform.eulerAngles = new Vector3(base.transform.eulerAngles.x, base.transform.eulerAngles.y, Mathf.Clamp(rotationDelta.x, -60f, 60f));
	}

	private void CardTilt()
	{
		if (shaking && !playingAnimation)
		{
			savedIndex = (parentCard.IsDragging() ? savedIndex : parentCard.ParentIndex());
			float num = Mathf.Sin(Time.time + (float)savedIndex) * (parentCard.IsHovering() ? 0.2f : 1f);
			float num2 = Mathf.Cos(Time.time + (float)savedIndex) * (parentCard.IsHovering() ? 0.2f : 1f);
			RectTransformUtility.ScreenPointToWorldPointInRectangle(canvas.transform as RectTransform, Input.mousePosition, CanvasManager.Instance.uiCamera, out var worldPoint);
			Vector3 vector = base.transform.position - worldPoint;
			float num3 = (parentCard.IsHovering() ? (vector.y * -1f * manualTiltAmount) : 0f);
			float num4 = (parentCard.IsHovering() ? (vector.x * manualTiltAmount) : 0f);
			float b = (parentCard.IsHovering() ? tiltParent.eulerAngles.z : (curveRotationOffset * (curve.rotationInfluence * (float)parentCard.SiblingAmount())));
			float x = Mathf.LerpAngle(tiltParent.eulerAngles.x, num3 + num * autoTiltAmount, tiltSpeed * Time.deltaTime);
			float y = Mathf.LerpAngle(tiltParent.eulerAngles.y, num4 + num2 * autoTiltAmount, tiltSpeed * Time.deltaTime);
			float z = Mathf.LerpAngle(tiltParent.eulerAngles.z, b, tiltSpeed / 2f * Time.deltaTime);
			tiltParent.eulerAngles = new Vector3(x, y, z);
		}
		else
		{
			tiltParent.eulerAngles = new Vector3(0f, 0f, 0f);
		}
	}

	public void SetCardShaking(bool value)
	{
		shaking = value;
	}

	private void Select(Card card, bool state)
	{
		if (scaleAnimations)
		{
			LeanTween.scale(base.gameObject, parentCard.Selected() ? (Vector3.one * scaleOnSelect) : (Vector3.one * scaleOnHover), scaleTransition).setEase(scaleEase);
		}
	}

	public void Swap(float dir = 1f)
	{
		if (swapAnimations)
		{
			LeanTween.cancel(base.gameObject);
			LeanTween.rotateAroundLocal(shakeParent.gameObject, Vector3.forward, swapRotationAngle * dir, swapTransition).setLoopPingPong(swapVibrato);
		}
	}

	private void BeginDrag(Card card)
	{
		descriptionGo.SetActive(value: false);
		if (scaleAnimations)
		{
			LeanTween.scale(base.gameObject, Vector3.one * scaleOnSelect, scaleTransition).setEase(scaleEase);
		}
		shadowCanvas.sortingOrder = 2;
	}

	private void EndDrag(Card card)
	{
		if (scaleAnimations)
		{
			LeanTween.scale(base.gameObject, Vector3.one, scaleTransition).setEase(scaleEase);
		}
		shadowCanvas.sortingOrder = (int)shadowOffset * -1;
	}

	private void PointerEnter(Card card)
	{
		if (!parentCard.WasDragged() && !parentCard.Selected() && scaleAnimations)
		{
			LeanTween.scale(base.gameObject, Vector3.one * scaleOnHover, scaleTransition).setEase(scaleEase);
		}
	}

	private void PointerExit(Card card)
	{
		descriptionGo.SetActive(value: false);
		if (!parentCard.WasDragged() && !parentCard.Selected())
		{
			LeanTween.scale(base.gameObject, Vector3.one, scaleTransition).setEase(scaleEase);
		}
	}

	private void PointerUp(Card card, bool longPress)
	{
		descriptionGo.SetActive(value: false);
		visualShadow.localPosition = shadowDistance;
	}

	private void PointerDown(Card card)
	{
		if (parentCard.Data() != null)
		{
			descriptionGo.SetActive(value: true);
		}
		visualShadow.localPosition += -Vector3.up * shadowOffset;
	}

	public void PlayCardVisualEffect(BloodCardEnum.PlayEffectType type)
	{
		StartCoroutine(PlayEffectCorutine(type));
	}

	private IEnumerator PlayEffectCorutine(BloodCardEnum.PlayEffectType type)
	{
		yield return new WaitForSeconds(0.1f);
		effectGameObjectList[(int)type].SetActive(value: true);
		yield return new WaitForSeconds(1f);
		effectGameObjectList[(int)type].SetActive(value: false);
	}

	public void PlayPrePlaceEffectAni()
	{
		AudioManager.Instance.Play("effect", BloodCardManager.CUE_NAME, "minigame_activity_3_10_card_putdown03", useStream: false);
		goldPrePlaceAni.Play("UI_card_goden_yellow");
	}

	public void PlayHideEffectAni()
	{
		goldPrePlaceAni.Play("UI_card_Alpha_hide");
		goldPrePlaceAni.Update(0f);
	}

	public void ResetPrePlaceAni()
	{
		goldPrePlaceAni.Play("UI_card_entry");
		goldPrePlaceAni.Update(0f);
	}

	public void PlayPlacingPlaceEffectAni()
	{
		scaleAni.Play("UI_CardVisual_UI_scale");
	}

	public void OnDestroy()
	{
		StopAllCoroutines();
	}
}
