using UnityEngine;

public class QWTeleportAction : QWAgentAction
{
	public Vector3 pos;

	public Quaternion rotation;

	public QWTeleportAction()
		: base(E_Type.Teleport)
	{
	}
}
