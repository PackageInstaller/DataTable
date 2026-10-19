using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Controls;

public class Vector3Control : InputControl<Vector3>
{
	[InputControl(offset = 0u, displayName = "X")]
	public AxisControl x { get; set; }

	[InputControl(offset = 4u, displayName = "Y")]
	public AxisControl y { get; set; }

	[InputControl(offset = 8u, displayName = "Z")]
	public AxisControl z { get; set; }

	public Vector3Control()
	{
		m_StateBlock.format = InputStateBlock.FormatVector3;
	}

	protected override void FinishSetup()
	{
		x = GetChildControl<AxisControl>("x");
		y = GetChildControl<AxisControl>("y");
		z = GetChildControl<AxisControl>("z");
		base.FinishSetup();
	}

	public unsafe override Vector3 ReadUnprocessedValueFromState(void* statePtr)
	{
		if ((int)m_OptimizedControlDataType == 1447379763)
		{
			return *(Vector3*)((byte*)statePtr + (int)m_StateBlock.byteOffset);
		}
		return new Vector3(x.ReadUnprocessedValueFromStateWithCaching(statePtr), y.ReadUnprocessedValueFromStateWithCaching(statePtr), z.ReadUnprocessedValueFromStateWithCaching(statePtr));
	}

	public unsafe override void WriteValueIntoState(Vector3 value, void* statePtr)
	{
		if ((int)m_OptimizedControlDataType == 1447379763)
		{
			*(Vector3*)((byte*)statePtr + (int)m_StateBlock.byteOffset) = value;
			return;
		}
		x.WriteValueIntoState(value.x, statePtr);
		y.WriteValueIntoState(value.y, statePtr);
		z.WriteValueIntoState(value.z, statePtr);
	}

	public unsafe override float EvaluateMagnitude(void* statePtr)
	{
		return ReadValueFromStateWithCaching(statePtr).magnitude;
	}

	protected override FourCC CalculateOptimizedControlDataType()
	{
		if (m_StateBlock.sizeInBits == 96 && m_StateBlock.bitOffset == 0 && x.optimizedControlDataType == InputStateBlock.FormatFloat && y.optimizedControlDataType == InputStateBlock.FormatFloat && z.optimizedControlDataType == InputStateBlock.FormatFloat && y.m_StateBlock.byteOffset == x.m_StateBlock.byteOffset + 4 && z.m_StateBlock.byteOffset == x.m_StateBlock.byteOffset + 8)
		{
			return InputStateBlock.FormatVector3;
		}
		return InputStateBlock.FormatInvalid;
	}
}
