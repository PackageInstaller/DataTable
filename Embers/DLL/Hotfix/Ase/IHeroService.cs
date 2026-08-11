using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public interface IHeroService
{
	int GetMaxFeelingLevel();

	IMessenger GetMessager();

	UniTask<bool> RequestServiceData();

	UniTask<bool> RequestHeroData();

	UniTask<bool> RequestHeroSkinData();

	Dictionary<int, HeroModel> GetAllHeroData();

	HeroModel GetHeroById(int heroId, bool emptyCreateNew = false, bool saveNew = true);

	PeripheryHeroData GetCreateHeroDataById(int heroId);

	HeroModel GetHeroCutById(int hero);

	bool HasHero(int heroId);

	void AddHeroData(int heroId, HeroModel vm, bool cover = false, bool requestSkin = true);

	UniTask<bool> AddHero(PbNormalRoleInfo data, bool addNewWeapon = false);

	bool RemoveHeroData(int heroId);

	Dictionary<long, int> GetHeroHeldEquip();

	void RefreshHeroHeldEquipment(HeroModel heroModel);

	int GetEquipmentOwnerById(long uid);

	UniTask<bool> HeroChangeEquip(int heroId, EquipmentDataBase itemData, long curEquipId = 0L, ArmourEnum armourEnum = ArmourEnum.Heart);

	UniTask<RequestResult> HeroUpgradeNew(List<PbItemBase> props, HeroModel heroModel);

	void HeroUpgradeByBattle(int heroId, int level, long exp);

	UniTask<RequestResult> LightUpHeroTalentPoint(int heroId, int skillId, int talentOrder);

	UniTask<RequestResult> UpgradeHeroTalentPoint(int heroId, int skillId, int talentOrder);

	UniTask<RequestResult> LightUpHeroDestiny(int heroId, int optType, int point = 0);

	void UpdateHeroEquip(long equipUid);

	UniTask<RequestResult> HeroBreakoutRequest(int uid);

	void ClearHeroAdditionalDatas();

	UniTask<bool> SendHeroGiftRequest(int heroId, int giftId, int count);

	UniTask<bool> SetHeroSkinChangeRequest(int heroSkinId);

	bool AddHeroSkin(int heroSkinConfigId);

	List<int> GetHeroSkins(int heroId);

	List<int> GetAllHeroSkins();

	bool GetHeroSkinOwnerShopSituation(int heroSkinId);

	void SetHeroSkin(int heroId, int skinId);

	List<Dictionary<string, object>> GetHeroDetails(List<int> heroIds);

	List<Dictionary<string, object>> GetHeroDetails(List<TeamMember> teamMembers);

	Dictionary<string, object> GetHeroDetailsNew(List<int> heroIds, Dictionary<string, object> baseDic = null);

	Dictionary<string, object> GetHeroDetailsNew(List<TeamMember> teamMembers, Dictionary<string, object> baseDic = null);

	Task CheckRefetch();

	UniTask<List<int>> GetSkinTimelineCollect();

	UniTask<bool> SetSkinTimelineCollect(List<int> savedList);

	UniTask<List<int>> GetSkinTimelineReadList();

	UniTask<bool> SetSkinTimelineRead(List<int> savedList);

	bool GetSkinTlUnlockState(DRHeroSkinTimeLine config, out string msg);

	List<int> GetSkinTlReadList();
}
