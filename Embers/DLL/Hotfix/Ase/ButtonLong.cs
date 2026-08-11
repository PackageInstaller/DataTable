using System;
using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace Ase;

[AddComponentMenu("UI/ButtonLong", 31)]
public class ButtonLong : Selectable, ISubmitHandler, IEventSystemHandler
{
	[Serializable]
	public class ButtonClickedEvent : UnityEvent
	{
	}

	[Serializable]
	public class ButtonLongClickedEvent : UnityEvent
	{
	}

	[Serializable]
	public class ButtonPressedEvent : UnityEvent
	{
	}

	[Serializable]
	public class ButtonWaitUponEvent : UnityEvent
	{
	}

	[Serializable]
	public class ButtonLeaveEvent : UnityEvent
	{
	}

	[SerializeField]
	private bool clickEnabled;

	[SerializeField]
	private bool longClickEnabled;

	[SerializeField]
	private float longClickDelay = 0.2f;

	[SerializeField]
	private bool pressEnabled = true;

	[SerializeField]
	private float pressDelay = 0.4f;

	[SerializeField]
	private bool waitUponEnabled;

	[SerializeField]
	private float waitUponDelay = 1f;

	[SerializeField]
	private bool cancelByDrag = true;

	[SerializeField]
	private float dragCancelThreshold;

	private float lastIsDownTime;

	private float lastWaitUponTime;

	private bool isPointerDown;

	private bool isCanceledByDrag;

	private Vector2 pointerDownPos;

	private int pointerId;

	[FormerlySerializedAs("onClick")]
	[SerializeField]
	private ButtonClickedEvent m_OnClick = new ButtonClickedEvent();

	[FormerlySerializedAs("onLongClick")]
	[SerializeField]
	private ButtonLongClickedEvent m_OnLongClick = new ButtonLongClickedEvent();

	[FormerlySerializedAs("onPress")]
	[SerializeField]
	private ButtonPressedEvent m_OnPress = new ButtonPressedEvent();

	[FormerlySerializedAs("onPointDown")]
	[SerializeField]
	private UnityEvent m_OnPointDown = new UnityEvent();

	[FormerlySerializedAs("onPointUp")]
	[SerializeField]
	private UnityEvent m_OnPointUp = new UnityEvent();

	[FormerlySerializedAs("onWaitUpon")]
	[SerializeField]
	private UnityEvent m_OnWaitUpon = new UnityEvent();

	[FormerlySerializedAs("onLeave")]
	[SerializeField]
	private UnityEvent m_OnLeave = new UnityEvent();

	public bool ClickEnabled => clickEnabled;

	public bool LongClickEnabled => longClickEnabled;

	public bool PressEnabled => pressEnabled;

	public ButtonClickedEvent onClick
	{
		get
		{
			return m_OnClick;
		}
		set
		{
			m_OnClick = value;
		}
	}

	public ButtonLongClickedEvent onLongClick
	{
		get
		{
			return m_OnLongClick;
		}
		set
		{
			m_OnLongClick = value;
		}
	}

	public ButtonPressedEvent onPress
	{
		get
		{
			return m_OnPress;
		}
		set
		{
			m_OnPress = value;
		}
	}

	public UnityEvent onPointUDown
	{
		get
		{
			return m_OnPointDown;
		}
		set
		{
			m_OnPointDown = value;
		}
	}

	public UnityEvent onPointUp
	{
		get
		{
			return m_OnPointUp;
		}
		set
		{
			m_OnPointUp = value;
		}
	}

	public UnityEvent onWaitUpon
	{
		get
		{
			return m_OnWaitUpon;
		}
		set
		{
			m_OnWaitUpon = value;
		}
	}

	public UnityEvent onLeave
	{
		get
		{
			return m_OnLeave;
		}
		set
		{
			m_OnLeave = value;
		}
	}

	protected ButtonLong()
	{
	}

	private void Update()
	{
		if (cancelByDrag && isPointerDown && !isCanceledByDrag)
		{
			float num = ((dragCancelThreshold > 0f) ? dragCancelThreshold : ((EventSystem.current != null) ? ((float)EventSystem.current.pixelDragThreshold) : 10f));
			if (TryGetPointerPosition(pointerId, out var position) && (position - pointerDownPos).sqrMagnitude > num * num)
			{
				isCanceledByDrag = true;
			}
		}
		if (!isCanceledByDrag)
		{
			if (pressEnabled && IsPressed() && Time.time - lastIsDownTime > pressDelay)
			{
				Press(ButtonOperateType.Press);
			}
			if (waitUponEnabled && IsUpon() && Time.time - lastWaitUponTime > waitUponDelay)
			{
				WaitUpon(ButtonOperateType.WaitUpon);
			}
		}
	}

	private void Press(ButtonOperateType operateType)
	{
		if (IsActive() && IsInteractable())
		{
			if (operateType == ButtonOperateType.Click && clickEnabled)
			{
				UISystemProfilerApi.AddMarker("Button.onClick", (UnityEngine.Object)this);
				m_OnClick.Invoke();
			}
			else if (operateType == ButtonOperateType.LongClick && longClickEnabled)
			{
				UISystemProfilerApi.AddMarker("Button.onLongClick", (UnityEngine.Object)this);
				m_OnLongClick.Invoke();
			}
			else if (operateType == ButtonOperateType.Press && pressEnabled)
			{
				UISystemProfilerApi.AddMarker("Button.onPress", (UnityEngine.Object)this);
				m_OnPress.Invoke();
			}
		}
	}

	private void WaitUpon(ButtonOperateType operateType)
	{
		if (IsActive() && IsInteractable() && operateType == ButtonOperateType.WaitUpon && waitUponEnabled)
		{
			UISystemProfilerApi.AddMarker("Button.onWaitUpon", (UnityEngine.Object)this);
			m_OnWaitUpon.Invoke();
		}
	}

	private void Leave(ButtonOperateType operateType)
	{
		if (IsActive() && IsInteractable() && operateType == ButtonOperateType.Leave && waitUponEnabled)
		{
			UISystemProfilerApi.AddMarker("Button.onLeave", (UnityEngine.Object)this);
			m_OnLeave.Invoke();
		}
	}

	public override void OnPointerDown(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			base.OnPointerDown(eventData);
			UISystemProfilerApi.AddMarker("Button.onPointUDown", (UnityEngine.Object)this);
			m_OnPointDown.Invoke();
			lastIsDownTime = Time.time;
			isPointerDown = true;
			isCanceledByDrag = false;
			pointerDownPos = eventData.position;
			pointerId = eventData.pointerId;
		}
	}

	public override void OnPointerUp(PointerEventData eventData)
	{
		if (eventData.button != PointerEventData.InputButton.Left)
		{
			return;
		}
		bool num = IsPressed();
		base.OnPointerUp(eventData);
		if (eventData.dragging)
		{
			isCanceledByDrag = true;
		}
		if (num && !isCanceledByDrag && eventData.eligibleForClick && !eventData.dragging)
		{
			if (Time.time - lastIsDownTime > longClickDelay)
			{
				Press(ButtonOperateType.LongClick);
			}
			else
			{
				Press(ButtonOperateType.Click);
			}
		}
		UISystemProfilerApi.AddMarker("Button.onPointUp", (UnityEngine.Object)this);
		m_OnPointUp.Invoke();
		isPointerDown = false;
		isCanceledByDrag = false;
	}

	private static bool TryGetPointerPosition(int pointerId, out Vector2 position)
	{
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		if (pointerId < 0)
		{
			position = Input.mousePosition;
			return true;
		}
		if (Input.touchCount > 0)
		{
			for (int i = 0; i < Input.touchCount; i++)
			{
				Touch touch = Input.GetTouch(i);
				if (((Touch)(ref touch)).fingerId == pointerId)
				{
					position = ((Touch)(ref touch)).position;
					return true;
				}
			}
		}
		position = default(Vector2);
		return false;
	}

	public override void OnPointerEnter(PointerEventData eventData)
	{
		base.OnPointerEnter(eventData);
		lastWaitUponTime = Time.time;
	}

	public override void OnPointerExit(PointerEventData eventData)
	{
		base.OnPointerExit(eventData);
		if (Time.time - lastWaitUponTime > waitUponDelay)
		{
			Leave(ButtonOperateType.Leave);
		}
		lastWaitUponTime = 0f;
	}

	protected bool IsUpon()
	{
		if (!IsActive() || !IsInteractable())
		{
			return false;
		}
		return lastWaitUponTime != 0f;
	}

	public virtual void OnSubmit(BaseEventData eventData)
	{
		Press(ButtonOperateType.Click);
		if (IsActive() && IsInteractable())
		{
			DoStateTransition(SelectionState.Pressed, instant: false);
			StartCoroutine(OnFinishSubmit());
		}
	}

	private IEnumerator OnFinishSubmit()
	{
		float fadeTime = base.colors.fadeDuration;
		float elapsedTime = 0f;
		while (elapsedTime < fadeTime)
		{
			elapsedTime += Time.unscaledDeltaTime;
			yield return null;
		}
		DoStateTransition(base.currentSelectionState, instant: false);
	}
}
