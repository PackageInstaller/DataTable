using System;
using System.Collections;
using System.Collections.Generic;
using ACT.Battle;
using ACT.UI.InputController;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.UI;

namespace ACT.UI.VirtualCursor;

public class GamepadVirtualCursor : MonoBehaviour
{
	[Header("虚拟光标配置")]
	[SerializeField]
	private GameObject virtualCursorPrefab;

	[SerializeField]
	private Canvas targetCanvas;

	[SerializeField]
	private float cursorSpeed = 800f;

	[SerializeField]
	private float deadZone = 0.1f;

	[Header("视觉效果")]
	[SerializeField]
	private AnimationCurve moveCurve = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f);

	[SerializeField]
	private float scaleOnClick = 0.8f;

	[SerializeField]
	private float clickAnimDuration = 0.1f;

	[Header("边界限制")]
	[SerializeField]
	private float screenMargin = 10f;

	private RectTransform virtualCursorRect;

	private Image virtualCursorImage;

	private CanvasGroup virtualCursorCanvasGroup;

	private GraphicRaycaster graphicRaycaster;

	private EventSystem eventSystem;

	private Vector2 cursorPosition;

	private Vector2 lastStickInput;

	private bool isGamepadConnected;

	private bool isVirtualCursorActive;

	private bool isClickAnimating;

	private bool hasCustomMovementBounds;

	private Vector2 movementBoundsMin;

	private Vector2 movementBoundsMax;

	private PointerEventData pointerEventData;

	private GameObject lastHoveredObject;

	private IPointerEnterHandler lastPointerEnterHandler;

	private IPointerExitHandler lastPointerExitHandler;

	[Header("自动吸附")]
	public float snapDistance = 80f;

	public float snapSpeed = 25f;

	private RectTransform currentSnapTarget;

	private bool isSnapping;

	public bool isActive => isVirtualCursorActive;

	public static GamepadVirtualCursor Instance { get; private set; }

	public event Action OnSnapToIcon;

	public event Action OnLeaveIcon;

	private void Awake()
	{
		if (Instance == null)
		{
			Instance = this;
			UnityEngine.Object.DontDestroyOnLoad(gameObject);
			InitializeComponents();
		}
		else
		{
			UnityEngine.Object.Destroy(gameObject);
		}
	}

	private void Start()
	{
		CreateVirtualCursor();
		SetupEventSystem();
	}

	private void Update()
	{
		CheckGamepadConnection();
		if (isGamepadConnected)
		{
			UpdateVirtualCursorPosition();
			HandleHoverEffects();
			HandleVirtualCursorVisibility();
			HandleAutoSnap();
		}
	}

	private void OnDestroy()
	{
		OnSnapToIcon = null;
		OnLeaveIcon = null;
		if (Instance == this)
		{
			Instance = null;
		}
	}

	private void InitializeComponents()
	{
		if (targetCanvas == null)
		{
			targetCanvas = UnityEngine.Object.FindObjectOfType<Canvas>();
		}
		if (targetCanvas != null)
		{
			graphicRaycaster = targetCanvas.GetComponent<GraphicRaycaster>();
		}
	}

	private void CreateVirtualCursor()
	{
		GameObject gameObject = UnityEngine.Object.Instantiate(virtualCursorPrefab, targetCanvas.transform);
		virtualCursorRect = gameObject.GetComponent<RectTransform>();
		virtualCursorImage = gameObject.GetComponent<Image>();
		virtualCursorCanvasGroup = gameObject.GetComponent<CanvasGroup>();
		virtualCursorRect.anchorMin = Vector2.zero;
		virtualCursorRect.anchorMax = Vector2.zero;
		virtualCursorRect.pivot = new Vector2(0.5f, 0.5f);
		if (virtualCursorCanvasGroup == null)
		{
			virtualCursorCanvasGroup = gameObject.AddComponent<CanvasGroup>();
		}
		RectTransform rectTransform = targetCanvas.transform as RectTransform;
		cursorPosition = new Vector2(rectTransform.rect.width * 0.5f, rectTransform.rect.height * 0.5f);
		UpdateCursorDisplayPosition();
		SetVirtualCursorVisible(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	private void SetupEventSystem()
	{
		eventSystem = EventSystemHelper.Shared;
		if (eventSystem == null && LuminApplication.LogEnabled)
		{
			Debug.LogWarning("EventSystem not found! Virtual cursor may not work properly.");
		}
		pointerEventData = new PointerEventData(eventSystem);
	}

	private void CheckGamepadConnection()
	{
		isGamepadConnected = Gamepad.current != null && Gamepad.current.enabled && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
	}

	private void OnGamepadConnectionChanged(bool connected)
	{
		SetVirtualCursorVisible(connected);
	}

	public void HandleGamepadInput(Vector2 input)
	{
		if (Gamepad.current != null)
		{
			Vector2 vector = input;
			vector = ((!(vector.magnitude < deadZone)) ? ((vector - vector.normalized * deadZone) / (1f - deadZone)) : Vector2.zero);
			lastStickInput = vector;
		}
	}

	public void HandleClickInput()
	{
		SimulateClick();
	}

	public void UpdateVirtualCursorPosition()
	{
		if (isVirtualCursorActive && !(virtualCursorRect == null))
		{
			Vector2 vector = lastStickInput * cursorSpeed * Time.deltaTime;
			if (vector.magnitude > 3f)
			{
				isSnapping = false;
				OnLeaveIcon?.Invoke();
				currentSnapTarget = null;
			}
			else if (isSnapping && (bool)currentSnapTarget)
			{
				return;
			}
			cursorPosition += vector;
			Rect cursorMovementBounds = GetCursorMovementBounds();
			cursorPosition.x = Mathf.Clamp(cursorPosition.x, cursorMovementBounds.xMin, cursorMovementBounds.xMax);
			cursorPosition.y = Mathf.Clamp(cursorPosition.y, cursorMovementBounds.yMin, cursorMovementBounds.yMax);
			UpdateCursorDisplayPosition();
			if (pointerEventData != null)
			{
				pointerEventData.position = cursorPosition;
			}
		}
	}

	private void HandleVirtualCursorVisibility()
	{
		if (lastStickInput.magnitude > 0.01f && Gamepad.current != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && !isVirtualCursorActive)
		{
			SetVirtualCursorVisible(visible: true);
		}
	}

	public void SetVirtualCursorVisible(bool visible)
	{
		if (!(virtualCursorCanvasGroup == null))
		{
			isVirtualCursorActive = visible;
			virtualCursorCanvasGroup.alpha = (visible ? 1f : 0f);
		}
	}

	private IEnumerator FadeVirtualCursor(float targetAlpha, float duration)
	{
		float startAlpha = virtualCursorCanvasGroup.alpha;
		float elapsedTime = 0f;
		while (elapsedTime < duration)
		{
			elapsedTime += Time.deltaTime;
			float time = elapsedTime / duration;
			virtualCursorCanvasGroup.alpha = Mathf.Lerp(startAlpha, targetAlpha, moveCurve.Evaluate(time));
			yield return null;
		}
		virtualCursorCanvasGroup.alpha = targetAlpha;
	}

	public void SimulateClick()
	{
		if (!isVirtualCursorActive || eventSystem == null || graphicRaycaster == null)
		{
			return;
		}
		StartCoroutine(PlayClickAnimation());
		List<RaycastResult> list = new List<RaycastResult>();
		pointerEventData.position = Singleton<NewUIManager>.instance.UICamera.WorldToScreenPoint(virtualCursorRect.position);
		graphicRaycaster.Raycast(pointerEventData, list);
		if (list.Count > 0)
		{
			GameObject gameObject = list[0].gameObject;
			pointerEventData.pointerPressRaycast = list[0];
			pointerEventData.pointerPress = gameObject;
			pointerEventData.pointerId = 2;
			ExecuteEvents.ExecuteHierarchy(gameObject, pointerEventData, ExecuteEvents.pointerDownHandler);
			ExecuteEvents.ExecuteHierarchy(gameObject, pointerEventData, ExecuteEvents.pointerUpHandler);
			ExecuteEvents.ExecuteHierarchy(gameObject, pointerEventData, ExecuteEvents.pointerClickHandler);
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("虚拟光标点击了: " + gameObject.name);
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.Log($"射线检测未命中任何UI元素！光标位置: {cursorPosition}");
		}
	}

	private void HandleHoverEffects()
	{
		if (!isVirtualCursorActive || eventSystem == null || graphicRaycaster == null)
		{
			return;
		}
		List<RaycastResult> list = new List<RaycastResult>();
		pointerEventData.position = Singleton<NewUIManager>.instance.UICamera.WorldToScreenPoint(virtualCursorRect.position);
		graphicRaycaster.Raycast(pointerEventData, list);
		GameObject gameObject = ((list.Count > 0 && list[0].gameObject.GetComponent<ActButton>() != null) ? list[0].gameObject : null);
		if (gameObject != lastHoveredObject)
		{
			if (lastHoveredObject != null)
			{
				ExecuteEvents.Execute(lastHoveredObject, pointerEventData, ExecuteEvents.pointerExitHandler);
				if (isSnapping && currentSnapTarget != null && lastHoveredObject.GetComponent<RectTransform>() == currentSnapTarget)
				{
					isSnapping = false;
					OnLeaveIcon?.Invoke();
					currentSnapTarget = null;
				}
			}
			if (gameObject != null)
			{
				ExecuteEvents.Execute(gameObject, pointerEventData, ExecuteEvents.pointerEnterHandler);
			}
			lastHoveredObject = gameObject;
		}
		if (gameObject != null && lastStickInput == Vector2.zero)
		{
			RectTransform component = gameObject.GetComponent<RectTransform>();
			if (component != null && !isSnapping)
			{
				AutoSnapToUI(component);
			}
		}
	}

	private IEnumerator PlayClickAnimation()
	{
		if (!isClickAnimating && !(virtualCursorRect == null))
		{
			isClickAnimating = true;
			Vector3 originalScale = virtualCursorRect.localScale;
			Vector3 targetScale = originalScale * scaleOnClick;
			float elapsedTime = 0f;
			while (elapsedTime < clickAnimDuration * 0.5f)
			{
				elapsedTime += Time.deltaTime;
				float t = elapsedTime / (clickAnimDuration * 0.5f);
				virtualCursorRect.localScale = Vector3.Lerp(originalScale, targetScale, t);
				yield return null;
			}
			elapsedTime = 0f;
			while (elapsedTime < clickAnimDuration * 0.5f)
			{
				elapsedTime += Time.deltaTime;
				float t2 = elapsedTime / (clickAnimDuration * 0.5f);
				virtualCursorRect.localScale = Vector3.Lerp(targetScale, originalScale, t2);
				yield return null;
			}
			virtualCursorRect.localScale = originalScale;
			isClickAnimating = false;
		}
	}

	public void EnableVirtualCursor()
	{
		SetVirtualCursorVisible(visible: true);
	}

	public void DisableVirtualCursor()
	{
		SetVirtualCursorVisible(visible: false);
	}

	public void SetCursorSpeed(float speed)
	{
		cursorSpeed = Mathf.Max(0f, speed);
	}

	public void SetDeadZone(float deadZone)
	{
		this.deadZone = Mathf.Clamp01(deadZone);
	}

	public Vector2 GetCursorPosition()
	{
		return cursorPosition;
	}

	public void SetCursorPosition(Vector2 position)
	{
		cursorPosition = position;
		if (virtualCursorRect != null)
		{
			UpdateCursorDisplayPosition();
		}
	}

	public Rect GetDefaultCursorMovementBounds()
	{
		RectTransform rectTransform = ((targetCanvas != null) ? (targetCanvas.transform as RectTransform) : null);
		Vector2 vector = new Vector2(screenMargin, screenMargin);
		Vector2 rhs = ((rectTransform == null) ? vector : new Vector2(rectTransform.rect.width - screenMargin, rectTransform.rect.height - screenMargin));
		rhs = Vector2.Max(vector, rhs);
		return Rect.MinMaxRect(vector.x, vector.y, rhs.x, rhs.y);
	}

	public Rect GetCursorMovementBounds()
	{
		Rect defaultCursorMovementBounds = GetDefaultCursorMovementBounds();
		Vector2 lhs = defaultCursorMovementBounds.min;
		Vector2 vector = defaultCursorMovementBounds.max;
		if (hasCustomMovementBounds)
		{
			lhs = Vector2.Max(lhs, movementBoundsMin);
			vector = Vector2.Min(vector, movementBoundsMax);
		}
		vector = Vector2.Max(lhs, vector);
		return Rect.MinMaxRect(lhs.x, lhs.y, vector.x, vector.y);
	}

	public Vector2 GetScreenCenter()
	{
		return GetDefaultCursorMovementBounds().center;
	}

	public void SetCursorMovementBounds(Vector2 min, Vector2 max)
	{
		hasCustomMovementBounds = true;
		movementBoundsMin = Vector2.Min(min, max);
		movementBoundsMax = Vector2.Max(min, max);
	}

	public void ClearCursorMovementBounds()
	{
		hasCustomMovementBounds = false;
	}

	public void CancelAutoSnap()
	{
		if (isSnapping || !(currentSnapTarget == null))
		{
			isSnapping = false;
			currentSnapTarget = null;
			OnLeaveIcon?.Invoke();
		}
	}

	public void ResetToScreenCenter()
	{
		RectTransform rectTransform = ((targetCanvas != null) ? (targetCanvas.transform as RectTransform) : null);
		if (!(rectTransform == null))
		{
			lastStickInput = Vector2.zero;
			CancelAutoSnap();
			ClearCursorMovementBounds();
			cursorPosition = rectTransform.rect.size * 0.5f;
			UpdateCursorDisplayPosition();
			if (pointerEventData != null)
			{
				pointerEventData.position = cursorPosition;
			}
			OnLeaveIcon?.Invoke();
		}
	}

	public RectTransform GetSnapTarget()
	{
		return currentSnapTarget;
	}

	private void AutoSnapToUI(RectTransform targetRT)
	{
		if (!(targetRT == null))
		{
			currentSnapTarget = targetRT;
			OnSnapToIcon?.Invoke();
			isSnapping = true;
		}
	}

	private void HandleAutoSnap()
	{
		if (!isSnapping || currentSnapTarget == null)
		{
			return;
		}
		RectTransform rectTransform = targetCanvas.transform as RectTransform;
		Vector2 screenPoint = RectTransformUtility.WorldToScreenPoint(Singleton<NewUIManager>.instance.UICamera, currentSnapTarget.position);
		Vector2 screenPoint2 = RectTransformUtility.WorldToScreenPoint(Singleton<NewUIManager>.instance.UICamera, virtualCursorRect.position);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, screenPoint, Singleton<NewUIManager>.instance.UICamera, out var localPoint);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, screenPoint2, Singleton<NewUIManager>.instance.UICamera, out var localPoint2);
		float num = Vector2.Distance(localPoint2, localPoint);
		if (num > snapDistance * 1.5f)
		{
			isSnapping = false;
			OnLeaveIcon?.Invoke();
			currentSnapTarget = null;
			return;
		}
		RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, screenPoint, Singleton<NewUIManager>.instance.UICamera, out localPoint2);
		Vector2 b = localPoint2 + new Vector2(rectTransform.rect.width * 0.5f, rectTransform.rect.height * 0.5f);
		if (num < 5f)
		{
			cursorPosition = b;
		}
		else
		{
			cursorPosition = Vector2.Lerp(cursorPosition, b, snapSpeed * Time.deltaTime);
		}
		UpdateCursorDisplayPosition();
		if (pointerEventData != null)
		{
			pointerEventData.position = Singleton<NewUIManager>.instance.UICamera.WorldToScreenPoint(virtualCursorRect.position);
		}
	}

	private void UpdateCursorDisplayPosition()
	{
		if (!(virtualCursorRect == null))
		{
			virtualCursorRect.anchoredPosition = cursorPosition;
		}
	}
}
