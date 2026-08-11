using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Controls;

public class QuaternionControl : InputControl<Quaternion>
{
	[InputControl(displayName = "X")]
	public AxisControl x { get; set; }

	[InputControl(displayName = "Y")]
	public AxisControl y { get; set; }

	[InputControl(displayName = "Z")]
	public AxisControl z { get; set; }

	[InputControl(displayName = "W")]
	public AxisControl w { get; set; }

	public QuaternionControl()
	{
		m_StateBlock.sizeInBits = 128u;
		m_StateBlock.format = InputStateBlock.FormatQuaternion;
	}

	protected override void FinishSetup()
	{
		x = GetChildControl<AxisControl>("x");
		y = GetChildControl<AxisControl>("y");
		z = GetChildControl<AxisControl>("z");
		w = GetChildControl<AxisControl>("w");
		base.FinishSetup();
	}

	public unsafe override Quaternion ReadUnprocessedValueFromState(void* statePtr)
	{
		if ((int)m_OptimizedControlDataType == 1364541780)
		{
			return *(Quaternion*)((byte*)statePtr + (int)m_StateBlock.byteOffset);
		}
		return new Quaternion(x.ReadValueFromStateWithCaching(statePtr), y.ReadValueFromStateWithCaching(statePtr), z.ReadValueFromStateWithCaching(statePtr), w.ReadUnprocessedValueFromStateWithCaching(statePtr));
	}

	public unsafe override void WriteValueIntoState(Quaternion value, void* statePtr)
	{
		if ((int)m_OptimizedControlDataType == 1364541780)
		{
			*(Quaternion*)((byte*)statePtr + (int)m_StateBlock.byteOffset) = value;
			return;
		}
		x.WriteValueIntoState(value.x, statePtr);
		y.WriteValueIntoState(value.y, statePtr);
		z.WriteValueIntoState(value.z, statePtr);
		w.WriteValueIntoState(value.w, statePtr);
	}

	protected override FourCC CalculateOptimizedControlDataType()
	{
		if (m_StateBlock.sizeInBits == 128 && m_StateBlock.bitOffset == 0 && x.optimizedControlDataType == InputStateBlock.FormatFloat && y.optimizedControlDataType == InputStateBlock.FormatFloat && z.optimizedControlDataType == InputStateBlock.FormatFloat && w.optimizedControlDataType == InputStateBlock.FormatFloat && y.m_StateBlock.byteOffset == x.m_StateBlock.byteOffset + 4 && z.m_StateBlock.byteOffset == x.m_StateBlock.byteOffset + 8 && w.m_StateBlock.byteOffset == x.m_StateBlock.byteOffset + 12 && x.m_ProcessorStack.length == 0 && y.m_ProcessorStack.length == 0 && z.m_ProcessorStack.length == 0)
		{
			return InputStateBlock.FormatQuaternion;
		}
		return InputStateBlock.FormatInvalid;
	}
}
