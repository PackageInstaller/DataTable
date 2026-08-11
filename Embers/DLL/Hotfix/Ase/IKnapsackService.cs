using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public interface IKnapsackService
{
	IMessenger GetMessager();

	void PublishPropChangeMessage(PropChangeMessageEnum messageEnum, List<KnapsackPropData> propDatas);

	UniTask<bool> RequestKnapsackData();

	UniTask<RewardGetData> RequestDecomposeEquipment(List<long> uids, EquipmentEnum type);

	UniTask<List<int>> GetEquipmentDecomposePreferences(EquipmentEnum equipmentEnum);

	UniTask<bool> SetEquipmentDecomposePreferences(EquipmentEnum equipmentEnum, List<int> preferences);

	UniTask<KeyValuePair<bool, RewardGetData>> RequestDecomposeThing(List<PropData> things);

	UniTask<KeyValuePair<bool, List<KnapsackPropData>>> RequestPropWholeApart(int targetId, int opeCount, int opeType);

	void AddProp(List<KnapsackPropData> datas);

	void AddProp(KnapsackPropData propData);

	bool CheckEnough(List<PropDataBase> needProps);

	bool CheckEnough(PropDataBase needProp);

	KnapsackViewModel GetKnapsackViewModel();

	UniTask<RewardThings> OpenPackRequest(int packId, int packCount, List<int> itemIdList);

	UniTask<PropGetViewModel> SendCurrencyExchange(int usePropId, int targetPropId, int count);

	UniTask<PropGetViewModel> SendCurrencyExchange(int targetPropId, int count);

	UniTask SetExpiredPropShowed();
}
