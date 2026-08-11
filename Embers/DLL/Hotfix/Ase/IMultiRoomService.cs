using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface IMultiRoomService
{
	void RegisterMultiMessage();

	UniTask<bool> ChangeModel(int copyId, int model, int dropRate);

	int GetModel(int copyId);

	void SaveRoomId(long roomId);

	void SavaCopyEnterInfo(CopyEnterInfoData copyEnterInfoData);

	void SaveCanAcceptInvite(bool value);

	bool GetCanReturnRoom();

	void SetCanReturnRoom(bool value);

	void SaveBattleData(BattleWorldMode worldMode, Dictionary<int, Dictionary<int, BSData>> accounts, Dictionary<int, BattleRecordPointInfo> recordPointInfo, int killedMonsterId, AutoFightStatistics autoFightStatistics);

	BattleResultViewModel GetBattleResultViewModel();

	BattleReward GetBattleReward();

	void SendLeaveCopyRequest();

	MultiRoomViewModel GetMultiRoomViewModel();

	UniTask<ProtocolRequestResult> CreateMultiRoom(CopyData copyData, bool loadCacheDropRate = false, int campaignPlayId = 0);

	void ClearCopyEnterInfo();

	void AddOpenMultiRoomAction(Action action);

	void InviteOperate(int ope, long inviteUserId, long roomId, int model, CopyData copyData = null);

	UniTask<MultiRoomData> TryJoinFriendTeam(long friendUid, long roomId);

	int GetSelfHeroId();

	CopyData GetCopyData();

	CopyEnterInfoData GetCopyEnterInfoData();

	UniTask<bool> TrySendTeamInvite(long playerUid);

	void BindInviteMessage(Action<MultiFightInviteFriendNotify> action, bool bind);

	UniTask<bool> AddMultiBackListener(Action<LoadingMultiBattleViewModel> action);

	UniTask<bool> AddMultiListener(Action<LoadingMultiBattleViewModel> action);

	void ClearMultiReconnect();

	void SendLoadingRate(int rate);

	void RegisterTmProgress(Action<int, int> updateTmProgress);

	UniTask<bool> RequestData();

	UniTask<bool> TeamRoomChangeSelectRole(int heroId);

	UniTask<bool> TeamRoomChangeSelectBattleProp(List<int> propIds);

	Dictionary<int, string> heroNames();

	void BackToMultiRoom();

	void ClearBattleResult();

	void ReleaseRoom();

	void SetRoom(MultiRoomViewModel viewModel);

	long GetRoomId();

	long GetCheckCode();

	void SetIsMatch(bool isMatch);

	void SetMatchTime(int matchTime);

	string GetSceneLoadPath();

	void SetSceneLoadPath(string path);

	UniTask<bool> SendGetMultiFriendsInfoView(int copyMainId);

	UniTask<bool> SendGameOver(int teamKilled, int passTime, float bossHpLeft, int mode, int monsterKill, float actorDamage, int actorKillCount, long score);

	void SetIsSingleBattle(bool value);

	UniTask<bool> InviteFriendsAsync(List<long> friendIds);

	UniTask<bool> LevelRoomAsync();

	UniTask<bool> KickGamerAsync(long targetUserId, long userId);

	UniTask<bool> StartGameAsync();

	UniTask<bool> StopMatchAsync();

	UniTask<bool> StartMatchAsync();

	UniTask<bool> FightConfirmSetting(int ope);

	UniTask<ProtocolRequestResult> CreateCampaignMultiRoom(CampaignTeamRoomContext context);

	CampaignTeamRoomContext GetCampaignTeamRoomContext();

	void ClearCampaignTeamRoomContext();
}
