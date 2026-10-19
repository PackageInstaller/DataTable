using System;
using System.Diagnostics;
using UnityEngine.InputSystem.Controls;

namespace UnityEngine.InputSystem;

[DebuggerDisplay("Value = {Get()}")]
public class InputValue
{
	internal InputAction.CallbackContext? m_Context;

	public bool isPressed => Get<float>() >= ButtonControl.s_GlobalDefaultButtonPressPoint;

	public object Get()
	{
		return m_Context.Value.ReadValueAsObject();
	}

	public TValue Get<TValue>() where TValue : struct
	{
		if (!m_Context.HasValue)
		{
			throw new InvalidOperationException("Values can only be retrieved while in message callbacks");
		}
		return m_Context.Value.ReadValue<TValue>();
	}
}
