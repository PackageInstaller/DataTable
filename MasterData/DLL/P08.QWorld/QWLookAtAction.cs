using UnityEngine;

public class QWLookAtAction : QWAgentAction
{
	public float headWeight;

	public float IkBoneWeight;

	public float duration;

	public Transform lookAtTarget;

	public bool npcForce;

	public QWLookAtAction()
		: base(E_Type.LookAt)
	{
	}

	public override void Reset()
	{
		base.Reset();
		headWeight = 0.8f;
		IkBoneWeight = 1f;
		duration = 0.6f;
		lookAtTarget = null;
		npcForce = false;
	}
}
