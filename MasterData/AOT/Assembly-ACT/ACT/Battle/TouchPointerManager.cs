using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.Controls;

namespace ACT.Battle;

public sealed class TouchPointerManager
{
	private enum PointerSourceType
	{
		Touch,
		Pointer
	}

	private struct PointerSource
	{
		public PointerSourceType Type;

		public int TouchId;
	}

	private const float TouchPositionMatchMaxSqrDistance = 16f;

	private readonly Dictionary<int, PointerSource> _pointerIdToSource = new Dictionary<int, PointerSource>(4);

	public bool TryRegisterPointer(PointerEventData eventData, out int pointerId)
	{
		pointerId = eventData.pointerId;
		if (_pointerIdToSource.ContainsKey(pointerId))
		{
			return true;
		}
		if (!TryFindTouchSource(eventData, out var source) && !TryFindPointerSource(eventData, out source))
		{
			return false;
		}
		_pointerIdToSource[pointerId] = source;
		return true;
	}

	public bool TryGetPointerPosition(int pointerId, out Vector2 position)
	{
		position = default;
		if (!_pointerIdToSource.TryGetValue(pointerId, out var value))
		{
			return false;
		}
		switch (value.Type)
		{
		case PointerSourceType.Touch:
			if (TryGetTouchPosition(value.TouchId, out position))
			{
				return true;
			}
			break;
		case PointerSourceType.Pointer:
			if (TryGetCurrentPointerPosition(out position))
			{
				return true;
			}
			break;
		}
		_pointerIdToSource.Remove(pointerId);
		return false;
	}

	public void UnregisterPointer(int pointerId)
	{
		_pointerIdToSource.Remove(pointerId);
	}

	public void Clear()
	{
		_pointerIdToSource.Clear();
	}

	private static bool TryGetTouchPosition(int touchId, out Vector2 position)
	{
		position = default;
		Touchscreen current = Touchscreen.current;
		if (current == null)
		{
			return false;
		}
		foreach (TouchControl touch in current.touches)
		{
			if (touch.isInProgress && touch.touchId.ReadValue() == touchId)
			{
				position = touch.position.ReadValue();
				return true;
			}
		}
		return false;
	}

	private static bool TryGetCurrentPointerPosition(out Vector2 position)
	{
		position = default;
		Pointer current = Pointer.current;
		if (current == null || !PointerIsPressed(current))
		{
			return false;
		}
		position = current.position.ReadValue();
		return true;
	}

	private bool TryFindTouchSource(PointerEventData eventData, out PointerSource source)
	{
		source = default;
		Touchscreen current = Touchscreen.current;
		if (current == null)
		{
			return false;
		}
		Vector2 position = eventData.position;
		float num = 16f;
		bool result = false;
		foreach (TouchControl touch in current.touches)
		{
			if (!touch.isInProgress)
			{
				continue;
			}
			int num2 = touch.touchId.ReadValue();
			if (!IsTouchRegistered(num2))
			{
				if (num2 == eventData.pointerId)
				{
					source = CreateTouchSource(num2);
					return true;
				}
				float sqrMagnitude = (touch.position.ReadValue() - position).sqrMagnitude;
				if (!(sqrMagnitude > num))
				{
					num = sqrMagnitude;
					source = CreateTouchSource(num2);
					result = true;
				}
			}
		}
		return result;
	}

	private bool TryFindPointerSource(PointerEventData eventData, out PointerSource source)
	{
		source = default;
		if (IsPointerSourceRegistered())
		{
			return false;
		}
		Pointer current = Pointer.current;
		if (current == null || !PointerIsPressed(current))
		{
			return false;
		}
		if ((current.position.ReadValue() - eventData.position).sqrMagnitude > 16f)
		{
			return false;
		}
		source = new PointerSource
		{
			Type = PointerSourceType.Pointer,
			TouchId = -1
		};
		return true;
	}

	private static PointerSource CreateTouchSource(int touchId)
	{
		return new PointerSource
		{
			Type = PointerSourceType.Touch,
			TouchId = touchId
		};
	}

	private static bool PointerIsPressed(Pointer pointer)
	{
		if (!pointer.press.isPressed)
		{
			return pointer.IsPressed();
		}
		return true;
	}

	private bool IsTouchRegistered(int touchId)
	{
		foreach (PointerSource value in _pointerIdToSource.Values)
		{
			if (value.Type == PointerSourceType.Touch && value.TouchId == touchId)
			{
				return true;
			}
		}
		return false;
	}

	private bool IsPointerSourceRegistered()
	{
		foreach (PointerSource value in _pointerIdToSource.Values)
		{
			if (value.Type == PointerSourceType.Pointer)
			{
				return true;
			}
		}
		return false;
	}
}
