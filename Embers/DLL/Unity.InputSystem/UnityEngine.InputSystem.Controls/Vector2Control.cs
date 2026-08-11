using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Controls;

public class Vector2Control : InputControl<Vector2>
{
	[InputControl(offset = 0u, displayName = "X")]
	public AxisControl x { get; set; }

	[InputControl(offset = 4u, displayName = "Y")]
	public AxisControl y { get; set; }

	public Vector2Control()
	{
		m_StateBlock.format = InputStateBlock.FormatVector2;
	}

	protected override void FinishSetup()
	{
		x = GetChildControl<AxisControl>("x");
		y = GetChildControl<AxisControl>("y");
		base.FinishSetup();
	}

	public unsafe override Vector2 ReadUnprocessedValueFromState(void* statePtr)
	{
		if ((int)m_OptimizedControlDataType == 1447379762)
		{
			return *(Vector2*)((byte*)statePtr + (int)m_StateBlock.byteOffset);
		}
		return new Vector2(x.ReadUnprocessedValueFromStateWithCaching(statePtr), y.ReadUnprocessedValueFromStateWithCaching(statePtr));
	}

	public unsafe override void WriteValueIntoState(Vector2 value, void* statePtr)
	{
		if ((int)m_OptimizedControlDataType == 1447379762)
		{
			*(Vector2*)((byte*)statePtr + (int)m_StateBlock.byteOffset) = value;
			return;
		}
		x.WriteValueIntoState(value.x, statePtr);
		y.WriteValueIntoState(value.y, statePtr);
	}

	public unsafe override float EvaluateMagnitude(void* statePtr)
	{
		return ReadValueFromStateWithCaching(statePtr).magnitude;
	}

	protected override FourCC CalculateOptimizedControlDataType()
	{
		if (m_StateBlock.sizeInBits == 64 && m_StateBlock.bitOffset == 0 && x.optimizedControlDataType == InputStateBlock.FormatFloat && y.optimizedControlDataType == InputStateBlock.FormatFloat && y.m_StateBlock.byteOffset == x.m_StateBlock.byteOffset + 4)
		{
			return InputStateBlock.FormatVector2;
		}
		return InputStateBlock.FormatInvalid;
	}
}
