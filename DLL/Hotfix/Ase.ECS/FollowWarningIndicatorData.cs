namespace Ase.ECS;

public class FollowWarningIndicatorData : WarningIndicatorData
{
	public int FollowEntityId;

	public void ProcessFollow(int followEntityId)
	{
		FollowEntityId = followEntityId;
	}

	public override void Clear()
	{
		base.Clear();
		FollowEntityId = 0;
	}
}
