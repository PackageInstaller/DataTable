using System;
using System.Collections;
using UnityEngine;

namespace RogueCard;

public class VisualCardBase : MonoBehaviour, IRogueCardNeedTip
{
	protected bool initalize;

	private int savedIndex;

	[Header("RogueCard")]
	[HideInInspector]
	public RogueCard parentCard;

	protected Transform cardTransform;

	protected Vector3 rotationDelta;

	private Vector3 movementDelta;

	protected Canvas canvas;

	public RogueCardVisualCardHandler visualHandler;

	public RogueCardHolder holder;

	[Header("References")]
	[SerializeField]
	protected Transform shakeParent;

	[SerializeField]
	protected Transform tiltParent;

	[Header("Follow Parameters")]
	[SerializeField]
	protected float followSpeed = 30f;

	[Header("Rotation Parameters")]
	[SerializeField]
	protected float rotationAmount = 20f;

	[SerializeField]
	protected float rotationSpeed = 20f;

	[SerializeField]
	private float autoTiltAmount = 30f;

	[SerializeField]
	private float manualTiltAmount = 20f;

	[SerializeField]
	private float tiltSpeed = 20f;

	[Header("Scale Parameters")]
	[SerializeField]
	protected float scaleOnSelect = 1.05f;

	[SerializeField]
	protected float scaleTransition = 0.15f;

	[Header("Swap Parameters")]
	[SerializeField]
	private bool swapAnimations = true;

	[SerializeField]
	private float swapTransition = 0.15f;

	[Header("Curve")]
	[SerializeField]
	protected CurveParameters curve;

	private float curveYOffset;

	private float curveRotationOffset;

	private bool isAni;

	[HideInInspector]
	public virtual bool CanSelect => false;

	public virtual void Initialize(RogueCard target, int index = 0)
	{
		parentCard = target;
		cardTransform = target.transform;
		canvas = GetComponent<Canvas>();
		parentCard.PointerEnterEvent.AddListener(PointerEnter);
		parentCard.PointerExitEvent.AddListener(PointerExit);
		parentCard.BeginDragEvent.AddListener(BeginDrag);
		parentCard.EndDragEvent.AddListener(EndDrag);
		parentCard.PointerDownEvent.AddListener(PointerDown);
		parentCard.PointerUpEvent.AddListener(PointerUp);
		initalize = true;
	}

	public void UpdateIndex(int length)
	{
		base.transform.SetSiblingIndex(parentCard.transform.parent.GetSiblingIndex());
	}

	private void LateUpdate()
	{
		if (initalize && !(parentCard == null) && !isAni)
		{
			HandPositioning();
			SmoothFollow();
			FollowRotation();
		}
	}

	private void HandPositioning()
	{
		curveRotationOffset = curve.rotation.Evaluate(parentCard.NormalizedPosition());
	}

	private void SmoothFollow()
	{
		Vector3 vector = Vector3.up * (parentCard.isDragging ? 0f : curveYOffset);
		base.transform.position = Vector3.Lerp(base.transform.position, cardTransform.position + vector, followSpeed * Time.deltaTime);
	}

	private void FollowRotation()
	{
		Vector3 vector = base.transform.position - cardTransform.position;
		movementDelta = Vector3.Lerp(movementDelta, vector, 5f * Time.deltaTime);
		Vector3 b = (parentCard.isDragging ? movementDelta : vector) * rotationAmount;
		rotationDelta = Vector3.Lerp(rotationDelta, b, 5f * Time.deltaTime);
		if (vector.magnitude < 0.1f && !parentCard.isDragging)
		{
			base.transform.eulerAngles = new Vector3(base.transform.eulerAngles.x, base.transform.eulerAngles.y, 0f);
			rotationDelta = Vector3.zero;
		}
		else
		{
			base.transform.eulerAngles = new Vector3(base.transform.eulerAngles.x, base.transform.eulerAngles.y, Mathf.Clamp(rotationDelta.x, -60f, 60f));
		}
	}

	public void SmoothMoveToPosition(Vector3 targetPosition, float duration = 0.3f, Action onComplete = null)
	{
		isAni = true;
		StopAllCoroutines();
		LeanTween.cancel(base.transform as RectTransform);
		LeanTween.move(base.transform as RectTransform, targetPosition, duration).setEase(LeanTweenType.easeOutCubic).setOnComplete((Action)delegate
		{
			onComplete?.Invoke();
			isAni = false;
		});
	}

	public void SmoothMoveToSlot(RectTransform slotParent, float duration = 0.3f, Action onComplete = null)
	{
		isAni = true;
		StopAllCoroutines();
		LeanTween.cancel(base.transform as RectTransform);
		Vector2 vector = visualHandler.GetComponent<RectTransform>().InverseTransformPoint(slotParent.position);
		LeanTween.move(base.transform as RectTransform, vector, duration).setEase(LeanTweenType.easeOutCubic).setOnComplete((Action)delegate
		{
			onComplete?.Invoke();
			try
			{
				if (parentCard != null && slotParent != null)
				{
					parentCard.transform.SetParent(slotParent);
					parentCard.transform.localPosition = Vector3.zero;
					base.transform.position = slotParent.position;
				}
			}
			catch (Exception ex)
			{
				Debug.LogWarning("SmoothMoveToSlot onComplete reparent failed: " + ex.Message);
			}
			isAni = false;
		});
	}

	public void SmoothMoveToHandIndex(RogueCardHolder handController, int targetIndex, Vector3? startPosition = null, float duration = 0.5f, bool moveVisualAlso = true)
	{
		if (handController == null)
		{
			return;
		}
		isAni = true;
		if (targetIndex < 0 || targetIndex >= handController.cards.Count)
		{
			Debug.LogError($"Target index {targetIndex} is out of range!");
			return;
		}
		Transform targetSlot = handController.slots[targetIndex].transform;
		_ = base.transform.parent;
		base.transform.SetParent(canvas.transform);
		base.transform.SetAsLastSibling();
		if (startPosition.HasValue)
		{
			base.transform.position = startPosition.Value;
		}
		if (moveVisualAlso)
		{
			base.transform.SetParent(canvas.transform);
			base.transform.position = base.transform.position;
			LeanTween.move(base.gameObject, targetSlot.position, duration).setEase(LeanTweenType.easeOutBack);
		}
		LeanTween.move(base.gameObject, targetSlot.position, duration).setEase(LeanTweenType.easeOutCubic).setOnComplete((Action)delegate
		{
			base.transform.SetParent(targetSlot);
			base.transform.localPosition = Vector3.zero;
			if (moveVisualAlso)
			{
				base.transform.SetParent(visualHandler?.transform ?? canvas.transform);
			}
			UpdateIndex(handController.transform.childCount);
			isAni = false;
		});
	}

	public void DeckToPositionWithAnimation(Vector3 targetPosition, Vector3 deckPosition, float delay = 0f, float duration = 0.7f)
	{
		base.transform.position = deckPosition;
		LeanTween.move(base.gameObject, targetPosition, duration).setDelay(delay).setEase(LeanTweenType.easeOutBack)
			.setOnStart(delegate
			{
			})
			.setOnComplete((Action)delegate
			{
				LeanTween.moveLocal(base.gameObject, Vector3.zero, 0.2f).setEase(LeanTweenType.easeOutBounce);
			});
	}

	public void FlyWithArc(Vector3 startPos, Vector3 endPos, float height = 100f, float duration = 0.8f)
	{
		base.transform.position = startPos;
		Vector3 control = (startPos + endPos) * 0.5f;
		control.y += height;
		StartCoroutine(ArcCoroutine(startPos, control, endPos, duration));
	}

	private IEnumerator ArcCoroutine(Vector3 start, Vector3 control, Vector3 end, float duration)
	{
		float elapsed = 0f;
		while (elapsed < duration)
		{
			elapsed += Time.deltaTime;
			float num = elapsed / duration;
			Vector3 position = (1f - num) * (1f - num) * start + 2f * (1f - num) * num * control + num * num * end;
			base.transform.position = position;
			float z = Mathf.Lerp(0f, 180f, num);
			base.transform.rotation = Quaternion.Euler(0f, 0f, z);
			yield return null;
		}
		base.transform.position = end;
		base.transform.rotation = Quaternion.identity;
	}

	protected virtual void BeginDrag(RogueCard card)
	{
		LeanTween.scale(base.gameObject, Vector3.one * scaleOnSelect, scaleTransition).setEase(LeanTweenType.easeOutBack);
		canvas.overrideSorting = true;
	}

	protected virtual void EndDrag(RogueCard card)
	{
		canvas.overrideSorting = false;
		LeanTween.scale(base.gameObject, Vector3.one, scaleTransition).setEase(LeanTweenType.easeOutBack);
	}

	public virtual void SetSelect(bool isSelect)
	{
	}

	private void PointerEnter(RogueCard card)
	{
	}

	private void PointerExit(RogueCard card)
	{
	}

	private void PointerUp(RogueCard card, bool longPress)
	{
	}

	private void PointerDown(RogueCard card)
	{
	}

	public virtual void SetLookTips(bool isSelect)
	{
	}
}
