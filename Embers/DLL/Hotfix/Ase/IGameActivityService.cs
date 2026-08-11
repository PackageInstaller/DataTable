using System.Threading.Tasks;

namespace Ase;

public interface IGameActivityService
{
	Task<bool> SendGetGameActivityInfoRequest();

	Task<bool> SendCompleteTaskRequest(int taskId);

	Task<PropGetViewModel> SendGetRewardRequest(int rewardId);

	GameActivityData GetGameActivityData();

	GameActivityViewModel GetGameActivityViewModel();
}
