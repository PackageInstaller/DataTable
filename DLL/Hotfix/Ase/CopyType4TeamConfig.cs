using System.Collections.Generic;

namespace Ase;

public class CopyType4TeamConfig
{
	private int copyId;

	private List<int> heroList;

	private Dictionary<int, HeroModel> heroCopyList;

	private List<int> bpList;

	private List<PbFloorRoleSettingInfo> roleSettingInfos;

	public List<int> HeroList => GetHeroList();

	public List<int> BpList => bpList;

	public int CopyId => copyId;

	public CopyType4TeamConfig(int copyId, List<int> heroList, List<int> bpList)
	{
		this.copyId = copyId;
		this.heroList = heroList;
		this.bpList = bpList;
		SaveHeroCut();
	}

	public CopyType4TeamConfig(int copyId, List<PbFloorRoleSettingInfo> heroListOri, List<int> bpList)
	{
		heroList = null;
		heroCopyList = null;
		this.copyId = copyId;
		roleSettingInfos = heroListOri;
		this.bpList = bpList;
	}

	public void LoadHeroData()
	{
		if (roleSettingInfos != null)
		{
			List<int> list = new List<int>();
			Dictionary<int, HeroModel> dictionary = new Dictionary<int, HeroModel>();
			for (int i = 0; i < roleSettingInfos.Count; i++)
			{
				int roleId = roleSettingInfos[i].RoleId;
				list.Add(roleId);
				HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(roleId);
				WeaponData weaponData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CreateWeapon(roleSettingInfos[i].WeaponInfo, roleSettingInfos[i].WeaponRefineLevel);
				Dictionary<int, ArmourData> armourDatas = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CreateAllArmourAndSuitbox(roleSettingInfos[i].ArmourInfos, roleSettingInfos[i].SuitboxInfo);
				dictionary.Add(roleId, HeroModel.CreateCopy(heroById, weaponData, armourDatas));
			}
			AddHeroCuts(dictionary);
			heroList = list;
			roleSettingInfos = null;
		}
	}

	public void SaveHeroCut()
	{
		heroCopyList = new Dictionary<int, HeroModel>();
		for (int i = 0; i < heroList.Count; i++)
		{
			if (heroList[i] != 0)
			{
				HeroModel heroCutById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroCutById(heroList[i]);
				heroCopyList.Add(heroList[i], heroCutById);
			}
		}
	}

	public void SaveCarringBPs(int bpId1, int bpId2)
	{
		if (bpList == null)
		{
			bpList = new List<int>();
		}
		else
		{
			bpList.Clear();
		}
		bpList.Add(bpId1);
		bpList.Add(bpId2);
	}

	public void Clear()
	{
		heroList = null;
		heroCopyList = null;
		bpList = null;
	}

	private List<int> GetHeroList()
	{
		if (heroList == null && roleSettingInfos != null)
		{
			LoadHeroData();
		}
		return heroList;
	}

	public HeroModel GetHeroById(int heroId)
	{
		if (heroCopyList == null && roleSettingInfos != null)
		{
			LoadHeroData();
		}
		if (heroCopyList.ContainsKey(heroId))
		{
			return heroCopyList[heroId];
		}
		return null;
	}

	public HeroModel GetHeroListIndex(int index)
	{
		if (heroList == null && roleSettingInfos != null)
		{
			LoadHeroData();
		}
		HeroModel result = null;
		if (heroList.Count > index)
		{
			int heroId = heroList[index];
			result = GetHeroById(heroId);
		}
		return result;
	}

	private void AddHeroCuts(Dictionary<int, HeroModel> heroModels)
	{
		heroCopyList = heroModels;
	}

	public CopyBPCarrying GetCopyBPCarrying()
	{
		CopyBPCarrying copyBPCarrying = new CopyBPCarrying();
		copyBPCarrying.copyId = copyId;
		if (bpList != null)
		{
			copyBPCarrying.bpId1 = ((bpList.Count > 0) ? bpList[0] : 0);
			copyBPCarrying.bpId2 = ((bpList.Count > 1) ? bpList[1] : 0);
		}
		return copyBPCarrying;
	}
}
