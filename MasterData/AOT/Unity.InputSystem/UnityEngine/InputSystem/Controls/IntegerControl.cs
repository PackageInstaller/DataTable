using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Controls;

public class IntegerControl : InputControl<int>
{
	public IntegerControl()
	{
		m_StateBlock.format = InputStateBlock.FormatInt;
	}

	public unsafe override int ReadUnprocessedValueFromState(void* statePtr)
	{
		if ((int)m_OptimizedControlDataType == 1229870112)
		{
			return *(int*)((byte*)statePtr + (int)m_StateBlock.byteOffset);
		}
		return m_StateBlock.ReadInt(statePtr);
	}

	public unsafe override void WriteValueIntoState(int value, void* statePtr)
	{
		if ((int)m_OptimizedControlDataType == 1229870112)
		{
			*(int*)((byte*)statePtr + (int)m_StateBlock.byteOffset) = value;
		}
		else
		{
			m_StateBlock.WriteInt(statePtr, value);
		}
	}

	protected override FourCC CalculateOptimizedControlDataType()
	{
		if (m_StateBlock.format == InputStateBlock.FormatInt && m_StateBlock.sizeInBits == 32 && m_StateBlock.bitOffset == 0)
		{
			return InputStateBlock.FormatInt;
		}
		return InputStateBlock.FormatInvalid;
	}
}
