using UnityEngine;

namespace P08.Gamepad;

public class ButtonMap
{
	public En_ButtonType m_buttonType;

	public En_ListenType m_listenType;

	public bool m_isAxis = true;

	public KeyCode m_keyCode;

	public float m_popThresholdValue = 0.125f;

	public float m_pushThresholdValue = 0.875f;

	public bool m_isNegative;

	private float _lastValue;

	private bool _isDown;

	private bool _onPointerDown;

	private bool _onPointerUp;

	private string _name = string.Empty;

	private int _nameHash = -1;

	public string m_name
	{
		get
		{
			return _name;
		}
		set
		{
			_name = value;
			_nameHash = _name.GetHashCode();
		}
	}

	public void UpadateStatus()
	{
		_onPointerDown = false;
		_onPointerUp = false;
		switch (m_listenType)
		{
		case En_ListenType.KeyCode:
			if (GamepadManager.GetKeyCodeDown(m_keyCode))
			{
				_onPointerDown = true;
				_isDown = true;
				_lastValue = 1f;
			}
			if (GamepadManager.GetKeyCodeUp(m_keyCode))
			{
				_onPointerUp = true;
				_isDown = false;
				_lastValue = 0f;
			}
			GamepadManager.GetKeyCodeHeld(m_keyCode);
			break;
		case En_ListenType.Axis:
		{
			float num = GamepadManager.GetAxisValue(_nameHash);
			if (m_isNegative)
			{
				if (num > 0f)
				{
					num = 0f;
				}
				num = Mathf.Abs(num);
			}
			else if (num < 0f)
			{
				num = 0f;
			}
			if (m_isAxis)
			{
				if (num > 0f && !_isDown)
				{
					OnDownPoint();
				}
				else if (num == 0f && _isDown)
				{
					OnUpPoint();
				}
			}
			else
			{
				if (_lastValue <= m_pushThresholdValue && num > m_pushThresholdValue && !_isDown)
				{
					OnDownPoint();
				}
				if (_lastValue >= m_popThresholdValue && num < m_popThresholdValue && _isDown)
				{
					OnUpPoint();
				}
			}
			_lastValue = num;
			break;
		}
		}
	}

	private void OnDownPoint()
	{
		_onPointerDown = true;
		_isDown = true;
	}

	private void OnUpPoint()
	{
		_onPointerUp = true;
		_isDown = false;
	}

	public bool GetKey()
	{
		return _isDown;
	}

	public float GetValue()
	{
		return _lastValue;
	}

	public bool GetKeyDown()
	{
		return _onPointerDown;
	}

	public bool GetKeyUp()
	{
		return _onPointerUp;
	}

	public void LostFocus()
	{
		OnUpPoint();
		_lastValue = 0f;
	}
}
