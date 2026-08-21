using UnityEngine;

internal class QWSetCameraLookAtTarget : QWAgentAction
{
	public QWCameraFlag cameraFlag;

	public Transform lookAt;

	public QWSetCameraLookAtTarget()
		: base(E_Type.Camera_LookAtTarget)
	{
	}

	public override void Reset()
	{
		base.Reset();
		cameraFlag = QWCameraFlag.Player;
		lookAt = null;
	}
}
