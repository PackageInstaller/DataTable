using UnityEngine;

namespace Ase;

public class BoardHeroSpineLongPressDrag : MonoBehaviour
{
	[SerializeField]
	private float dragBeginTime = 0.5f;

	[SerializeField]
	private RectTransform dragAreaRect;

	[SerializeField]
	private RectTransform targetRect;

	[SerializeField]
	private PosterGirlAdjustView _owner;

	[SerializeField]
	private Canvas _canvas;

	private bool _pressing;

	private bool _dragging;

	private float _pressStartTime;

	private int _touchId = -1;

	private RectTransform _parentRect;

	private Camera _eventCam;

	private Vector2 _pressLocalInParent;

	private Vector2 _startAnchoredPos;

	private bool _longPressDetectEnabled;

	public void SetLongPressDetectEnabled(bool enabled)
	{
		_longPressDetectEnabled = enabled;
	}

	private void OnDisable()
	{
		if (_dragging && _owner != null)
		{
			_owner?.SetSpineAnimPaused(paused: false);
			_owner.SetInputLocked(locked: false);
			if (targetRect != null)
			{
				_owner.OnSpineAnchoredPosChanged(targetRect.anchoredPosition);
			}
		}
		_pressing = false;
		_dragging = false;
		_touchId = -1;
	}

	private void Update()
	{
		if (!(_owner == null))
		{
			if (Input.touchCount > 0)
			{
				UpdateTouch();
			}
			else
			{
				UpdateMouse();
			}
		}
	}

	private void UpdateMouse()
	{
		if (Input.GetMouseButtonDown(0))
		{
			TryBeginPress(-999, Input.mousePosition);
		}
		else if (_pressing)
		{
			if (Input.GetMouseButton(0))
			{
				TickHoldOrDrag(Input.mousePosition);
			}
			else if (Input.GetMouseButtonUp(0))
			{
				EndPress(_dragging);
			}
		}
	}

	private void UpdateTouch()
	{
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0060: Invalid comparison between Unknown and I4
		//IL_0064: Unknown result type (might be due to invalid IL or missing references)
		//IL_006a: Invalid comparison between Unknown and I4
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0082: Invalid comparison between Unknown and I4
		//IL_0086: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Invalid comparison between Unknown and I4
		if (!_pressing)
		{
			for (int i = 0; i < Input.touchCount; i++)
			{
				Touch touch = Input.GetTouch(i);
				if ((int)((Touch)(ref touch)).phase == 0)
				{
					TryBeginPress(((Touch)(ref touch)).fingerId, ((Touch)(ref touch)).position);
					break;
				}
			}
			return;
		}
		for (int j = 0; j < Input.touchCount; j++)
		{
			Touch touch2 = Input.GetTouch(j);
			if (((Touch)(ref touch2)).fingerId == _touchId)
			{
				if ((int)((Touch)(ref touch2)).phase == 1 || (int)((Touch)(ref touch2)).phase == 2)
				{
					TickHoldOrDrag(((Touch)(ref touch2)).position);
				}
				else if ((int)((Touch)(ref touch2)).phase == 3 || (int)((Touch)(ref touch2)).phase == 4)
				{
					EndPress(_dragging);
				}
				break;
			}
		}
	}

	private void TryBeginPress(int pointerId, Vector2 screenPos)
	{
		ResolveRefs();
		if (!(targetRect == null) && RectTransformUtility.RectangleContainsScreenPoint((dragAreaRect != null) ? dragAreaRect : targetRect, screenPos, _eventCam))
		{
			_pressing = true;
			_dragging = false;
			_touchId = pointerId;
			_pressStartTime = Time.unscaledTime;
			_parentRect = targetRect.parent as RectTransform;
			if (_parentRect == null)
			{
				_pressing = false;
				return;
			}
			_startAnchoredPos = targetRect.anchoredPosition;
			RectTransformUtility.ScreenPointToLocalPointInRectangle(_parentRect, screenPos, _eventCam, ref _pressLocalInParent);
		}
	}

	private void TickHoldOrDrag(Vector2 screenPos)
	{
		if (!_pressing || !_longPressDetectEnabled)
		{
			return;
		}
		if (!_dragging)
		{
			if (Time.unscaledTime - _pressStartTime < dragBeginTime)
			{
				return;
			}
			_dragging = true;
			_owner?.SetSpineAnimPaused(paused: true);
			_owner.SetInputLocked(locked: true);
		}
		if (!(targetRect == null) && !(_parentRect == null))
		{
			Vector2 vector = default(Vector2);
			RectTransformUtility.ScreenPointToLocalPointInRectangle(_parentRect, screenPos, _eventCam, ref vector);
			Vector2 vector2 = vector - _pressLocalInParent;
			targetRect.anchoredPosition = _startAnchoredPos + vector2;
		}
	}

	private void EndPress(bool save)
	{
		_pressing = false;
		if (_dragging)
		{
			_dragging = false;
			_owner?.SetSpineAnimPaused(paused: false);
			_owner.SetInputLocked(locked: false);
			if (targetRect != null)
			{
				_owner.OnSpineAnchoredPosChanged(targetRect.anchoredPosition);
			}
		}
		_touchId = -1;
	}

	private void ResolveRefs()
	{
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		if (targetRect == null)
		{
			targetRect = _owner.GetSpineRootForAdjust();
		}
		_eventCam = null;
		Canvas componentInParent = GetComponentInParent<Canvas>();
		if ((Object)(object)componentInParent != null && (int)componentInParent.renderMode != 0)
		{
			_eventCam = componentInParent.worldCamera;
		}
	}
}
