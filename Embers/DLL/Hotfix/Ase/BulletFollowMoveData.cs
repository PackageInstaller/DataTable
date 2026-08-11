namespace Ase;

public class BulletFollowMoveData : BulletMoveDataBase
{
	public int followTargetId;

	public override BulletMoveDataBase Clone()
	{
		return new BulletFollowMoveData
		{
			followTargetId = followTargetId
		};
	}
}
