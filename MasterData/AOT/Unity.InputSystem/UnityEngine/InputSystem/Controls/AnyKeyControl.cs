using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;

namespace UnityEngine.InputSystem.Controls;

[InputControlLayout(hideInUI = true)]
public class AnyKeyControl : ButtonControl
{
	public AnyKeyControl()
	{
		m_StateBlock.sizeInBits = 1u;
		m_StateBlock.format = InputStateBlock.FormatBit;
	}

	public unsafe override float ReadUnprocessedValueFromState(void* statePtr)
	{
		if (!this.CheckStateIsAtDefault(statePtr, null))
		{
			return 1f;
		}
		return 0f;
	}
}
