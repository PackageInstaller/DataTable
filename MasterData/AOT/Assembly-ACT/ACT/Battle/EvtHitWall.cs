using EasyCharacterMovement;

namespace ACT.Battle;

public class EvtHitWall : BaseEvt
{
	public CollisionResult result;

	public bool changeDir;

	public int hitWallNum;

	public override void Reset()
	{
		result = default;
	}
}
