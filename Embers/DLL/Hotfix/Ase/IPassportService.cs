using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

public interface IPassportService
{
	UniTask<bool> SendGetPassportInfoRequest();

	UniTask<bool> SendGetPassportTaskRequest();

	UniTask<bool> SendTaskCompleteRequest(int taskId, int type);

	UniTask<bool> SendGetRewardRequest(int indexId, bool clearReward = true);

	Dictionary<int, int> GetTaskIdValueDic();

	List<int> GetCompleteTask();

	List<PropDataBase> GetRewardList();

	UniTask<bool> BuyPassportLevel(int addLevel);

	UniTask<bool> BuyPassport(int type);

	UniTask<bool> SendGetPackRequest(int index, int selectIndex);

	PassportInfo GetPassportInfo();

	Vector2 GetPackIdValue();

	void ClearPackReward();

	void ClearReward();

	List<PropDataBase> GetPackReward();

	PassportViewModel GetPassportViewModel();

	bool CheckPassportOpen();
}
