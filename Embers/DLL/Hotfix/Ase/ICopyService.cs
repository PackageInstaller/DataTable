using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface ICopyService
{
	bool CheckCopyOpen(int copyId);

	bool CheckCopyTypeOpen(int copyType);

	UniTask<bool> RequestData();

	UniTask<bool> RequestTowerData();

	UniTask RefreshType3Param();

	void CopyComplete(int copyId, int star, int score, bool isSingle);

	void CopyType3RefreshCount();

	void UpdateMaxCopyIdx(long maxCopyOpenIndex);

	UniTask<CopyEnterInfoData> EnterBattleWorld(CopyData copyData, List<int> roleIds, List<TeamMember> teamMembers, int battleMode, int dropType, List<int> battlePropIds);

	CopyViewModel GetCopyVM();

	void SaveCarringBPs(int copyId, int bpId1, int bpId2);

	UniTask GetFloorCopyStarInfo();

	UniTask<bool> SetFloorCopySetting(List<CopyType4TeamConfig> copyConfigs);

	bool SetFloorCopySettingBPConfig(List<CopyType4TeamConfig> copyConfigs);

	UniTask<bool> ResetFloorCopySetting(List<int> copyIds);

	UniTask GetFloorCopyRewardInfo(int zone);

	UniTask<RewardThings> GetFloorCopyReward(int zone, int index);

	UniTask GetRaceCopyInfo();

	UniTask GetRaceCopyTotalScore();

	UniTask<RewardThings> GetRaceCopyReward(int id);

	UniTask<List<CopyPlayerRankData>> GetRankList(int type, int copyType);

	UniTask<bool> SetRaceCopyTroop(CopyType5Team config);

	UniTask<bool> ResetRaceCopyTroop(int copyType);

	UniTask<KeyValuePair<bool, Dictionary<int, int>>> GetChallengeCopyPlayerRankInfo();

	Dictionary<int, int> GetType5CopySelects();

	void SaveType5CopySelects(Dictionary<int, int> obj);

	void SaveType5Teams(List<CopyType5TeamConfig> obj);

	List<CopyType5TeamConfig> GetType5Teams();

	void UpdateRealisticTime();

	void RemoveCopyTimer();

	List<CopyRedData> GetCopyRedDatas();

	void SaveCopyRedDatas(List<CopyRedData> obj);

	Dictionary<int, int> GetCopyType1SortDatas();

	void SaveCopyType1SortDatas(Dictionary<int, int> sortDatas);

	bool CheckInviteCopyOpen(int copyId);

	int GetType4RecordFlag();

	void SaveType4RecordFlag(int copyTypeId);

	CopyUnlockSaveData GetCopyUnlockSaveData();

	void SaveCopyUnlockSaveData(CopyUnlockSaveData obj);

	UniTask UpTowerTalentLevel(int upTalentId);

	UniTask ResetTowerTalent();

	void UpdateTowerTalentUpLevel();

	void SetTowerBattleConfig(int roleId, int teamSetId, List<int> propIds);

	UniTask<bool> PlayTower(CopyData copyData, int towerNum, int endlessIndex, string preSceneName, bool sendTowerBattleData);

	UniTask<bool> PlayTower(int copyId, int towerNum, int endlessIndex, string preSceneName, bool sendTowerBattleData);

	UniTask<bool> ContinuePlayTower();

	UniTask<bool> RequestEnterTower(int copyId, List<int> addBuffs, List<AchievementMedal> achievementMedals);

	bool GetTowerCopyUnLock(int copyId);

	bool GetTowerAreaFinishByCopyId(int copyId);

	int GetTowerOneAreaRedPoint(int activityId);

	void SetTowerActivityRedPoint(int activityId, int value);

	bool GetTowerUpTalentRedPoint(bool broadcastMessage);

	UniTask<bool> RequestSaveTowerBuffData(List<int> selectBuffs, int refreshCount, int towerNum, int endlessLayer);

	bool GetRandomBuffCollectState(int copyId, int buffId);

	UniTask<bool> RequestClearTowerBuffData();

	int GetCurChallengeTowerLayer();

	UniTask<bool> GetType4CopySettingInfos(List<CopyData> copyDatas);

	UniTask<bool> GetType4CopySettingInfos(CopyData copyData);

	int GetCacheDropRate(int copyId);

	void SetCacheDropRate(int copyId, int dropRate);

	void ResetCacheDropRate(int copyId);

	bool GetIsCampaignWorldBoss(int copyId);

	void Dispose();
}
