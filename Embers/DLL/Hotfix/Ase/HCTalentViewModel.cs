#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class HCTalentViewModel : OptionBase
{
	protected int allProgress;

	protected List<HCTPointItemViewModel> itemVMs;

	protected List<HCTSkillItemViewModel> skillList;

	protected HCTPointItemViewModel curSelect;

	protected HCTDescViewModel descVM;

	protected InteractionRequest onCancelRequest;

	protected InteractionRequest<HCTPointItemViewModel> playOpenEffectRequest;

	protected InteractionRequest showDescViewRequest;

	protected InteractionRequest bindPointRequest = new InteractionRequest();

	protected HeroModel heroModel;

	public bool preview;

	private bool isSelf;

	private HCTSkillItemViewModel curItem;

	public int AllProgress
	{
		get
		{
			return allProgress;
		}
		protected set
		{
			Set(ref allProgress, value, "AllProgress");
		}
	}

	public bool IsSelf
	{
		get
		{
			return isSelf;
		}
		set
		{
			Set(ref isSelf, value, "IsSelf");
		}
	}

	public List<HCTPointItemViewModel> ItemVMs => itemVMs;

	public List<HCTSkillItemViewModel> SkillList => skillList;

	public InteractionRequest ShowDescViewRequest => showDescViewRequest;

	public IInteractionRequest OnCancelRequest => onCancelRequest;

	public IInteractionRequest BindPointRequest => bindPointRequest;

	public IInteractionRequest PlayOpenEffectRequest => playOpenEffectRequest;

	public HCTDescViewModel DescVm => descVM;

	public HCTalentViewModel()
	{
	}

	public HCTalentViewModel(OptionBase parent, bool isSelf = true)
	{
		base.parent = parent;
		playOpenEffectRequest = new InteractionRequest<HCTPointItemViewModel>();
		showDescViewRequest = new InteractionRequest();
		onCancelRequest = new InteractionRequest();
		bindPointRequest = new InteractionRequest();
		skillList = new List<HCTSkillItemViewModel>();
		descVM = new HCTDescViewModel(this, isSelf);
		itemVMs = new List<HCTPointItemViewModel>();
		IsSelf = isSelf;
		Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().AddTalentTree(CheckAllPointState);
	}

	public virtual void RefreshData(HeroModel heroModel)
	{
		this.heroModel = heroModel;
		skillList.Clear();
		itemVMs.Clear();
		InitHeroSkill();
		CheckAllPointState();
		RefreshSkillItems();
		if (curSelect != null)
		{
			for (int i = 0; i < itemVMs.Count; i++)
			{
				if (itemVMs[i].SkillId == curSelect.SkillId && itemVMs[i].PointType == curSelect.PointType && itemVMs[i].Order == curSelect.Order)
				{
					OnSelectPointItem(itemVMs[i]);
				}
			}
		}
		bindPointRequest.Raise();
	}

	public void RefreshBigPointSkillIcons()
	{
		if (heroModel == null || itemVMs == null || itemVMs.Count <= 0)
		{
			return;
		}
		Dictionary<int, HCTSkillData> hCTSkillDatas = heroModel.HCTSkillDatas;
		if (hCTSkillDatas == null || hCTSkillDatas.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < itemVMs.Count; i++)
		{
			HCTPointItemViewModel hCTPointItemViewModel = itemVMs[i];
			if (hCTPointItemViewModel != null && hCTPointItemViewModel.PointType == HCSPointType.Big && hCTSkillDatas.TryGetValue(hCTPointItemViewModel.SkillId, out var value) && value != null)
			{
				hCTPointItemViewModel.RefreshIcon(value.Icon);
			}
		}
	}

	protected virtual void InitHeroSkill()
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
			_ = dataRows?.LongLength;
			HCTSkillItemViewModel hCTSkillItemViewModel = null;
			for (int num2 = 0; num2 < skillList.Count; num2++)
			{
				if (skillList[num2].Data.SkillId == talentData.SkillId)
				{
					hCTSkillItemViewModel = skillList[num2];
				}
			}
			if (hCTSkillItemViewModel != null && dataRow != null)
			{
				HCTPointItemViewModel hCTPointItemViewModel = new HCTPointItemViewModel(this, dataRow, hCTSkillItemViewModel.Data.Name, hCTSkillItemViewModel.Data.OriIcon, hCTSkillItemViewModel.Data.Icon, dataRows.Length, IsSelf);
				itemVMs.Add(hCTPointItemViewModel);
				num += talentData.BigLevel;
				descVM.OnSkillSelect(hCTPointItemViewModel, hCTSkillItemViewModel, GetSmallDesc(hCTSkillItemViewModel), heroModel);
			}
			DRHeroTalentSmall[] dataRows2 = GameEntry.DataTable.GetDataRows((DRHeroTalentSmall p) => p.SkillId == talentData.SkillId);
			if (dataRows2 != null && dataRows2.Length != 0)
			{
				for (int num3 = 0; num3 < dataRows2.Length; num3++)
				{
					HCTPointItemViewModel hCTPointItemViewModel2 = new HCTPointItemViewModel(this, dataRows2[num3]);
					hCTPointItemViewModel2.SetPointState((dataRows2[num3].Order <= talentData.SmallOrder) ? StateEnumConfig.Open : StateEnumConfig.Lock);
					itemVMs.Add(hCTPointItemViewModel2);
				}
			}
		}
		AllProgress = num;
		CheckAllPointState();
	}

	public List<string> GetSmallDesc(HCTSkillItemViewModel skill)
	{
		int skillId = skill.Data.SkillId;
		List<string> list = new List<string>();
		AddSmallDesc(skillId, list);
		if (list.Count == 0)
		{
			DRHeroSKillInfo dataRow = GameEntry.DataTable.GetDataRow((DRHeroSKillInfo p) => p.HeroId == heroModel.Id && p.HeroSkillTypeEnum == skill.Data.SkillTypeEnum && p.SkillId == skill.Data.SkillId);
			if (dataRow != null && dataRow.Id != skillId)
			{
				AddSmallDesc(dataRow.Id, list);
			}
		}
		return list;
	}

	private void AddSmallDesc(int skillId, List<string> descs)
	{
		for (int i = 0; i < itemVMs.Count; i++)
		{
			if (itemVMs[i].PointType != HCSPointType.Small || itemVMs[i].SkillId != skillId || itemVMs[i].PointState != StateEnumConfig.Open || itemVMs[i].TalentSmall.TinderType != 1)
			{
				continue;
			}
			int bv;
			for (bv = 0; bv < itemVMs[i].TalentSmall.BattleValue.Count; bv++)
			{
				DRCultivateSkillEffect dataRow = GameEntry.DataTable.GetDataRow((DRCultivateSkillEffect p) => p.Id == itemVMs[i].TalentSmall.BattleValue[bv]);
				if (dataRow != null && !string.IsNullOrEmpty(dataRow.SkillEffectDesc))
				{
					if (bv > 0)
					{
						descs.Add("\n" + dataRow.SkillEffectDesc);
					}
					else
					{
						descs.Add(dataRow.SkillEffectDesc);
					}
				}
				else
				{
					descs.Add("");
				}
			}
		}
	}

	public void RefreshSkillItems()
	{
		Dictionary<int, HCTSkillData> hCTSkillDatas = heroModel.HCTSkillDatas;
		if (hCTSkillDatas == null)
		{
			return;
		}
		for (int i = 0; i < skillList.Count; i++)
		{
			if (hCTSkillDatas.ContainsKey(skillList[i].Data.SkillId))
			{
				skillList[i].RefreshData(hCTSkillDatas[skillList[i].Data.SkillId]);
			}
			List<HCTSkillItemViewModel> skillDerives = skillList[i].GetSkillDerives();
			for (int j = 0; j < skillDerives.Count; j++)
			{
				if (hCTSkillDatas.ContainsKey(skillDerives[j].Data.SkillId))
				{
					skillDerives[j].RefreshData(hCTSkillDatas[skillDerives[j].Data.SkillId]);
				}
			}
		}
	}

	private void UpdatePointState(HCTPointItemViewModel pointItemVM, HCTalentData talentData)
	{
		if (talentData == null)
		{
			Log.Error("天赋数据异常");
			return;
		}
		if (pointItemVM.PointType == HCSPointType.Big)
		{
			DRHeroTalentBig dataRow = GameEntry.DataTable.GetDataRow((DRHeroTalentBig p) => p.SkillId == talentData.SkillId && p.Level == talentData.BigLevel);
			pointItemVM.UpgradeBig(dataRow);
		}
		else
		{
			pointItemVM.SetPointState(StateEnumConfig.Open);
		}
		CheckAllPointState();
	}

	public virtual void CheckAllPointState()
	{
		for (int i = 0; i < itemVMs.Count; i++)
		{
			if (itemVMs[i].PointState == StateEnumConfig.Open)
			{
				continue;
			}
			HCTPointItemViewModel pointVM = itemVMs[i];
			bool flag = true;
			StateEnumConfig stateEnumConfig = CheckMaterialEnough(pointVM.PropNeedIds, pointVM.PropNeedNums, pointVM.GoldCount);
			if (pointVM.PointType == HCSPointType.Big)
			{
				if (pointVM.TalentBig.Level == pointVM.TotalProgress)
				{
					pointVM.SetPointState(StateEnumConfig.Open);
					continue;
				}
				DRHeroTalentBig dataRow = GameEntry.DataTable.GetDataRow((DRHeroTalentBig p) => p.SkillId == pointVM.TalentBig.SkillId && p.Level == pointVM.TalentBig.Level + 1);
				if (dataRow == null)
				{
					pointVM.SetPointState(StateEnumConfig.Lock, "配置异常", stateEnumConfig == StateEnumConfig.OpenAndDisactiveLackGold);
					continue;
				}
				if (dataRow.Condition.Count != dataRow.ConditionNum.Count)
				{
					pointVM.SetPointState(StateEnumConfig.Lock, "配置异常", stateEnumConfig == StateEnumConfig.OpenAndDisactiveLackGold);
					continue;
				}
				for (int num = 0; num < dataRow.Condition.Count; num++)
				{
					if ((dataRow.Condition[num] != 1 || dataRow.ConditionNum[num] > heroModel.StarLevel) && (dataRow.Condition[num] != 2 || dataRow.ConditionNum[num] > allProgress))
					{
						flag = false;
						if (dataRow.Condition[num] == 1)
						{
							pointVM.SetPointState(StateEnumConfig.Lock, $"需角色星级达到{dataRow.ConditionNum[num]}级", stateEnumConfig == StateEnumConfig.OpenAndDisactiveLackGold);
						}
						else if (dataRow.Condition[num] == 2)
						{
							pointVM.SetPointState(StateEnumConfig.Lock, $"需燃点总等级达到{dataRow.ConditionNum[num]}级", stateEnumConfig == StateEnumConfig.OpenAndDisactiveLackGold);
						}
					}
				}
			}
			else
			{
				Dictionary<int, HCTalentData> talentDatas = heroModel.TalentDatas;
				if (!talentDatas.ContainsKey(pointVM.TalentSmall.SkillId) || pointVM.TalentSmall.Condition.Count != pointVM.TalentSmall.ConditionNum.Count)
				{
					continue;
				}
				int smallOrder = talentDatas[pointVM.TalentSmall.SkillId].SmallOrder;
				for (int num2 = 0; num2 < pointVM.TalentSmall.Condition.Count; num2++)
				{
					if (pointVM.TalentSmall.Condition[num2] == 1)
					{
						for (int num3 = 0; num3 < itemVMs.Count; num3++)
						{
							if (itemVMs[num3].PointType == HCSPointType.Big && itemVMs[num3].TalentBig.SkillId == pointVM.TalentSmall.SkillId)
							{
								if (pointVM.TalentSmall.ConditionNum[num2] <= itemVMs[num3].TalentBig.Level)
								{
									break;
								}
								pointVM.SetPointState(StateEnumConfig.Lock, $"需燃点·({itemVMs[num3].SkillName})等级达到{pointVM.TalentSmall.ConditionNum[num2]}级", stateEnumConfig == StateEnumConfig.OpenAndDisactiveLackGold);
								flag = false;
							}
						}
					}
					else if (pointVM.TalentSmall.Condition[num2] == 2 && pointVM.TalentSmall.Order > smallOrder + 1)
					{
						pointVM.SetPointState(StateEnumConfig.Lock, "需先点亮前置火种", stateEnumConfig == StateEnumConfig.OpenAndDisactiveLackGold);
						flag = false;
					}
				}
			}
			if (flag)
			{
				if (stateEnumConfig == StateEnumConfig.OpenAndDisactiveLackGold)
				{
					pointVM.SetPointState(StateEnumConfig.OpenAndDisactive, "", isLackGold: true);
				}
				else
				{
					pointVM.SetPointState(stateEnumConfig);
				}
			}
		}
		CheckRed();
	}

	public virtual void SetOri(bool isOri)
	{
	}

	protected virtual void CheckRed()
	{
		bool flag = false;
		for (int i = 0; i < itemVMs.Count; i++)
		{
			if (itemVMs[i].PointState == StateEnumConfig.Active)
			{
				flag = true;
			}
		}
		RedPointService redPointService = (RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>();
		if (flag)
		{
			if (!redPointService.HeroTalent.Contains(heroModel.Id))
			{
				redPointService.HeroTalent.Add(heroModel.Id);
			}
		}
		else if (redPointService.HeroTalent.Contains(heroModel.Id))
		{
			redPointService.HeroTalent.Remove(heroModel.Id);
		}
	}

	private StateEnumConfig CheckMaterialEnough(List<int> needIds, List<int> needNums, int goldNeed)
	{
		try
		{
			if (needIds != null && needNums != null && needIds.Count != needNums.Count)
			{
				_ = heroModel;
				return StateEnumConfig.OpenAndDisactive;
			}
			long moneyCount = MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Coin);
			if (goldNeed > moneyCount)
			{
				return StateEnumConfig.OpenAndDisactiveLackGold;
			}
			for (int i = 0; i < needIds.Count; i++)
			{
				KnapsackPropData prop = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(needIds[i]);
				if (prop == null || prop.Amount < needNums[i])
				{
					return StateEnumConfig.OpenAndDisactive;
				}
			}
		}
		catch (Exception)
		{
		}
		return StateEnumConfig.Active;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is HCTPointItemViewModel pointItem)
		{
			OnSelectPointItem(pointItem);
		}
		else if (obj is OptionArg optionArg)
		{
			if ("OnTalentActive".Equals(optionArg.OptionName))
			{
				OnTalentActive();
			}
		}
		else if (obj is CastingMaterialItemData castingMaterialItemData)
		{
			parent?.ItemOnClick(new KnapsackItemViewModel(this, castingMaterialItemData.PropData));
		}
		else
		{
			parent?.ItemOnClick(obj);
		}
	}

	private async void OnTalentActive()
	{
		Loading loading = await Loading.Show();
		if (curSelect == null || curSelect.PointState != StateEnumConfig.Active)
		{
			return;
		}
		HCTSkillItemViewModel skillItemViewModel = null;
		for (int i = 0; i < skillList.Count; i++)
		{
			if (skillList[i].Data.SkillId == curSelect.SkillId)
			{
				skillItemViewModel = skillList[i];
			}
		}
		if (curSelect.PointType == HCSPointType.Small)
		{
			RequestResult requestResult = await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().LightUpHeroTalentPoint(heroModel.Id, curSelect.SkillId, curSelect.Order);
			loading.Dispose();
			if (requestResult.success)
			{
				Toast.ShowInfo("点亮成功");
				UpdatePointState(curSelect, heroModel.GetTalentDataBySkillId(curSelect.SkillId));
				skillItemViewModel.RefreshData(skillItemViewModel.Data);
				HCTPointItemViewModel context = curSelect;
				playOpenEffectRequest.Raise(context);
				descVM.OnSkillSelect(curSelect, skillItemViewModel, GetSmallDesc(skillItemViewModel), heroModel);
				descVM.RefreshSkillDesc();
				Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().GetMessager().Publish(new RedPointMessage(this, RedPointMessageEnum.HeroTalentNewLayer));
			}
			else
			{
				parent.ItemOnClick(requestResult.obj);
			}
			return;
		}
		RequestResult requestResult2 = await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().UpgradeHeroTalentPoint(heroModel.Id, curSelect.SkillId, curSelect.CurProgress + 1);
		loading.Dispose();
		if (requestResult2.success)
		{
			Toast.ShowInfo("升级成功");
			UpdatePointState(curSelect, heroModel.GetTalentDataBySkillId(curSelect.SkillId));
			skillItemViewModel.RefreshData(skillItemViewModel.Data);
			descVM.OnSkillSelect(curSelect, skillItemViewModel, GetSmallDesc(skillItemViewModel), heroModel);
			GetAllBigProgress();
			HCTPointItemViewModel context2 = curSelect;
			descVM.RefreshSkillDesc();
			if (curSelect.CurProgress == curSelect.TotalProgress)
			{
				CancelSelectSkill();
			}
			playOpenEffectRequest.Raise(context2);
			Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().GetMessager().Publish(new RedPointMessage(this, RedPointMessageEnum.HeroTalentNewLayer));
		}
		else
		{
			parent.ItemOnClick(requestResult2.obj);
		}
	}

	public override void RefreshWhenBack(ViewBackArg arg)
	{
		CheckAllPointState();
		if (curSelect != null)
		{
			descVM.OnRefreshMaterials(curSelect);
		}
	}

	protected virtual void OnSelectPointItem(HCTPointItemViewModel pointItem)
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
				descVM.IsVisible = true;
				break;
			}
		}
	}

	private void GetAllBigProgress()
	{
		int num = 0;
		for (int i = 0; i < itemVMs.Count; i++)
		{
			if (itemVMs[i].PointType == HCSPointType.Big)
			{
				num += itemVMs[i].CurProgress;
			}
		}
		AllProgress = num;
	}

	public HCTPointItemViewModel GetPointVM(HCSPointType pointType, int order)
	{
		for (int i = 0; i < itemVMs.Count; i++)
		{
			if (itemVMs[i].PointType == pointType && itemVMs[i].Order == order)
			{
				return itemVMs[i];
			}
		}
		return null;
	}

	public virtual void CancelSelectSkill()
	{
		if (curItem != null)
		{
			curItem.SetSelect(isSelect: false);
			curItem = null;
		}
		if (curSelect != null)
		{
			curSelect.SetSelect(isSelect: false);
			curSelect = null;
		}
		onCancelRequest.Raise();
	}
}
