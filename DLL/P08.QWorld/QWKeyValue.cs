using P08.Gamepad;
using UnityEngine;

public class QWKeyValue
{
	private HIDInputPage m_hidInputPage;

	private En_ButtonType m_buttonType;

	private bool m_press;

	private float m_clickTime = Time.realtimeSinceStartup;

	private int m_addCnt;

	public QWKeyValue(HIDInputPage inputPage, En_ButtonType buttonType)
	{
		m_hidInputPage = inputPage;
		m_buttonType = buttonType;
	}

	public void OnEnable()
	{
		if (m_hidInputPage != null)
		{
			InputAction inputAction = InputManager.system.GetInputAction(m_hidInputPage.pageName, m_buttonType);
			if (inputAction != null && m_addCnt == 0)
			{
				m_addCnt++;
				inputAction.started += PerformedHandler;
				inputAction.performed += PerformedHandler;
				inputAction.canceled += PerformedHandler;
			}
		}
	}

	public void OnDisable()
	{
		if (m_hidInputPage != null)
		{
			InputAction inputAction = InputManager.system.GetInputAction(m_hidInputPage.pageName, m_buttonType);
			if (inputAction != null && m_addCnt == 1)
			{
				m_addCnt--;
				inputAction.started -= PerformedHandler;
				inputAction.performed -= PerformedHandler;
				inputAction.canceled -= PerformedHandler;
			}
		}
	}

	public float GetKeyValue()
	{
		if (!m_press)
		{
			return 0f;
		}
		return GamepadManager.Instance.GetKeyValue(m_buttonType);
	}

	public float GetKeyValueByAny()
	{
		return GamepadManager.Instance.GetKeyValue(m_buttonType);
	}

	public bool GetKeyDown()
	{
		if (!m_press)
		{
			return false;
		}
		float realtimeSinceStartup = Time.realtimeSinceStartup;
		if (realtimeSinceStartup - m_clickTime <= 0.01f)
		{
			return true;
		}
		if (realtimeSinceStartup - m_clickTime > 0.3f)
		{
			m_clickTime = realtimeSinceStartup;
			return true;
		}
		return false;
	}

	private void PerformedHandler(InputActionCallbackContext context)
	{
		switch (context.state.phase)
		{
		case EInputActionPhase.Started:
			m_press = true;
			m_clickTime = Time.realtimeSinceStartup;
			break;
		case EInputActionPhase.Canceled:
			m_press = false;
			break;
		case EInputActionPhase.Performed:
			break;
		}
	}
}
