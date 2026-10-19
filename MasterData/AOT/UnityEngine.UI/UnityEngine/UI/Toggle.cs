using System;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace UnityEngine.UI;

[AddComponentMenu("UI/Toggle", 30)]
[RequireComponent(typeof(RectTransform))]
public class Toggle : Selectable, IPointerClickHandler, IEventSystemHandler, ISubmitHandler, ICanvasElement
{
	public enum ToggleTransition
	{
		None,
		Fade
	}

	[Serializable]
	public class ToggleEvent : UnityEvent<bool>
	{
	}

	public ToggleTransition toggleTransition = ToggleTransition.Fade;

	public Graphic graphic;

	[SerializeField]
	private ToggleGroup m_Group;

	public ToggleEvent onValueChanged = new ToggleEvent();

	[Tooltip("Is the toggle currently on or off?")]
	[SerializeField]
	private bool m_IsOn;

	public ToggleGroup group
	{
		get
		{
			return m_Group;
		}
		set
		{
			SetToggleGroup(value, setMemberValue: true);
			PlayEffect(instant: true);
		}
	}

	public bool isOn
	{
		get
		{
			return m_IsOn;
		}
		set
		{
			Set(value);
		}
	}

	protected Toggle()
	{
	}

	public virtual void Rebuild(CanvasUpdate executing)
	{
	}

	public virtual void LayoutComplete()
	{
	}

	public virtual void GraphicUpdateComplete()
	{
	}

	protected override void OnDestroy()
	{
		if (m_Group != null)
		{
			m_Group.EnsureValidState();
		}
		base.OnDestroy();
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		SetToggleGroup(m_Group, setMemberValue: false);
		PlayEffect(instant: true);
	}

	protected override void OnDisable()
	{
		SetToggleGroup(null, setMemberValue: false);
		base.OnDisable();
	}

	protected override void OnDidApplyAnimationProperties()
	{
		if (graphic != null)
		{
			bool flag = !Mathf.Approximately(graphic.canvasRenderer.GetColor().a, 0f);
			if (m_IsOn != flag)
			{
				m_IsOn = flag;
				Set(!flag);
			}
		}
		base.OnDidApplyAnimationProperties();
	}

	private void SetToggleGroup(ToggleGroup newGroup, bool setMemberValue)
	{
		if (m_Group != null)
		{
			m_Group.UnregisterToggle(this);
		}
		if (setMemberValue)
		{
			m_Group = newGroup;
		}
		if (newGroup != null && IsActive())
		{
			newGroup.RegisterToggle(this);
		}
		if (newGroup != null && isOn && IsActive())
		{
			newGroup.NotifyToggleOn(this);
		}
	}

	public void SetIsOnWithoutNotify(bool value)
	{
		Set(value, sendCallback: false);
	}

	private void Set(bool value, bool sendCallback = true)
	{
		if (m_IsOn != value)
		{
			m_IsOn = value;
			if (m_Group != null && m_Group.isActiveAndEnabled && IsActive() && (m_IsOn || (!m_Group.AnyTogglesOn() && !m_Group.allowSwitchOff)))
			{
				m_IsOn = true;
				m_Group.NotifyToggleOn(this, sendCallback);
			}
			PlayEffect(toggleTransition == ToggleTransition.None);
			if (sendCallback)
			{
				UISystemProfilerApi.AddMarker("Toggle.value", this);
				onValueChanged.Invoke(m_IsOn);
			}
		}
	}

	private void PlayEffect(bool instant)
	{
		if (!(graphic == null))
		{
			graphic.CrossFadeAlpha(m_IsOn ? 1f : 0f, instant ? 0f : 0.1f, ignoreTimeScale: true);
		}
	}

	protected override void Start()
	{
		PlayEffect(instant: true);
	}

	private void InternalToggle()
	{
		if (IsActive() && IsInteractable())
		{
			isOn = !isOn;
		}
	}

	public virtual void OnPointerClick(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			InternalToggle();
		}
	}

	public virtual void OnSubmit(BaseEventData eventData)
	{
		InternalToggle();
	}
}
