using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface IGuildService
{
	void PublishMessage(GuildMessageEnum messageEnum, object args);

	UniTask<bool> RequestInitData();

	UniTask<MyGuildData> RequestMyGuildData();

	UniTask<MyGuildData> RequestMyGuildBaseInfo();

	UniTask<List<PlayerDataBase>> RequestGuildApplicationData();

	UniTask<List<GuildData>> RequestRecommendGuildData(int type);

	UniTask<List<GuildData>> RefreshRecommendGuildData();

	UniTask<GuildData> RequestSearchGuild(string content);

	UniTask<List<GuildData>> RequestGuildRankData();

	UniTask<GuildData> RequestCreateGuild(string name, string desc, int flag, int auditType, int levelThreshold);

	UniTask<bool> RequestChangeGuildFlag(int newFlag);

	UniTask<bool> RequestChangeGuildName(string newName);

	UniTask<bool> RequestChangeGuildDesc(string newDesc);

	UniTask<bool> RequestChangeAuditType(int newAuditType, int newLevelThreshold);

	UniTask<MyGuildData> RequestJoinInGuildFast();

	UniTask<bool> RequestJoinInGuild(long uid, Action<long> coolingCompleteCb);

	UniTask<bool> RequestReplyToApplication(long uid, bool ope);

	UniTask<bool> RequestCleanApplication();

	UniTask<bool> RequestPassAllApplication();

	UniTask<bool> RequestInviteToGuild(long uid, bool haveCooling);

	UniTask<MyGuildData> RequestReplyToInvitation(long guildUid, bool ope);

	UniTask<List<PlayerDataBase>> RequestRecommendPlayers();

	UniTask<bool> RequestSendRecruitInfo();

	UniTask<bool> RequestInviteAll(List<long> uidList);

	UniTask<bool> RequestBuildGuild();

	UniTask<bool> RequestChangeMemberPosition(long memberUid, int newPosition);

	UniTask<bool> RequestTransMaster(long memberUid);

	UniTask<bool> RequestKickMember(long memberUid);

	UniTask<bool> RequestExitGuild();

	UniTask<List<GuildTaskData>> RequestGuildTaskData();

	UniTask<bool> RequestCompleteGuildTask(int taskId);

	UniTask<RewardGetData> RequestGetActivityReward(int rewardLevel);

	UniTask<RewardGetData> RequestGetAllActivityReward(List<int> levelsCanGet);

	void OnGuildActivityChange(bool isActive);

	GuildActivityExpeditionData GetGuildActivityData();

	UniTask<RewardThings> RequestGuildActivityExpeditionReward(int copyId);

	UniTask<bool> RequestGuildActivityExpeditionData();

	MyGuildData GetMyGuildData();

	void GetGuildApplicationState(long guildUid, out bool isCooling, out float leftTime);

	void GetPlayerInvitationState(long guildUid, out bool isCooling, out float leftTime);

	bool GuildMemberCheck(long playerUid);

	GuildEventMsgJsonData LoadEventMsgDatas(long uid);

	void Dispose();
}
