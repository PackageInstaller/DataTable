using System;
using ACT.Battle;
using Fundamental;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.UI;

namespace ACT.UI;

public class RightStickScrollSupport : MonoBehaviour
{
	[Header("滑动设置")]
	[SerializeField]
	private RightStickScrollSettings settings = new RightStickScrollSettings();

	[Header("自动检测目标")]
	[SerializeField]
	private bool autoDetectTarget = true;

	[Header("手动指定目标（可选）")]
	[SerializeField]
	private ScrollRect targetScrollRect;

	[SerializeField]
	private LoopVerticalScrollRect targetLoopScrollRect;

	private Vector2 rightStickInput = Vector2.zero;

	private Vector2 currentVelocity = Vector2.zero;

	private bool isScrolling;

	private ScrollRect detectedScrollRect;

	private LoopVerticalScrollRect detectedLoopScrollRect;

	private bool forbidScroll;

	private IBaseUIView uiView;

	private RectTransform viewportRectTransform;

	private RectTransform contentRectTransform;

	private bool isSmallContentScrolling;

	private Vector2 smallContentOffset = Vector2.zero;

	private bool needsReturnToCenter;

	private bool isContentFull = true;

	private RectTransformDimensionsListener viewportListener;

	private RectTransformDimensionsListener contentListener;

	private void Start()
	{
		InitializeTargets();
		if (settings.bindingAction == string.Empty)
		{
			settings.bindingAction = "UI/ScrollViewRightStickControl";
		}
		RefreshSizeListeners();
		RecalculateContentFull();
	}

	private void OnDestroy()
	{
		RemoveSizeListeners();
	}

	private void RefreshSizeListeners()
	{
		RemoveSizeListeners();
		RectTransform viewport = null;
		RectTransform content = null;
		GetActiveViewportAndContent(out viewport, out content);
		if (viewport != null)
		{
			viewportRectTransform = viewport;
			viewportListener = viewportRectTransform.GetOrAddComponent<RectTransformDimensionsListener>();
			RectTransformDimensionsListener rectTransformDimensionsListener = viewportListener;
			rectTransformDimensionsListener.OnDimensionsChanged = (Action)Delegate.Combine(rectTransformDimensionsListener.OnDimensionsChanged, new Action(OnTargetSizeChanged));
		}
		if (content != null)
		{
			contentRectTransform = content;
			contentListener = contentRectTransform.GetOrAddComponent<RectTransformDimensionsListener>();
			RectTransformDimensionsListener rectTransformDimensionsListener2 = contentListener;
			rectTransformDimensionsListener2.OnDimensionsChanged = (Action)Delegate.Combine(rectTransformDimensionsListener2.OnDimensionsChanged, new Action(OnTargetSizeChanged));
		}
	}

	private void RemoveSizeListeners()
	{
		if (viewportListener != null)
		{
			RectTransformDimensionsListener rectTransformDimensionsListener = viewportListener;
			rectTransformDimensionsListener.OnDimensionsChanged = (Action)Delegate.Remove(rectTransformDimensionsListener.OnDimensionsChanged, new Action(OnTargetSizeChanged));
			viewportListener = null;
		}
		if (contentListener != null)
		{
			RectTransformDimensionsListener rectTransformDimensionsListener2 = contentListener;
			rectTransformDimensionsListener2.OnDimensionsChanged = (Action)Delegate.Remove(rectTransformDimensionsListener2.OnDimensionsChanged, new Action(OnTargetSizeChanged));
			contentListener = null;
		}
	}

	private void OnTargetSizeChanged()
	{
		RecalculateContentFull();
	}

	private void RecalculateContentFull()
	{
		if (viewportRectTransform == null || contentRectTransform == null)
		{
			isContentFull = true;
			return;
		}
		Vector2 size = viewportRectTransform.rect.size;
		Vector2 size2 = contentRectTransform.rect.size;
		bool flag = size2.x > size.x + 0.001f;
		bool flag2 = size2.y > size.y + 0.001f;
		if (settings.onlyVertical)
		{
			isContentFull = flag2;
		}
		else if (settings.onlyHorizontal)
		{
			isContentFull = flag;
		}
		else
		{
			isContentFull = flag | flag2;
		}
		forbidScroll = settings.forbiddenScrollWhenContentNotFull && !isContentFull;
	}

	private void GetActiveViewportAndContent(out RectTransform viewport, out RectTransform content)
	{
		viewport = null;
		content = null;
		if (targetLoopScrollRect != null)
		{
			viewport = targetLoopScrollRect.viewport;
			content = targetLoopScrollRect.content;
		}
		else if (targetScrollRect != null)
		{
			viewport = targetScrollRect.viewport;
			content = targetScrollRect.content;
		}
		else if (detectedLoopScrollRect != null)
		{
			viewport = detectedLoopScrollRect.viewport;
			content = detectedLoopScrollRect.content;
		}
		else if (detectedScrollRect != null)
		{
			viewport = detectedScrollRect.viewport;
			content = detectedScrollRect.content;
		}
	}

	private bool CheckIsInTopUIView()
	{
		if (uiView == null)
		{
			return true;
		}
		IBaseUIController topActiveUI = Fundamental.Singleton<NewUIManager>.instance.GetTopActiveUI();
		if (topActiveUI == null)
		{
			return false;
		}
		return topActiveUI.GetUIView() == uiView;
	}

	private void Update()
	{
		if (settings.enableControl && !forbidScroll && CheckIsInTopUIView() && gameObject.activeSelf)
		{
			UpdateRightStickInput();
			HandleScrolling();
		}
	}

	private void InitializeTargets()
	{
		if (!autoDetectTarget)
		{
			return;
		}
		if (detectedScrollRect == null)
		{
			detectedScrollRect = GetComponent<ScrollRect>();
			if (detectedScrollRect == null)
			{
				detectedScrollRect = GetComponentInChildren<ScrollRect>();
			}
		}
		if (detectedLoopScrollRect == null)
		{
			detectedLoopScrollRect = GetComponent<LoopVerticalScrollRect>();
			if (detectedLoopScrollRect == null)
			{
				detectedLoopScrollRect = GetComponentInChildren<LoopVerticalScrollRect>();
			}
		}
		uiView = GetComponentInParent<IBaseUIView>();
	}

	public void SetUiView(IBaseUIView view)
	{
		uiView = view;
	}

	private void UpdateRightStickInput()
	{
		if (Gamepad.current != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && settings.bindingAction != string.Empty)
		{
			Vector2 vector = Fundamental.Singleton<GameInputActionManager>.GetInstance().ReadActionValue<Vector2>(settings.bindingAction, out var _);
			if (vector.magnitude < settings.deadZone)
			{
				rightStickInput = Vector2.zero;
				isScrolling = false;
				return;
			}
			rightStickInput = vector;
			if (settings.invertVertical)
			{
				rightStickInput.y = 0f - rightStickInput.y;
			}
			if (settings.invertHorizontal)
			{
				rightStickInput.x = 0f - rightStickInput.x;
			}
			if (settings.onlyVertical)
			{
				rightStickInput.x = 0f;
			}
			if (settings.onlyHorizontal)
			{
				rightStickInput.y = 0f;
			}
			isScrolling = true;
		}
		else
		{
			rightStickInput = Vector2.zero;
			isScrolling = false;
		}
	}

	private void HandleScrolling()
	{
		HandleSmallContentReturn();
		if (!isScrolling)
		{
			currentVelocity = Vector2.Lerp(currentVelocity, Vector2.zero, settings.scrollSmooth * Time.deltaTime);
			if (currentVelocity.magnitude < 0.01f)
			{
				currentVelocity = Vector2.zero;
			}
		}
		else
		{
			Vector2 b = rightStickInput * settings.scrollSpeed;
			if (settings.accelerationCurve != 1f)
			{
				float magnitude = b.magnitude;
				if (magnitude > 0f)
				{
					float num = Mathf.Pow(magnitude / settings.scrollSpeed, settings.accelerationCurve) * settings.scrollSpeed;
					b = b.normalized * num;
				}
			}
			if (b.magnitude > settings.maxSpeed)
			{
				b = b.normalized * settings.maxSpeed;
			}
			currentVelocity = Vector2.Lerp(currentVelocity, b, settings.scrollSmooth * Time.deltaTime);
		}
		ApplyScrolling(currentVelocity * Time.deltaTime);
	}

	private void HandleSmallContentReturn()
	{
		if (needsReturnToCenter && settings.allowSmallContentScroll && !isScrolling && smallContentOffset.magnitude > 0.001f)
		{
			smallContentOffset = Vector2.Lerp(smallContentOffset, Vector2.zero, settings.smallContentReturnSpeed * Time.deltaTime);
			if (smallContentOffset.magnitude < 0.001f)
			{
				smallContentOffset = Vector2.zero;
				needsReturnToCenter = false;
				isSmallContentScrolling = false;
			}
			ApplySmallContentOffset();
		}
	}

	private void ApplyScrolling(Vector2 scrollDelta)
	{
		if (!(scrollDelta.magnitude < 0.001f))
		{
			if (targetLoopScrollRect != null)
			{
				ApplyToLoopScrollRect(targetLoopScrollRect, scrollDelta);
			}
			else if (targetScrollRect != null)
			{
				ApplyToScrollRect(targetScrollRect, scrollDelta);
			}
			else if (detectedLoopScrollRect != null)
			{
				ApplyToLoopScrollRect(detectedLoopScrollRect, scrollDelta);
			}
			else if (detectedScrollRect != null)
			{
				ApplyToScrollRect(detectedScrollRect, scrollDelta);
			}
		}
	}

	private void ApplyToScrollRect(ScrollRect scrollRect, Vector2 scrollDelta)
	{
		if (scrollRect == null)
		{
			return;
		}
		if (settings.onlyHorizontal && settings.useHorizontalContentPositionBounds && scrollRect.horizontal && scrollRect.content != null)
		{
			Vector2 anchoredPosition = scrollRect.content.anchoredPosition;
			anchoredPosition.x = Mathf.Clamp(anchoredPosition.x - scrollDelta.x, settings.horizontalContentMinX, settings.horizontalContentMaxX);
			scrollRect.content.anchoredPosition = anchoredPosition;
			scrollRect.velocity = Vector2.zero;
			return;
		}
		Vector2 normalizedPosition = scrollRect.normalizedPosition;
		Vector2 size = scrollRect.viewport.rect.size;
		Vector2 sizeDelta = scrollRect.content.sizeDelta;
		Vector2 zero = Vector2.zero;
		bool flag = false;
		if (!settings.onlyVertical)
		{
			if (sizeDelta.x > size.x)
			{
				zero.x = scrollDelta.x / (sizeDelta.x - size.x);
			}
			else if (settings.allowSmallContentScroll && Mathf.Abs(scrollDelta.x) > 0.001f)
			{
				flag = true;
				HandleSmallContentScrolling(scrollRect, scrollDelta, isHorizontal: true);
				return;
			}
		}
		if (!settings.onlyHorizontal)
		{
			if (sizeDelta.y > size.y)
			{
				zero.y = scrollDelta.y / (sizeDelta.y - size.y);
			}
			else if (settings.allowSmallContentScroll && Mathf.Abs(scrollDelta.y) > 0.001f)
			{
				flag = true;
				HandleSmallContentScrolling(scrollRect, scrollDelta, isHorizontal: false);
				return;
			}
		}
		if (!flag)
		{
			Vector2 normalizedPosition2 = normalizedPosition + zero;
			normalizedPosition2.x = Mathf.Clamp01(normalizedPosition2.x);
			normalizedPosition2.y = Mathf.Clamp01(normalizedPosition2.y);
			scrollRect.normalizedPosition = normalizedPosition2;
		}
	}

	private void HandleSmallContentScrolling(ScrollRect scrollRect, Vector2 scrollDelta, bool isHorizontal)
	{
		if (settings.allowSmallContentScroll)
		{
			isSmallContentScrolling = true;
			Vector2 size = scrollRect.viewport.rect.size;
			float num = (isHorizontal ? (size.x * settings.smallContentScrollRange) : (size.y * settings.smallContentScrollRange));
			if (isHorizontal)
			{
				smallContentOffset.x += scrollDelta.x;
				smallContentOffset.x = Mathf.Clamp(smallContentOffset.x, 0f - num, num);
			}
			else
			{
				smallContentOffset.y += scrollDelta.y;
				smallContentOffset.y = Mathf.Clamp(smallContentOffset.y, 0f - num, num);
			}
			ApplySmallContentOffset();
			if (!isScrolling)
			{
				needsReturnToCenter = true;
			}
		}
	}

	private void ApplySmallContentOffset()
	{
		ScrollRect activeScrollRect = GetActiveScrollRect();
		if (!(activeScrollRect == null))
		{
			RectTransform content = activeScrollRect.content;
			_ = activeScrollRect.viewport;
			Vector2 zero = Vector2.zero;
			content.anchoredPosition = zero + smallContentOffset;
		}
	}

	private ScrollRect GetActiveScrollRect()
	{
		if (targetScrollRect != null)
		{
			return targetScrollRect;
		}
		if (detectedScrollRect != null)
		{
			return detectedScrollRect;
		}
		return null;
	}

	private void ApplyToLoopScrollRect(LoopVerticalScrollRect loopScrollRect, Vector2 scrollDelta)
	{
		if (!(loopScrollRect == null) && !settings.onlyHorizontal && Mathf.Abs(scrollDelta.y) > 0.001f)
		{
			Vector2 normalizedPosition = loopScrollRect.normalizedPosition;
			float height = loopScrollRect.viewport.rect.height;
			float y = loopScrollRect.content.sizeDelta.y;
			if (y > height)
			{
				float num = scrollDelta.y / (y - height);
				float y2 = Mathf.Clamp01(normalizedPosition.y + num);
				loopScrollRect.normalizedPosition = new Vector2(normalizedPosition.x, y2);
			}
		}
	}

	public void SetSettings(RightStickScrollSettings newSettings)
	{
		settings = newSettings;
	}

	public void SetForbidScroll(bool isForbid)
	{
		forbidScroll = isForbid;
	}

	public RightStickScrollSettings GetSettings()
	{
		return settings;
	}

	public void SetEnabled(bool enabled)
	{
		settings.enableControl = enabled;
		if (!enabled)
		{
			StopScrolling();
		}
	}

	public bool IsScrolling()
	{
		if (!isScrolling)
		{
			return currentVelocity.magnitude > 0.01f;
		}
		return true;
	}

	public void StopScrolling()
	{
		rightStickInput = Vector2.zero;
		currentVelocity = Vector2.zero;
		isScrolling = false;
		if (isSmallContentScrolling && smallContentOffset.magnitude > 0.001f)
		{
			needsReturnToCenter = true;
		}
	}

	public void SetTargetScrollRect(ScrollRect scrollRect)
	{
		targetScrollRect = scrollRect;
		targetLoopScrollRect = null;
		RefreshSizeListeners();
		RecalculateContentFull();
	}

	public void SetTargetLoopScrollRect(LoopVerticalScrollRect loopScrollRect)
	{
		targetLoopScrollRect = loopScrollRect;
		targetScrollRect = null;
		RefreshSizeListeners();
		RecalculateContentFull();
	}

	public void SetAllowSmallContentScroll(bool allow)
	{
		settings.allowSmallContentScroll = allow;
		if (!allow)
		{
			ResetSmallContentOffset();
		}
	}

	public bool IsSmallContentScrolling()
	{
		return isSmallContentScrolling;
	}

	public void ResetSmallContentOffset()
	{
		smallContentOffset = Vector2.zero;
		needsReturnToCenter = false;
		isSmallContentScrolling = false;
		ApplySmallContentOffset();
	}

	public void SetSmallContentScrollRange(float range)
	{
		settings.smallContentScrollRange = Mathf.Clamp01(range);
	}

	public void SetSmallContentReturnSpeed(float speed)
	{
		settings.smallContentReturnSpeed = Mathf.Max(0.1f, speed);
	}

	public bool GetIsContentFull()
	{
		return isContentFull;
	}
}
