using System;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Controls;

public class DiscreteButtonControl : ButtonControl
{
	public enum WriteMode
	{
		WriteDisabled,
		WriteNullAndMaxValue
	}

	public int minValue;

	public int maxValue;

	public int wrapAtValue;

	public int nullValue;

	public WriteMode writeMode;

	protected override void FinishSetup()
	{
		base.FinishSetup();
		if (!base.stateBlock.format.IsIntegerFormat())
		{
			throw new NotSupportedException($"Non-integer format '{base.stateBlock.format}' is not supported for DiscreteButtonControl '{this}'");
		}
	}

	public unsafe override float ReadUnprocessedValueFromState(void* statePtr)
	{
		int num = MemoryHelpers.ReadTwosComplementMultipleBitsAsInt((byte*)statePtr + (int)m_StateBlock.byteOffset, m_StateBlock.bitOffset, m_StateBlock.sizeInBits);
		float num2 = 0f;
		if (minValue > maxValue)
		{
			if (wrapAtValue == nullValue)
			{
				wrapAtValue = minValue;
			}
			if ((num >= minValue && num <= wrapAtValue) || (num != nullValue && num <= maxValue))
			{
				num2 = 1f;
			}
		}
		else
		{
			num2 = ((num >= minValue && num <= maxValue) ? 1f : 0f);
		}
		return Preprocess(num2);
	}

	public unsafe override void WriteValueIntoState(float value, void* statePtr)
	{
		if (writeMode == WriteMode.WriteNullAndMaxValue)
		{
			MemoryHelpers.WriteIntAsTwosComplementMultipleBits((byte*)statePtr + (int)m_StateBlock.byteOffset, value: (value >= base.pressPointOrDefault) ? maxValue : nullValue, bitOffset: m_StateBlock.bitOffset, bitCount: m_StateBlock.sizeInBits);
			return;
		}
		throw new NotSupportedException("Writing value states for DiscreteButtonControl is not supported as a single value may correspond to multiple states");
	}
}
