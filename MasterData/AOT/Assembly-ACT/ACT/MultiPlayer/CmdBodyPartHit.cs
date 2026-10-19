using UnityEngine;

namespace ACT.MultiPlayer;

public struct CmdBodyPartHit
{
	public byte bodyIndex;

	public float forceAngle;

	public Vector3 touchPos;

	public bool attackerFaceLeft;

	public float hitStrength;
}
