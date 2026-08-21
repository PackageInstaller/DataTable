using UnityEngine.InputSystem;

namespace UnityEngine.Rendering;

internal class DebugActionState
{
	private enum DebugActionKeyType
	{
		Button,
		Axis,
		Key
	}

	private DebugActionKeyType m_Type;

	private InputAction inputAction;

	private bool[] m_TriggerPressedUp;

	private float m_Timer;

	internal bool runningAction { get; private set; }

	internal float actionState { get; private set; }

	private void Trigger(int triggerCount, float state)
	{
		actionState = state;
		runningAction = true;
		m_Timer = 0f;
		m_TriggerPressedUp = new bool[triggerCount];
		for (int i = 0; i < m_TriggerPressedUp.Length; i++)
		{
			m_TriggerPressedUp[i] = false;
		}
	}

	public void TriggerWithButton(InputAction action, float state)
	{
		inputAction = action;
		Trigger(action.bindings.Count, state);
	}

	private void Reset()
	{
		runningAction = false;
		m_Timer = 0f;
		m_TriggerPressedUp = null;
	}

	public void Update(DebugActionDesc desc)
	{
		actionState = 0f;
		if (m_TriggerPressedUp == null)
		{
			return;
		}
		m_Timer += Time.deltaTime;
		for (int i = 0; i < m_TriggerPressedUp.Length; i++)
		{
			if (inputAction != null)
			{
				m_TriggerPressedUp[i] |= Mathf.Approximately(inputAction.ReadValue<float>(), 0f);
			}
		}
		bool flag = true;
		bool[] triggerPressedUp = m_TriggerPressedUp;
		foreach (bool flag2 in triggerPressedUp)
		{
			flag &= flag2;
		}
		if (flag || (m_Timer > desc.repeatDelay && desc.repeatMode == DebugActionRepeatMode.Delay))
		{
			Reset();
		}
	}
}
