using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface IRoleService
{
	long Uid { get; }

	bool NeedCreateRole { get; }

	bool GuideLevelComplete { get; }

	void CreateRoleData(long uid, UserBaseInfo userBaseInfo, long serverOpneTime);

	UniTask<bool> UpdateCurrencyData();

	UniTask UpdateAccountLimit();

	RoleViewModel GetRoleData();

	UniTask RequestUserBaseInfo();

	UniTask<List<RoleDecorateData>> GetIconOrTitleList(RoleDecorateEnum type);

	UniTask<List<BackgroundData>> RequestBackgroundData();

	UniTask<bool> ChangeIconOrTitle(RoleDecorateEnum type, int id);

	UniTask<bool> ChangeShowHero(List<int> heroIds);

	void UpdateRoleLevelAndExp(int level, long exp);

	UniTask<bool> ChangeBoardHeroData(int id);

	UniTask<bool> ChangeBoardBackgroundData(int bgId);

	UniTask<bool> SendPlayerInfoUseMedals(List<PbMedalInfo> medals);

	UniTask<bool> SendPlayerInfoUseCopyInfoShowOrSetBackGround(int type, int id);

	UniTask<bool> SendRecoverUserVit(int type, int id);

	long[] GetRecoverVitCost();

	void RegisterGoldfingerNotify(Action action);

	UniTask<bool> InitManualServerInfo();

	UniTask<bool> RequestManualRewardInfo();

	UniTask<KeyValuePair<bool, RewardGetData>> RequestGetManualReward(int index);

	UniTask<bool> RequestUseExchangeCode(string code);

	void SetManualOpenState(int drManualId);

	void SetManualOpenState(int manualReleaseType, int drTeachingId);

	List<int> GetManualRewardStates();

	bool GetManualRewardState(int index);

	bool GetManualOpenState(int index);

	void SavePay(long firstCharge, long totalCharge);

	void Dispose();
}
