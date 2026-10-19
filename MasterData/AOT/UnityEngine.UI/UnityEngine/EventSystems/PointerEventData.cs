using System;
using System.Collections.Generic;
using System.Text;

namespace UnityEngine.EventSystems;

public class PointerEventData : BaseEventData
{
	public enum InputButton
	{
		Left,
		Right,
		Middle
	}

	public enum FramePressState
	{
		Pressed,
		Released,
		PressedAndReleased,
		NotChanged
	}

	private GameObject m_PointerPress;

	public List<GameObject> hovered = new List<GameObject>();

	public GameObject pointerEnter { get; set; }

	public GameObject lastPress { get; private set; }

	public GameObject rawPointerPress { get; set; }

	public GameObject pointerDrag { get; set; }

	public GameObject pointerClick { get; set; }

	public RaycastResult pointerCurrentRaycast { get; set; }

	public RaycastResult pointerPressRaycast { get; set; }

	public bool eligibleForClick { get; set; }

	public int displayIndex { get; set; }

	public int pointerId { get; set; }

	public Vector2 position { get; set; }

	public Vector2 delta { get; set; }

	public Vector2 pressPosition { get; set; }

	[Obsolete("Use either pointerCurrentRaycast.worldPosition or pointerPressRaycast.worldPosition")]
	public Vector3 worldPosition { get; set; }

	[Obsolete("Use either pointerCurrentRaycast.worldNormal or pointerPressRaycast.worldNormal")]
	public Vector3 worldNormal { get; set; }

	public float clickTime { get; set; }

	public int clickCount { get; set; }

	public Vector2 scrollDelta { get; set; }

	public bool useDragThreshold { get; set; }

	public bool dragging { get; set; }

	public InputButton button { get; set; }

	public float pressure { get; set; }

	public float tangentialPressure { get; set; }

	public float altitudeAngle { get; set; }

	public float azimuthAngle { get; set; }

	public float twist { get; set; }

	public Vector2 tilt { get; set; }

	public PenStatus penStatus { get; set; }

	public Vector2 radius { get; set; }

	public Vector2 radiusVariance { get; set; }

	public bool fullyExited { get; set; }

	public bool reentered { get; set; }

	public Camera enterEventCamera
	{
		get
		{
			if (!(pointerCurrentRaycast.module == null))
			{
				return pointerCurrentRaycast.module.eventCamera;
			}
			return null;
		}
	}

	public Camera pressEventCamera
	{
		get
		{
			if (!(pointerPressRaycast.module == null))
			{
				return pointerPressRaycast.module.eventCamera;
			}
			return null;
		}
	}

	public GameObject pointerPress
	{
		get
		{
			return m_PointerPress;
		}
		set
		{
			if (!(m_PointerPress == value))
			{
				lastPress = m_PointerPress;
				m_PointerPress = value;
			}
		}
	}

	public PointerEventData(EventSystem eventSystem)
		: base(eventSystem)
	{
		eligibleForClick = false;
		displayIndex = 0;
		pointerId = -1;
		position = Vector2.zero;
		delta = Vector2.zero;
		pressPosition = Vector2.zero;
		clickTime = 0f;
		clickCount = 0;
		scrollDelta = Vector2.zero;
		useDragThreshold = true;
		dragging = false;
		button = InputButton.Left;
		pressure = 0f;
		tangentialPressure = 0f;
		altitudeAngle = 0f;
		azimuthAngle = 0f;
		twist = 0f;
		tilt = new Vector2(0f, 0f);
		penStatus = PenStatus.None;
		radius = Vector2.zero;
		radiusVariance = Vector2.zero;
	}

	public bool IsPointerMoving()
	{
		return delta.sqrMagnitude > 0f;
	}

	public bool IsScrolling()
	{
		return scrollDelta.sqrMagnitude > 0f;
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendLine("<b>Position</b>: " + position.ToString());
		stringBuilder.AppendLine("<b>delta</b>: " + delta.ToString());
		stringBuilder.AppendLine("<b>eligibleForClick</b>: " + eligibleForClick);
		stringBuilder.AppendLine("<b>pointerEnter</b>: " + pointerEnter);
		stringBuilder.AppendLine("<b>pointerPress</b>: " + pointerPress);
		stringBuilder.AppendLine("<b>lastPointerPress</b>: " + lastPress);
		stringBuilder.AppendLine("<b>pointerDrag</b>: " + pointerDrag);
		stringBuilder.AppendLine("<b>Use Drag Threshold</b>: " + useDragThreshold);
		stringBuilder.AppendLine("<b>Current Raycast:</b>");
		stringBuilder.AppendLine(pointerCurrentRaycast.ToString());
		stringBuilder.AppendLine("<b>Press Raycast:</b>");
		stringBuilder.AppendLine(pointerPressRaycast.ToString());
		stringBuilder.AppendLine("<b>Display Index:</b>");
		stringBuilder.AppendLine(displayIndex.ToString());
		stringBuilder.AppendLine("<b>pressure</b>: " + pressure);
		stringBuilder.AppendLine("<b>tangentialPressure</b>: " + tangentialPressure);
		stringBuilder.AppendLine("<b>altitudeAngle</b>: " + altitudeAngle);
		stringBuilder.AppendLine("<b>azimuthAngle</b>: " + azimuthAngle);
		stringBuilder.AppendLine("<b>twist</b>: " + twist);
		stringBuilder.AppendLine("<b>tilt</b>: " + tilt.ToString());
		stringBuilder.AppendLine("<b>penStatus</b>: " + penStatus);
		stringBuilder.AppendLine("<b>radius</b>: " + radius.ToString());
		stringBuilder.AppendLine("<b>radiusVariance</b>: " + radiusVariance.ToString());
		return stringBuilder.ToString();
	}
}
