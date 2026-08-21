using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface IRankService
{
	UniTask<bool> RequestDatas();

	UniTask<List<RankDefinition.HeroChallengeData>> RequestHeroChallengeData();

	List<RankDefinition.HeroChallengeData> GetHeroChallengeData();

	UniTask<List<PbSuitboxCopyRankInfo>> RequestSuitBoxCopyRankData(int type, int subType, int seasonId = 0);

	UniTask<List<PbRaceCopyRankInfo>> RequestRaceCopyRankData(int type, int subType, int seasonId = 0);

	UniTask<List<PbHeroRankInfo>> RequestHeroChallengeRankData(int type, int subType, int seasonId = 0);

	UniTask<HeroChallengeRankResultData> RequestSuitboxHeroRankInfo(int type, int roleId);

	UniTask<List<PbUnionRankInfo>> RequestGuildActiveRankData();

	UniTask<List<PbUnionCopyRankInfo>> RequestGuildCopyRankData();

	UniTask<List<PbUnionMemberRankInfo>> RequestGuildMemberRankData();

	UniTask<List<PbChallengeCopyRankInfo>> RequestChallengeCopyRankData(int type, int subType, int seasonId = 0);

	UniTask<List<PbChallengeCopyRankInfo>> RequestTowerCopyRankData(int type, int subType, int seasonId = 0);

	int GetHeroChallengeIdForRank();

	void SetHeroChallengeIdForRank(int heroId);

	List<DRRankType> GetOpenRankTypes();

	DRRankType GetLatestRaceCopyConfig();

	DRRankType GetLatestHeroChallengeRank();
}
