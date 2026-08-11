using System;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class LSLBuffLayerView : HeroIndepentResView
{
	[SerializeField]
	private TextMeshProUGUI buffLayerShow;

	[SerializeField]
	private AutoDispose buffLayerAddEffect;

	[SerializeField]
	private GameObject skill3Buff0Show;

	[SerializeField]
	private GameObject skill3Buff1Show;

	[SerializeField]
	private GameObject skill3Buff2Show;

	[SerializeField]
	private GameObject skill3Buff3Show;

	private int buffLayerNumber;

	public int BuffLayerNumber
	{
		get
		{
			return buffLayerNumber;
		}
		set
		{
			if (value > buffLayerNumber)
			{
				if (buffLayerAddEffect.gameObject.activeSelf)
				{
					buffLayerAddEffect.gameObject.SetActive(value: false);
				}
				buffLayerAddEffect.gameObject.SetActive(value: true);
			}
			((TMP_Text)buffLayerShow).text = value.ToString();
		}
	}

	public override void BindUI()
	{
		base.BindUI();
		if (isInit)
		{
			buffLayerAddEffect.AddDisposeAction((Action)delegate
			{
				buffLayerAddEffect.gameObject.SetActive(value: false);
			});
			BindingSet<LSLBuffLayerView, BattleUserViewModel> bindingSet = this.CreateBindingSet(viewModel);
			bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => (int)vm.HeroData.HeroIndepentType == 8);
			bindingSet.Bind(this).For((LSLBuffLayerView v) => v.BuffLayerNumber).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][0].CurrentFill);
			bindingSet.Bind(skill3Buff0Show).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][1].CurrentFill > 0);
			bindingSet.Bind(skill3Buff1Show).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][2].CurrentFill > 0);
			bindingSet.Bind(skill3Buff2Show).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][3].CurrentFill > 0);
			bindingSet.Bind(skill3Buff3Show).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][4].CurrentFill > 0);
			bindingSet.Build();
		}
	}

	public override void InitData()
	{
		base.InitData();
		_heroIndepentType = HeroIndepentType.HeroUI8;
	}

	public override void ClearBingUI(BattleUserViewModel viewModel)
	{
		base.ClearBingUI(viewModel);
		if (!isInit)
		{
			this.ClearAllBindings();
		}
		buffLayerNumber = 0;
	}
}
