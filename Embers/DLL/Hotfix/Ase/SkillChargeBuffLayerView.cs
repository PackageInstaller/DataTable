using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class SkillChargeBuffLayerView : HeroIndepentResView
{
	public List<SkillChargeBuffLayerItem> SkillChargeBuffLayerItems;

	private int buleCount;

	private float redCount;

	private float fillAmount;

	private int maxFill;

	public int BuleCount
	{
		get
		{
			return buleCount;
		}
		set
		{
			UpdateBuleRedShow();
		}
	}

	public float RedCount
	{
		get
		{
			return redCount;
		}
		set
		{
			UpdateBuleRedShow();
		}
	}

	public float FillAmount
	{
		get
		{
			return fillAmount;
		}
		set
		{
			UpdateFillAmount();
		}
	}

	public int MaxFill
	{
		get
		{
			return maxFill;
		}
		set
		{
			for (int i = 0; i < SkillChargeBuffLayerItems.Count; i++)
			{
				SkillChargeBuffLayerItem skillChargeBuffLayerItem = SkillChargeBuffLayerItems[i];
				skillChargeBuffLayerItem.UnLock.SetActive(value > i);
				skillChargeBuffLayerItem.Lock.SetActive(value <= i);
			}
		}
	}

	public override void BindUI()
	{
		base.BindUI();
		if (isInit)
		{
			BindingSet<SkillChargeBuffLayerView, BattleUserViewModel> bindingSet = this.CreateBindingSet(viewModel);
			bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => (int)vm.HeroData.HeroIndepentType == 2);
			bindingSet.Bind().For((SkillChargeBuffLayerView v) => v.MaxFill).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["2"][0].MaxFill);
			bindingSet.Bind().For((SkillChargeBuffLayerView v) => v.BuleCount).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][0].CurrentFill);
			bindingSet.Bind().For((SkillChargeBuffLayerView v) => v.BuleCount).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][0].MaxFill);
			bindingSet.Bind().For((SkillChargeBuffLayerView v) => v.RedCount).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["2"][0].CurrentFill);
			bindingSet.Bind().For((SkillChargeBuffLayerView v) => v.FillAmount).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["2"][0].ResFillAmount);
			bindingSet.Build();
		}
	}

	public override void InitData()
	{
		base.InitData();
		_heroIndepentType = HeroIndepentType.HeroUI2;
	}

	private void UpdateBuleRedShow()
	{
		for (int i = 0; i < SkillChargeBuffLayerItems.Count; i++)
		{
			if (viewModel.HeroData.HeroInDependentDatas["1"][0].CurrentFill > 0 && viewModel.HeroData.HeroInDependentDatas["2"][0].CurrentFill < viewModel.HeroData.HeroInDependentDatas["2"][0].MaxFill)
			{
				if (i < viewModel.HeroData.HeroInDependentDatas["2"][0].MaxFill - viewModel.HeroData.HeroInDependentDatas["2"][0].CurrentFill && viewModel.HeroData.HeroInDependentDatas["1"][0].CurrentFill > i)
				{
					SkillChargeBuffLayerItems[i].Bule.SetActive(value: true);
				}
				else
				{
					SkillChargeBuffLayerItems[i].Bule.SetActive(value: false);
				}
			}
			else
			{
				SkillChargeBuffLayerItems[i].Bule.SetActive(value: false);
			}
			if (viewModel.HeroData.HeroInDependentDatas["2"][0].CurrentFill > 0)
			{
				int currentFill = viewModel.HeroData.HeroInDependentDatas["2"][0].CurrentFill;
				int num = viewModel.HeroData.HeroInDependentDatas["2"][0].MaxFill - currentFill;
				num = ((num >= 0) ? num : 0);
				int num2 = 0;
				num2 = ((viewModel.HeroData.HeroInDependentDatas["1"][0].CurrentFill <= num) ? viewModel.HeroData.HeroInDependentDatas["1"][0].CurrentFill : num);
				if (i >= num2 && i < currentFill + num2)
				{
					SkillChargeBuffLayerItems[i].ImageFill.fillAmount = 0f;
					SkillChargeBuffLayerItems[i].Red.SetActive(value: true);
					SkillChargeBuffLayerItems[i].Full.SetActive(value: true);
				}
				else
				{
					SkillChargeBuffLayerItems[i].Full.SetActive(value: false);
					SkillChargeBuffLayerItems[i].Red.SetActive(value: false);
				}
			}
			else
			{
				SkillChargeBuffLayerItems[i].Red.SetActive(value: false);
				SkillChargeBuffLayerItems[i].Full.SetActive(value: false);
			}
		}
	}

	public void UpdateFillAmount()
	{
		bool flag = false;
		for (int i = 0; i < SkillChargeBuffLayerItems.Count; i++)
		{
			if (!SkillChargeBuffLayerItems[i].Red.activeSelf)
			{
				if (!flag)
				{
					SkillChargeBuffLayerItems[i].ImageFill.fillAmount = 1f - viewModel.HeroData.HeroInDependentDatas["2"][0].ResFillAmount;
					flag = true;
				}
				else
				{
					SkillChargeBuffLayerItems[i].ImageFill.fillAmount = 0f;
				}
			}
		}
	}

	public override void ClearBingUI(BattleUserViewModel viewModel)
	{
		base.ClearBingUI(viewModel);
		if (!isInit)
		{
			this.ClearAllBindings();
		}
	}
}
