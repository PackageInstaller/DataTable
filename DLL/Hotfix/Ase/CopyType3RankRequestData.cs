namespace Ase;

public class CopyType3RankRequestData
{
	public int RankTypeId { get; }

	public int RankTarget { get; }

	public int HeroId { get; }

	public CopyType3RankRequestData(int rankTypeId, int rankTarget, int heroId)
	{
		RankTypeId = rankTypeId;
		RankTarget = rankTarget;
		HeroId = heroId;
	}
}
