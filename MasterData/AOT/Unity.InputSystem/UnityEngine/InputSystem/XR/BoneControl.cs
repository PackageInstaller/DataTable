using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.XR;

public class BoneControl : InputControl<Bone>
{
	[InputControl(offset = 0u, displayName = "parentBoneIndex")]
	public IntegerControl parentBoneIndex { get; set; }

	[InputControl(offset = 4u, displayName = "Position")]
	public Vector3Control position { get; set; }

	[InputControl(offset = 16u, displayName = "Rotation")]
	public QuaternionControl rotation { get; set; }

	protected override void FinishSetup()
	{
		parentBoneIndex = GetChildControl<IntegerControl>("parentBoneIndex");
		position = GetChildControl<Vector3Control>("position");
		rotation = GetChildControl<QuaternionControl>("rotation");
		base.FinishSetup();
	}

	public unsafe override Bone ReadUnprocessedValueFromState(void* statePtr)
	{
		return new Bone
		{
			parentBoneIndex = (uint)parentBoneIndex.ReadUnprocessedValueFromStateWithCaching(statePtr),
			position = position.ReadUnprocessedValueFromStateWithCaching(statePtr),
			rotation = rotation.ReadUnprocessedValueFromStateWithCaching(statePtr)
		};
	}

	public unsafe override void WriteValueIntoState(Bone value, void* statePtr)
	{
		parentBoneIndex.WriteValueIntoState((int)value.parentBoneIndex, statePtr);
		position.WriteValueIntoState(value.position, statePtr);
		rotation.WriteValueIntoState(value.rotation, statePtr);
	}
}
