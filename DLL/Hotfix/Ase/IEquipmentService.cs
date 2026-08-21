using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface IEquipmentService
{
	UniTask<bool> RequestEquipmentData();

	UniTask<bool> RequestUsedEquipmentData();

	UniTask<bool> RequestUnusedEquipmentData();

	Dictionary<long, WeaponData> GetAllWeaponData();

	Dictionary<long, ArmourData> GetAllArmourData();

	WeaponData GetWeaponById(long uid);

	ArmourData GetArmourById(long uid);

	List<ArmourData> GetArmourListByType(ArmourEnum armourType);

	List<WeaponData> GetWeaponListByType(WeaponEnum weaponType);

	WeaponData CreateWeapon(PbEquipBase weapon);

	UniTask<WeaponData> AddWeapon(PbEquipBase weapon, bool isNew = true);

	ArmourData CreateArmour(PbEquipBase armour);

	ArmourData AddArmour(PbEquipBase armour, bool isNew = true);

	UniTask<bool> EquipUpgrade(EquipmentDataBase data, List<ItemResult> itemChange, List<long> equipChange, int coinNeed);

	UniTask<bool> WeaponUpStar(int weaponId, long weaponUid);

	UniTask<bool> WeaponUpRefine(int weaponId, long weaponUid, List<long> equipUidList);

	UniTask<bool> ChangeLock(int type, long uid);

	void RemoveEquipments(List<long> uids);

	bool CheckWeaponId(int weaponId);

	UniTask<bool> UnLockArmourEntry(long equipUid);

	UniTask<bool> ResetArmourEntry(long equipUid, int entryIndex, int poolIndex, int type);

	UniTask<bool> RefreshArmourAffixRst(long equipUid);

	UniTask<bool> MakeSuitBox(long suitBoxId, int propId, List<EntryData> oldEntryList, int costCoin);

	UniTask<bool> SelectSuitBox(int index, long uid);

	UniTask<bool> EnterMakeSuitBox(long uid, List<EntryData> oldEntryList);

	UniTask<(bool, RewardGetData)> RequestMakeCustomEquip(int usePropId, int targetEquipId, int mainAttrId, List<int> subAttrIds);

	long GetUnselectSuitBox();

	Dictionary<int, List<RockDevelopEntryItemData>> GetDevelopEntryDic();

	Dictionary<int, int> GetOldEntryDic();

	WeaponData CopyWeapon(WeaponData oriData);

	Dictionary<int, ArmourData> CopyAllArmourAndSuitbox(Dictionary<int, ArmourData> allOriData);

	WeaponData CreateWeapon(PbFloorSettingEquipmentInfo equipmentInfo, int refine);

	Dictionary<int, ArmourData> CreateAllArmourAndSuitbox(List<PbFloorSettingEquipmentInfo> armourInfos, PbFloorSettingEquipmentInfo suitBoxInfo);

	UniTask<List<ArmourPresetSlotData>> GetPresetEquipments(int roleId);

	UniTask<ArmourPresetSlotData> SetPresetEquipment(int roleId, ArmourPresetSlotData slotData);

	UniTask<ArmourPresetSlotData> RenamePresetEquipment(int roleId, ArmourPresetSlotData slotData, string presetName);

	UniTask<ArmourPresetSlotData> DeletePresetEquipment(int roleId, int slotId);

	UniTask<ArmourPresetApplyResultData> ApplyPresetEquipment(int roleId, int slotId, bool forceApply = true);

	List<KnapsackPropData> GetKnapsackPropDataList();
}
