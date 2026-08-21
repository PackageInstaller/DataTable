using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public interface ISocialService
{
	IMessenger GetMessager();

	void Dispose();

	UniTask<bool> RequestDatas();

	void PublishSocialMessage(SocialMessageEnum messageEnum, object args);

	UniTask<bool> RequestFriendsData();

	UniTask<bool> RequestFriendApplyData();

	UniTask<bool> RequestBlackListData();

	UniTask<bool> RequestFriendChatData();

	void SetChatDataReadStateWithFriend(long uid, bool read);

	UniTask<bool> AddFriend(PlayerData playerData, string verifyMessage);

	UniTask<bool> AddFriend(long uid, string verifyMessage);

	UniTask<bool> DelFriend(long uid);

	UniTask<bool> HandleFriendBlackList(PlayerData playerData, bool ope);

	UniTask<bool> SendFriendChatMessage(long uid, string chatMessage);

	UniTask<PlayerData> RequestSearchPlayer(long uid);

	UniTask<bool> ReplyFriendRequest(long uid, bool reply);

	UniTask<bool> RequestSendFriendEnergy(long uid);

	UniTask<bool> RequestGetFriendSendEnergy(long uid);

	PlayerData GetTargetFriendData(long uid);

	PlayerData GetTargetFriendApplyData(long uid);

	UniTask<PlayerData> GetTargetGameUserInfo(long uid);

	List<PlayerChatData> GetFriendChatDatas(long uid);

	FriendViewModel GetFriendViewModel();
}
