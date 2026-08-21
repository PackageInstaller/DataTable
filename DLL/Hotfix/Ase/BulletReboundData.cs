namespace Ase;

public class BulletReboundData
{
	public int reboundCount;

	public bool isReboundEndDead;

	public BulletReboundData Clone()
	{
		return new BulletReboundData
		{
			reboundCount = reboundCount,
			isReboundEndDead = isReboundEndDead
		};
	}
}
