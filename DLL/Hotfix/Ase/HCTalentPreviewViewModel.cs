#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class HCTalentPreviewViewModel : HCTalentViewModel
{
	protected InteractionRequest<string> optRequest = new InteractionRequest<string>();

	public bool isOri = true;

	public IInteractionRequest OptRequest => optRequest;

	public HCTalentPreviewViewModel(OptionBase parent)
	{
		base.parent = parent;
		playOpenEffectRequest = new InteractionRequest<HCTPointItemViewModel>();
		showDescViewRequest = new InteractionRequest();
		onCancelRequest = new InteractionRequest();
		skillList = new List<HCTSkillItemViewModel>();
		descVM = new HCTDescViewModel(this);
		itemVMs = new List<HCTPointItemViewModel>();
	}

	public HCTalentPreviewViewModel()
	{
	}

	public override void RefreshData(HeroModel heroModel)
	{
		HCTPointItemViewModel hCTPointItemViewModel = curSelect;
		base.heroModel = heroModel;
		skillList.Clear();
		itemVMs.Clear();
		InitHeroSkill();
		optRequest.Raise("RefreshBind");
		if (hCTPointItemViewModel == null)
		{
			return;
		}
		for (int i = 0; i < itemVMs.Count; i++)
		{
			if (hCTPointItemViewModel.SkillId == itemVMs[i].SkillId && hCTPointItemViewModel.PointType == itemVMs[i].PointType && hCTPointItemViewModel.Order == itemVMs[i].Order)
			{
				OnSelectPointItem(itemVMs[i]);
			}
		}
	}

	public override void CheckAllPointState()
	{
		for (int i = 0; i < itemVMs.Count; i++)
		{
			HCTPointItemViewModel hCTPointItemViewModel = itemVMs[i];
			if (isOri)
			{
				if (hCTPointItemViewModel.PointType == HCSPointType.Big)
				{
					hCTPointItemViewModel.SetPointState(StateEnumConfig.Open);
				}
				else
				{
					hCTPointItemViewModel.SetPointState(StateEnumConfig.Lock);
				}
			}
			else
			{
				hCTPointItemViewModel.SetPointState(StateEnumConfig.Open);
			}
		}
	}

	protected override void InitHeroSkill()
	{
		foreach (HCTSkillData value in heroModel.HCTSkillDatas.Values)
		{
			if (HeroSkillTypeEnum.Roll != value.SkillTypeEnum && value.IsOriginSkill)
			{
				skillList.Add(new HCTSkillItemViewModel(this, value));
			}
		}
		int num = 0;
		foreach (HCTalentData talentData in heroModel.TalentDatas.Values)
		{
			DRHeroTalentBig dataRow = GameEntry.DataTable.GetDataRow((DRHeroTalentBig p) => p.SkillId == talentData.SkillId && p.Level == talentData.BigLevel);
			if (dataRow == null)
			{
				Log.Error($"英雄【{heroModel.Id}】找不到燃点数据SkillId【{talentData.SkillId}】,Level【{talentData.BigLevel}】");
			}
			DRHeroTalentBig[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroTalentBig p) => p.SkillId == talentData.SkillId);
			if (dataRows == null || dataRows.Length == 0)
			{
				Log.Error($"英雄【{heroModel.Id}】找不到燃点数据SkillId【{talentData.SkillId}】,Level【{talentData.BigLevel}】");
			}
			HCTSkillItemViewModel hCTSkillItemViewModel = null;
			for (int num2 = 0; num2 < skillList.Count; num2++)
			{
				if (skillList[num2].Data.SkillId == talentData.SkillId)
				{
					hCTSkillItemViewModel = skillList[num2];
				}
			}
			if (hCTSkillItemViewModel == null)
			{
				Log.Error($"英雄【{heroModel.Id}】找不到燃点对应的技能UI配置，SkillId【{talentData.SkillId}】");
			}
			if (hCTSkillItemViewModel != null && dataRow != null)
			{
				HCTPointItemViewModel hCTPointItemViewModel = new HCTPointItemViewModel(this, dataRow, hCTSkillItemViewModel.Data.Name, hCTSkillItemViewModel.Data.OriIcon, hCTSkillItemViewModel.Data.Icon, dataRows.Length);
				itemVMs.Add(hCTPointItemViewModel);
				num += talentData.BigLevel;
				descVM.OnSkillSelect(hCTPointItemViewModel, hCTSkillItemViewModel, GetSmallDesc(hCTSkillItemViewModel), heroModel);
			}
			DRHeroTalentSmall[] dataRows2 = GameEntry.DataTable.GetDataRows((DRHeroTalentSmall p) => p.SkillId == talentData.SkillId);
			if (dataRows2 == null || dataRows2.Length == 0)
			{
				Log.Error($"英雄【{heroModel.Id}】找不到火种对应的技能UI配置，SkillId【{talentData.SkillId}】");
				continue;
			}
			for (int num3 = 0; num3 < dataRows2.Length; num3++)
			{
				HCTPointItemViewModel hCTPointItemViewModel2 = new HCTPointItemViewModel(this, dataRows2[num3]);
				hCTPointItemViewModel2.SetPointState((dataRows2[num3].Order <= talentData.SmallOrder) ? StateEnumConfig.Open : StateEnumConfig.Lock);
				itemVMs.Add(hCTPointItemViewModel2);
			}
		}
		base.AllProgress = num;
		CheckAllPointState();
	}

	public override void SetOri(bool isOri)
	{
		this.isOri = isOri;
	}

	public override void CancelSelectSkill()
	{
		base.CancelSelectSkill();
		parent?.ItemOnClick("ShowPreviewConfig");
	}

	protected override void OnSelectPointItem(HCTPointItemViewModel pointItem)
	{
		for (int i = 0; i < skillList.Count; i++)
		{
			if (skillList[i].Data.SkillId == pointItem.SkillId)
			{
				if (curSelect != null)
				{
					curSelect.SetSelect(isSelect: false);
				}
				curSelect = pointItem;
				descVM.OnSkillSelect(pointItem, skillList[i], GetSmallDesc(skillList[i]), heroModel);
				pointItem.SetSelect(isSelect: true);
				descVM.RefreshSkillDesc();
				showDescViewRequest.Raise();
				parent?.ItemOnClick("HidePreviewConfig");
				descVM.IsVisible = true;
				break;
			}
		}
	}
}
