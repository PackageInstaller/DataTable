using UnityEngine;

public class QWTeleportCameraAction : QWAgentAction
{
	public Vector3 pos;

	public Quaternion rotation;

	public QWTeleportCameraAction()
		: base(E_Type.TeleportCamera)
	{
	}
}
