using System.Runtime.CompilerServices;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Processors;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Controls;

public class AxisControl : InputControl<float>
{
	public enum Clamp
	{
		None,
		BeforeNormalize,
		AfterNormalize,
		ToConstantBeforeNormalize
	}

	public Clamp clamp;

	public float clampMin;

	public float clampMax;

	public float clampConstant;

	public bool invert;

	public bool normalize;

	public float normalizeMin;

	public float normalizeMax;

	public float normalizeZero;

	public bool scale;

	public float scaleFactor;

	[MethodImpl((MethodImplOptions)256)]
	protected float Preprocess(float value)
	{
		if (scale)
		{
			value *= scaleFactor;
		}
		if (clamp == Clamp.ToConstantBeforeNormalize)
		{
			if (value < clampMin || value > clampMax)
			{
				value = clampConstant;
			}
		}
		else if (clamp == Clamp.BeforeNormalize)
		{
			value = Mathf.Clamp(value, clampMin, clampMax);
		}
		if (normalize)
		{
			value = NormalizeProcessor.Normalize(value, normalizeMin, normalizeMax, normalizeZero);
		}
		if (clamp == Clamp.AfterNormalize)
		{
			value = Mathf.Clamp(value, clampMin, clampMax);
		}
		if (invert)
		{
			value *= -1f;
		}
		return value;
	}

	private float Unpreprocess(float value)
	{
		if (invert)
		{
			value *= -1f;
		}
		if (normalize)
		{
			value = NormalizeProcessor.Denormalize(value, normalizeMin, normalizeMax, normalizeZero);
		}
		if (scale)
		{
			value /= scaleFactor;
		}
		return value;
	}

	public AxisControl()
	{
		m_StateBlock.format = InputStateBlock.FormatFloat;
	}

	protected override void FinishSetup()
	{
		base.FinishSetup();
		if (!base.hasDefaultState && normalize && Mathf.Abs(normalizeZero) > Mathf.Epsilon)
		{
			m_DefaultState = base.stateBlock.FloatToPrimitiveValue(normalizeZero);
		}
	}

	public unsafe override float ReadUnprocessedValueFromState(void* statePtr)
	{
		switch (m_OptimizedControlDataType)
		{
		case 1179407392:
			return *(float*)((byte*)statePtr + m_StateBlock.m_ByteOffset);
		case 1113150533:
			if (((byte*)statePtr)[m_StateBlock.m_ByteOffset] == 0)
			{
				return 0f;
			}
			return 1f;
		default:
		{
			float num = base.stateBlock.ReadFloat(statePtr);
			return Preprocess(num);
		}
		}
	}

	public unsafe override void WriteValueIntoState(float value, void* statePtr)
	{
		switch (m_OptimizedControlDataType)
		{
		case 1179407392:
			*(float*)((byte*)statePtr + m_StateBlock.m_ByteOffset) = value;
			break;
		case 1113150533:
			((sbyte*)statePtr)[m_StateBlock.m_ByteOffset] = ((value >= 0.5f) ? ((sbyte)1) : ((sbyte)0));
			break;
		default:
			value = Unpreprocess(value);
			base.stateBlock.WriteFloat(statePtr, value);
			break;
		}
	}

	public unsafe override bool CompareValue(void* firstStatePtr, void* secondStatePtr)
	{
		float a = ReadValueFromState(firstStatePtr);
		float b = ReadValueFromState(secondStatePtr);
		return !Mathf.Approximately(a, b);
	}

	public unsafe override float EvaluateMagnitude(void* statePtr)
	{
		return EvaluateMagnitude(ReadValueFromStateWithCaching(statePtr));
	}

	private float EvaluateMagnitude(float value)
	{
		if (m_MinValue.isEmpty || m_MaxValue.isEmpty)
		{
			return Mathf.Abs(value);
		}
		float num = m_MinValue.ToSingle();
		float max = m_MaxValue.ToSingle();
		float num2 = Mathf.Clamp(value, num, max);
		if (num < 0f)
		{
			if (num2 < 0f)
			{
				return NormalizeProcessor.Normalize(Mathf.Abs(num2), 0f, Mathf.Abs(num), 0f);
			}
			return NormalizeProcessor.Normalize(num2, 0f, max, 0f);
		}
		return NormalizeProcessor.Normalize(num2, num, max, 0f);
	}

	protected override FourCC CalculateOptimizedControlDataType()
	{
		bool flag = clamp == Clamp.None && !invert && !normalize && !scale;
		if (flag && m_StateBlock.format == InputStateBlock.FormatFloat && m_StateBlock.sizeInBits == 32 && m_StateBlock.bitOffset == 0)
		{
			return InputStateBlock.FormatFloat;
		}
		if (flag && m_StateBlock.format == InputStateBlock.FormatBit && m_StateBlock.sizeInBits == 8 && m_StateBlock.bitOffset == 0)
		{
			return InputStateBlock.FormatByte;
		}
		return InputStateBlock.FormatInvalid;
	}
}
