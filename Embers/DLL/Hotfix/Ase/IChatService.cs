using System.Threading.Tasks;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface IChatService
{
	UniTask<bool> GetSubChannel();

	Task<SendMsgResult> SendMsg(ChatChannel channel, PlayerData playerData, string msg, int emojiId, int roomType);

	ChatViewModel GetChatViewModel();

	Task<bool> SendCopyRecruitMsg();

	void OnReceiveNewMsg(int channelFromServer, ChatData chatData);

	int LoadMsgCountToday();

	void SaveMsgCountToday(int msgCountToday);

	void ClearChatLimit();

	Task<bool> GetEmojiUnlockList();

	Task<long> Report(ReportTypeEnum reportType, long uid, int reportId, string reportRemark);

	Task<int> ChangeChildChannel(int curInput);
}
