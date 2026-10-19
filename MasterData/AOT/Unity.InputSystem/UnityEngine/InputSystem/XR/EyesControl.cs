using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.XR;

public class EyesControl : InputControl<Eyes>
{
	[InputControl(offset = 0u, displayName = "LeftEyePosition")]
	public Vector3Control leftEyePosition { get; set; }

	[InputControl(offset = 12u, displayName = "LeftEyeRotation")]
	public QuaternionControl leftEyeRotation { get; set; }

	[InputControl(offset = 28u, displayName = "RightEyePosition")]
	public Vector3Control rightEyePosition { get; set; }

	[InputControl(offset = 40u, displayName = "RightEyeRotation")]
	public QuaternionControl rightEyeRotation { get; set; }

	[InputControl(offset = 56u, displayName = "FixationPoint")]
	public Vector3Control fixationPoint { get; set; }

	[InputControl(offset = 68u, displayName = "LeftEyeOpenAmount")]
	public AxisControl leftEyeOpenAmount { get; set; }

	[InputControl(offset = 72u, displayName = "RightEyeOpenAmount")]
	public AxisControl rightEyeOpenAmount { get; set; }

	protected override void FinishSetup()
	{
		leftEyePosition = GetChildControl<Vector3Control>("leftEyePosition");
		leftEyeRotation = GetChildControl<QuaternionControl>("leftEyeRotation");
		rightEyePosition = GetChildControl<Vector3Control>("rightEyePosition");
		rightEyeRotation = GetChildControl<QuaternionControl>("rightEyeRotation");
		fixationPoint = GetChildControl<Vector3Control>("fixationPoint");
		leftEyeOpenAmount = GetChildControl<AxisControl>("leftEyeOpenAmount");
		rightEyeOpenAmount = GetChildControl<AxisControl>("rightEyeOpenAmount");
		base.FinishSetup();
	}

	public unsafe override Eyes ReadUnprocessedValueFromState(void* statePtr)
	{
		return new Eyes
		{
			leftEyePosition = leftEyePosition.ReadUnprocessedValueFromStateWithCaching(statePtr),
			leftEyeRotation = leftEyeRotation.ReadUnprocessedValueFromStateWithCaching(statePtr),
			rightEyePosition = rightEyePosition.ReadUnprocessedValueFromStateWithCaching(statePtr),
			rightEyeRotation = rightEyeRotation.ReadUnprocessedValueFromStateWithCaching(statePtr),
			fixationPoint = fixationPoint.ReadUnprocessedValueFromStateWithCaching(statePtr),
			leftEyeOpenAmount = leftEyeOpenAmount.ReadUnprocessedValueFromStateWithCaching(statePtr),
			rightEyeOpenAmount = rightEyeOpenAmount.ReadUnprocessedValueFromStateWithCaching(statePtr)
		};
	}

	public unsafe override void WriteValueIntoState(Eyes value, void* statePtr)
	{
		leftEyePosition.WriteValueIntoState(value.leftEyePosition, statePtr);
		leftEyeRotation.WriteValueIntoState(value.leftEyeRotation, statePtr);
		rightEyePosition.WriteValueIntoState(value.rightEyePosition, statePtr);
		rightEyeRotation.WriteValueIntoState(value.rightEyeRotation, statePtr);
		fixationPoint.WriteValueIntoState(value.fixationPoint, statePtr);
		leftEyeOpenAmount.WriteValueIntoState(value.leftEyeOpenAmount, statePtr);
		rightEyeOpenAmount.WriteValueIntoState(value.rightEyeOpenAmount, statePtr);
	}
}
