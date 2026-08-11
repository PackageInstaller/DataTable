using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public interface IHomeComeService
{
	IMessenger GetMessager();

	UniTask<bool> GetHomeComeInfoRst();

	UniTask<PbDropThing> GetHomeComeGiftRst();

	UniTask<PbDropThing> GetHomeComeSignRewardRst(int SignId);

	UniTask<PbDropThing> GetHomeComeTaskRewardRst(int TaskId);

	bool GetHomeComeOpenState();

	HomeComeData GetData();

	bool TryGetTaskProgress(int taskId, out HomeComeTaskProgressData data);

	bool HasAnyRedPoint();

	bool HasGiftRedPoint();

	bool HasSignRedPoint();

	bool HasTaskRedPoint();
}
