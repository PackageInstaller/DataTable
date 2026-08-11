using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface IHomeLandService
{
	UniTask<bool> RequestAllData();

	UniTask<bool> RequestFarmInfo();

	FarmInfo GetFarmInfo();

	int[] GetFriendFarmState(long friendUid);

	int[] GetTodayCount();

	Dictionary<int, bool> GetUnLockSeedList();

	UniTask<long[]> StartPlant(int gridId, int seedId);

	UniTask<bool> AbortPlant(int gridId);

	UniTask<HarvestData> HarvestPlant(int gridId);

	UniTask<long> SpeedUpPlant(int gridId, int itemId, int itemCount);

	UniTask<bool> GetFriendFarmInfo(long friendUid);

	UniTask<bool> IncreaseFriendPlant(long friendUid, int gridId);

	UniTask<HarvestData> HarvestFriendPlant(long friendUid, int gridId);

	UniTask<bool> RequsetBattlePropData();

	HomeLandViewModel GetVm();

	UniTask<bool> UpgradeHomeland(int buildingType);

	UniTask<List<HomelandBuildingData>> GetFriendBuildingInfos(PlayerData data);

	void UseBattleProp(BPData bpData);

	void UseBattleProp(int teamId);

	int SetCarryPropDataMax(int index);

	UniTask<bool> MakeBattleProp(int propId, int count);

	List<BPData> GetAllBPDatas();

	Dictionary<int, BPCarryItemViewModel> GetCarringBPs();

	List<int> GetCarringBPIds();

	void SaveCarringBPs(BPData d1, BPData d2);

	void AddShowGetBPListener(Action<BattlePropGetViewModel> action);

	void AddEquipNewBPListener(Action<BattleProps> action);

	void RemoveGetBPListener();

	Dictionary<int, BPData> GetBpCarrying();

	Dictionary<int, BPData> GetBPCarryings(List<PbRoomBattlePropInfo> battlePropInfos);

	Dictionary<int, BPData> GetBPWarehouse();

	BPData GetBpDataById(int bpId);

	BPData ShowBattlePropDrawingGet(int id);

	int GetTodayBoughtCountInShop();

	int GetTodayBuyLimitInShop();

	HomeShopInfoData GetSelfHomeShopData();

	HomeShopInfoData GetFriendHomeShopData(long friendId);

	List<HomeShopInfoData> GetAllFriendHomeShopDatas();

	UniTask<bool> RequestShopData();

	UniTask<List<PropDataBase>> RequestShopBuy(int gridId, int buyCount);

	UniTask<List<HomeShopInfoData>> RequestAllFriendShopList();

	UniTask<HomeShopInfoData> RequestEnterFriendShop(long friendId);

	UniTask<List<PropDataBase>> RequestFriendShopBuy(long friendId, int gridId, int buyCount);

	HomeShopViewModel GetHomeShopViewModel();

	UniTask<SailInfo> GetSailLightEventList();

	UniTask<long> SendSailLightDispatch(List<int> heroIds, int eventId);

	UniTask<SailReward> GetSailLightReward(long eventId);

	void Dispose();
}
