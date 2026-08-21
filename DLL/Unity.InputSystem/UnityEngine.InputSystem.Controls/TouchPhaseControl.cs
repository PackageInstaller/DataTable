using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;

namespace UnityEngine.InputSystem.Controls;

[InputControlLayout(hideInUI = true)]
public class TouchPhaseControl : InputControl<TouchPhase>
{
	public TouchPhaseControl()
	{
		m_StateBlock.format = InputStateBlock.FormatInt;
	}

	public unsafe override TouchPhase ReadUnprocessedValueFromState(void* statePtr)
	{
		return (TouchPhase)base.stateBlock.ReadInt(statePtr);
	}

	public unsafe override void WriteValueIntoState(TouchPhase value, void* statePtr)
	{
		*(TouchPhase*)((byte*)statePtr + (int)m_StateBlock.byteOffset) = value;
	}
}
