using System.Runtime.CompilerServices;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;
using UnityEngine.Scripting;
using UnityEngine.XR;

namespace UnityEngine.InputSystem.XR;

[Preserve]
[InputControlLayout(stateType = typeof(PoseState))]
public class PoseControl : InputControl<PoseState>
{
	public ButtonControl isTracked { get; set; }

	public IntegerControl trackingState { get; set; }

	public Vector3Control position { get; set; }

	public QuaternionControl rotation { get; set; }

	public Vector3Control velocity { get; set; }

	public Vector3Control angularVelocity { get; set; }

	public PoseControl()
	{
		m_StateBlock.format = PoseState.s_Format;
	}

	protected override void FinishSetup()
	{
		isTracked = GetChildControl<ButtonControl>("isTracked");
		trackingState = GetChildControl<IntegerControl>("trackingState");
		position = GetChildControl<Vector3Control>("position");
		rotation = GetChildControl<QuaternionControl>("rotation");
		velocity = GetChildControl<Vector3Control>("velocity");
		angularVelocity = GetChildControl<Vector3Control>("angularVelocity");
		base.FinishSetup();
	}

	public unsafe override PoseState ReadUnprocessedValueFromState(void* statePtr)
	{
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		if ((int)m_OptimizedControlDataType == 1349481317)
		{
			return System.Runtime.CompilerServices.Unsafe.Read<PoseState>((byte*)statePtr + (int)m_StateBlock.byteOffset);
		}
		return new PoseState
		{
			isTracked = (isTracked.ReadUnprocessedValueFromStateWithCaching(statePtr) > 0.5f),
			trackingState = (InputTrackingState)trackingState.ReadUnprocessedValueFromStateWithCaching(statePtr),
			position = position.ReadUnprocessedValueFromStateWithCaching(statePtr),
			rotation = rotation.ReadUnprocessedValueFromStateWithCaching(statePtr),
			velocity = velocity.ReadUnprocessedValueFromStateWithCaching(statePtr),
			angularVelocity = angularVelocity.ReadUnprocessedValueFromStateWithCaching(statePtr)
		};
	}

	public unsafe override void WriteValueIntoState(PoseState value, void* statePtr)
	{
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Expected I4, but got Unknown
		if ((int)m_OptimizedControlDataType == 1349481317)
		{
			System.Runtime.CompilerServices.Unsafe.Write((byte*)statePtr + (int)m_StateBlock.byteOffset, value);
			return;
		}
		isTracked.WriteValueIntoState(value.isTracked, statePtr);
		trackingState.WriteValueIntoState((uint)(int)value.trackingState, statePtr);
		position.WriteValueIntoState(value.position, statePtr);
		rotation.WriteValueIntoState(value.rotation, statePtr);
		velocity.WriteValueIntoState(value.velocity, statePtr);
		angularVelocity.WriteValueIntoState(value.angularVelocity, statePtr);
	}

	protected override FourCC CalculateOptimizedControlDataType()
	{
		if (m_StateBlock.sizeInBits == 480 && m_StateBlock.bitOffset == 0 && isTracked.optimizedControlDataType == 1113150533 && trackingState.optimizedControlDataType == 1229870112 && position.optimizedControlDataType == 1447379763 && rotation.optimizedControlDataType == 1364541780 && velocity.optimizedControlDataType == 1447379763 && angularVelocity.optimizedControlDataType == 1447379763 && trackingState.m_StateBlock.byteOffset == isTracked.m_StateBlock.byteOffset + 4 && position.m_StateBlock.byteOffset == isTracked.m_StateBlock.byteOffset + 8 && rotation.m_StateBlock.byteOffset == isTracked.m_StateBlock.byteOffset + 20 && velocity.m_StateBlock.byteOffset == isTracked.m_StateBlock.byteOffset + 36 && angularVelocity.m_StateBlock.byteOffset == isTracked.m_StateBlock.byteOffset + 48)
		{
			return 1349481317;
		}
		return 0;
	}
}
