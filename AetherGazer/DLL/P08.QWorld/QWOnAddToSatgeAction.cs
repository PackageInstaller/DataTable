using UnityEngine;

public class QWOnAddToSatgeAction : QWAgentAction
{
	public bool isFirstAdd;

	public QworldEntityLookAtType lookAtType;

	public Vector3 lookAtPos;

	public int lookAtEntityId;

	public QWOnAddToSatgeAction()
		: base(E_Type.AddToStage)
	{
	}

	public override void Reset()
	{
		base.Reset();
		lookAtType = QworldEntityLookAtType.NotLookAt;
		isFirstAdd = false;
	}
}
