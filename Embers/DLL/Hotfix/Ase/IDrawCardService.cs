using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface IDrawCardService
{
	UniTask<bool> GetLotteryPool();

	List<DrawCardItemInfo> GetLotteryResultInfos();

	UniTask<bool> ChooseLotteryResult(List<int> index);

	UniTask<int> Lottery(DrawCardMode drawCardMode, DrawCardPoolInfo drawCardPoolInfo);

	UniTask<bool> LotteryTest(int lotteryCount, int poolId, int costPropId);

	Dictionary<int, int> GetPropIdCountDic();

	UniTask<bool> ExchangeTickets(int ticketsId, int num);

	UniTask<List<DrawCardRecordInfo>> RequestServerDrawCardResult();

	bool ChooseResultAddCheckIsNew(DrawCardItemInfo drawCardItemInfo);

	DrawCardMode GetDrawCardMode();

	UniTask<bool> ChooseOptionalHero(int poolId, int upId);

	void LoadRedPoint();

	void SaveRedPoint(int id);

	List<DrawCardTabData> GetDrawCardTabInfos();

	bool CheckRedPoint();

	bool ClosePool(int poolId);
}
