using System;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Controls;

[InputControlLayout(hideInUI = true)]
public class TouchPressControl : ButtonControl
{
	protected override void FinishSetup()
	{
		base.FinishSetup();
		if (!base.stateBlock.format.IsIntegerFormat())
		{
			throw new NotSupportedException($"Non-integer format '{base.stateBlock.format}' is not supported for TouchButtonControl '{this}'");
		}
	}

	public unsafe override float ReadUnprocessedValueFromState(void* statePtr)
	{
		TouchPhase touchPhase = (TouchPhase)MemoryHelpers.ReadMultipleBitsAsUInt((byte*)statePtr + (int)m_StateBlock.byteOffset, m_StateBlock.bitOffset, m_StateBlock.sizeInBits);
		float num = 0f;
		if (touchPhase == TouchPhase.Began || touchPhase == TouchPhase.Stationary || touchPhase == TouchPhase.Moved)
		{
			num = 1f;
		}
		return Preprocess(num);
	}

	public unsafe override void WriteValueIntoState(float value, void* statePtr)
	{
		throw new NotSupportedException();
	}
}
