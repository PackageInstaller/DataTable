using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.Battle;

public class PinchZoomFov : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler
{
	private int _finger0PointerId = -1;

	private int _finger1PointerId = -1;

	private float _lastTouchDistance;

	private void OnEnable()
	{
		gameObject.tag = "IgnoreOnUIHitCheck";
	}

	private void OnDisable()
	{
		ClearFingers();
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		int pointerId = eventData.pointerId;
		if (pointerId != _finger0PointerId && pointerId != _finger1PointerId && (_finger0PointerId < 0 || _finger1PointerId < 0) && Singleton<GameInputActionManager>.instance.TouchPointer.TryRegisterPointer(eventData, out pointerId))
		{
			if (_finger0PointerId < 0)
			{
				_finger0PointerId = pointerId;
			}
			else
			{
				_finger1PointerId = pointerId;
			}
			ResetPinchState();
		}
	}

	private void Update()
	{
		if (_finger0PointerId >= 0 && _finger1PointerId >= 0)
		{
			if (!Singleton<GameInputActionManager>.instance.TouchPointer.TryGetPointerPosition(_finger0PointerId, out var position) || !Singleton<GameInputActionManager>.instance.TouchPointer.TryGetPointerPosition(_finger1PointerId, out var position2))
			{
				ClearFingers();
			}
			else
			{
				HandlePinchZoom(position, position2);
			}
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		int pointerId = eventData.pointerId;
		if (pointerId == _finger0PointerId || pointerId == _finger1PointerId)
		{
			ClearFingers();
		}
	}

	private void HandlePinchZoom(Vector2 finger0Pos, Vector2 finger1Pos)
	{
		float num = Vector2.Distance(finger0Pos, finger1Pos);
		if (_lastTouchDistance > 0f)
		{
			float num2 = num - _lastTouchDistance;
			if (!Mathf.Approximately(num2, 0f))
			{
				CinemachineDynamicFOVBrain.Instance?.OnZoomFov(num2);
			}
		}
		_lastTouchDistance = num;
	}

	private void ResetPinchState()
	{
		_lastTouchDistance = 0f;
	}

	private void ClearFingers()
	{
		if (_finger0PointerId >= 0)
		{
			Singleton<GameInputActionManager>.instance.TouchPointer.UnregisterPointer(_finger0PointerId);
		}
		if (_finger1PointerId >= 0)
		{
			Singleton<GameInputActionManager>.instance.TouchPointer.UnregisterPointer(_finger1PointerId);
		}
		_finger0PointerId = -1;
		_finger1PointerId = -1;
		ResetPinchState();
	}
}
