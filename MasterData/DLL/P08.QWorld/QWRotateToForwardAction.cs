using UnityEngine;

public class QWRotateToForwardAction : QWAgentAction
{
	public Vector3 forward;

	public QWRotateToForwardAction()
		: base(E_Type.RotateToForward)
	{
	}

	public override void Reset()
	{
		base.Reset();
	}
}
