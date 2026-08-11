using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[SaveDuringPlay]
[AddComponentMenu("")]
public class CinemachineHardLookAt : CinemachineComponentBase
{
	public override bool IsValid
	{
		get
		{
			if (base.enabled)
			{
				return base.LookAtTarget != null;
			}
			return false;
		}
	}

	public override CinemachineCore.Stage Stage => CinemachineCore.Stage.Aim;

	public override void MutateCameraState(ref CameraState curState, float deltaTime)
	{
		if (!IsValid || !curState.HasLookAt)
		{
			return;
		}
		Vector3 vector = curState.ReferenceLookAt - curState.CorrectedPosition;
		if (vector.magnitude > 0.0001f)
		{
			if (Vector3.Cross(vector.normalized, curState.ReferenceUp).magnitude < 0.0001f)
			{
				curState.RawOrientation = Quaternion.FromToRotation(Vector3.forward, vector);
			}
			else
			{
				curState.RawOrientation = Quaternion.LookRotation(vector, curState.ReferenceUp);
			}
		}
	}
}
