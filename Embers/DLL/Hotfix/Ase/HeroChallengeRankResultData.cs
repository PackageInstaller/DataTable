using System.Collections.Generic;

namespace Ase;

public class HeroChallengeRankResultData
{
	public List<PbHeroRankInfo> HeroRankInfos { get; } = new List<PbHeroRankInfo>();

	public int SelfScore { get; set; }

	public int SelfRank { get; set; }
}
