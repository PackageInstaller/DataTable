using UnityEngine.InputSystem.LowLevel;

namespace UnityEngine.InputSystem.Controls;

public class DoubleControl : InputControl<double>
{
	public DoubleControl()
	{
		m_StateBlock.format = InputStateBlock.FormatDouble;
	}

	public unsafe override double ReadUnprocessedValueFromState(void* statePtr)
	{
		return m_StateBlock.ReadDouble(statePtr);
	}

	public unsafe override void WriteValueIntoState(double value, void* statePtr)
	{
		m_StateBlock.WriteDouble(statePtr, value);
	}
}
