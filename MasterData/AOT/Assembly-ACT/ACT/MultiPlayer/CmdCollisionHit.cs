using UnityEngine;

namespace ACT.MultiPlayer;

public struct CmdCollisionHit
{
	public byte bodyIndex;

	public Vector3 touchPos;

	public bool attackerFaceLeft;
}
