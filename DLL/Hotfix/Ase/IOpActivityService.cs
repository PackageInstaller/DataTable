using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public interface IOpActivityService
{
	IMessenger GetMessager();

	UniTask<bool> RequestOpActDatas();

	UniTask<ActivitySingleServerData> RequestSingleOpActData(int activityTypeId);

	UniTask<ActivityReward> GetTaskReward(int type, int id, int rankId = 0);

	bool GetActivityOpenState(out string msg);

	OpActViewModel GetActivityVm();

	UniTask<bool> GetTaskRankProgress(int activityId);

	UniTask<ActivityReward> GetActivtiyVersionReward(int activityTypeId, int activityVersionId);

	UniTask<ActivityReward> GetTaskRankProgressReward(int rankId, int progressUid, int activityType);

	UniTask<(DrawCardActivityInfo, BroadcastJsonData)> SendDrawCardInfoRst(int activityTypeId);

	UniTask<DrawCardActivityResult> SendDrawCardRst(int activityTypeId);

	UniTask<DrawCardActivityInfo> SendLotteryInfoRst(int activityTypeId);

	UniTask<DrawCardActivityResult> SendLotteryRst(int activityTypeId, int pos);
}
