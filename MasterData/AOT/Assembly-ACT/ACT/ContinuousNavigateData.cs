using System;
using ACT.Battle;
using ACT.ViewControl;
using Bamboo.Chronos;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT;

public class ContinuousNavigateData
{
	public MoveDirection lastDirection;

	public float holdStartTime;

	public float lastTriggerTime;

	public bool enteredRepeat;

	public Looper repeatLooper;

	public Vector2 currentInput;

	private DeviceInputMode m_InputMode;

	private ViewControlLayer m_FocusLayer;

	private bool m_TrackFocusLayer;

	private Action<MoveDirection> m_OnTriggerNav;

	internal void BeginContinuousNavigate(Action<MoveDirection> onTriggerNav, DeviceInputMode inputMode, ViewControlLayer focusLayer)
	{
		m_OnTriggerNav = onTriggerNav;
		m_InputMode = inputMode;
		m_FocusLayer = focusLayer;
		m_TrackFocusLayer = focusLayer != null && focusLayer.IsFocused;
	}

	internal bool IsContextValid()
	{
		if (m_TrackFocusLayer && (m_FocusLayer == null || !m_FocusLayer.IsFocused))
		{
			return false;
		}
		MonoECS instance = MonoECS.instance;
		if (!(instance == null))
		{
			return instance.InputMode == m_InputMode;
		}
		return true;
	}

	internal void InvokeTrigger(MoveDirection direction)
	{
		m_OnTriggerNav?.Invoke(direction);
	}

	public void Reset()
	{
		lastDirection = MoveDirection.None;
		holdStartTime = 0f;
		lastTriggerTime = 0f;
		enteredRepeat = false;
		currentInput = Vector2.zero;
		m_InputMode = DeviceInputMode.Unknown;
		m_FocusLayer = null;
		m_TrackFocusLayer = false;
		m_OnTriggerNav = null;
		if (repeatLooper.IsValid())
		{
			repeatLooper.Cancel();
		}
		repeatLooper = default;
	}
}
