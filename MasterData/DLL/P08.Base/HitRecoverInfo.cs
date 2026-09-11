using Config;

public struct HitRecoverInfo
{
	public int attackerID;

	public int targetID;

	public E_HitRecoverStatus status;

	public RoleType camp;

	public bool isAttackerLocalPlayer;

	public bool isTargetLocalPlayer;
}
