#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class SkillSettingViewModel : OptionBase
{
	private InteractionRequest<string> optRequest = new InteractionRequest<string>();

	private List<CopyTeamItemViewModel> heroList;

	private string name;

	private Dictionary<int, List<HCTSkillItemViewModel>> allSkillList;

	private Dictionary<int, string> nameDic;

	private int curHeroId;

	public IInteractionRequest OptRequest => optRequest;

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public List<CopyTeamItemViewModel> TeamItemList => heroList;

	public SkillSettingViewModel()
	{
	}

	public SkillSettingViewModel(OptionBase parent, List<HeroSkinBind> hero)
	{
		base.parent = parent;
		heroList = new List<CopyTeamItemViewModel>();
		for (int num = hero.Count - 1; num >= 0; num--)
		{
			heroList.Add(new CopyTeamItemViewModel(this, hero[num]));
		}
		allSkillList = new Dictionary<int, List<HCTSkillItemViewModel>>();
		nameDic = new Dictionary<int, string>();
		if (heroList.Count > 0)
		{
			SetSkillDesc(heroList[heroList.Count - 1]);
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is CopyTeamItemViewModel { IsSelect: false } copyTeamItemViewModel)
		{
			SetSkillDesc(copyTeamItemViewModel);
		}
	}

	private void SetSkillDesc(CopyTeamItemViewModel heroItem)
	{
		for (int i = 0; i < heroList.Count; i++)
		{
			if (heroList[i].IsSelect && heroItem != heroList[i])
			{
				heroList[i].SetSelect(isSelect: false);
			}
		}
		heroItem.SetSelect(isSelect: true);
		curHeroId = heroItem.HeroId;
		if (!allSkillList.ContainsKey(heroItem.HeroId))
		{
			List<HCTSkillItemViewModel> list = new List<HCTSkillItemViewModel>();
			allSkillList.Add(heroItem.HeroId, list);
			HeroModel heroModel = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(heroItem.HeroId);
			if (heroModel == null || heroModel.Empty || heroModel.Id == 0)
			{
				CopyEnterInfoData copyEnterInfoData = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetCopyEnterInfoData();
				for (int j = 0; j < copyEnterInfoData.TeamMembers.Count; j++)
				{
					if (copyEnterInfoData.TeamMembers[j].HeroModel.Id == heroItem.HeroId)
					{
						heroModel = copyEnterInfoData.TeamMembers[j].HeroModel;
					}
				}
			}
			if (heroModel == null)
			{
				Log.Error($"找不到英雄数据HeroModel {heroItem.HeroId}");
			}
			else
			{
				nameDic.Add(heroItem.HeroId, heroModel.Name);
				foreach (HCTSkillData value in heroModel.HCTSkillDatas.Values)
				{
					if (HeroSkillTypeEnum.Roll == value.SkillTypeEnum || !value.IsOriginSkill)
					{
						continue;
					}
					list.Add(new HCTSkillItemViewModel(this, value));
					if (value.DeriveSkills == null)
					{
						continue;
					}
					for (int k = 0; k < value.DeriveSkills.Count; k++)
					{
						if (!value.SkillHideDesc(value.DeriveSkills[k]))
						{
							HCTSkillItemViewModel item = new HCTSkillItemViewModel(this, value.DeriveSkills[k]);
							list.Add(item);
						}
					}
				}
				DRHeroPassive dataRow = GameEntry.DataTable.GetDataRow<DRHeroPassive>(heroItem.HeroId);
				HCTSkillItemViewModel hCTSkillItemViewModel = new HCTSkillItemViewModel(this);
				hCTSkillItemViewModel.RefreshData(HeroSkillTypeEnum.Interaction1, dataRow.SkillPassiveName, "", dataRow.SkillPassive.Replace("\\n", "\n"), "1000@1");
				HCTSkillItemViewModel hCTSkillItemViewModel2 = new HCTSkillItemViewModel(this);
				hCTSkillItemViewModel2.RefreshData(HeroSkillTypeEnum.Interaction2, dataRow.TeamPassiveName, "", dataRow.TeamPassive.Replace("\\n", "\n"), "1000@2");
				hCTSkillItemViewModel.RefreshIconSkin(heroModel.SkinConfigId, heroModel.SkinSuffix, heroModel.Id);
				hCTSkillItemViewModel2.RefreshIconSkin(heroModel.SkinConfigId, heroModel.SkinSuffix, heroModel.Id);
				list.Add(hCTSkillItemViewModel);
				list.Add(hCTSkillItemViewModel2);
			}
		}
		Name = nameDic[heroItem.HeroId];
		optRequest.Raise("RefreshSkillList");
	}

	public List<HCTSkillItemViewModel> GetSkillList()
	{
		if (allSkillList.ContainsKey(curHeroId))
		{
			return allSkillList[curHeroId];
		}
		return new List<HCTSkillItemViewModel>();
	}
}
