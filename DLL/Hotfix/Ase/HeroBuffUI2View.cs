using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroBuffUI2View : HeroIndepentResView
{
	[SerializeField]
	private List<Image> bingBuff1UIs;

	[SerializeField]
	private List<Image> bingBuff2UIs;

	private int buff1CurLayer;

	private int buff2CurLayer;

	public int Buff1CurLayer
	{
		get
		{
			return buff1CurLayer;
		}
		set
		{
			buff1CurLayer = value;
			for (int i = 0; i < bingBuff1UIs.Count; i++)
			{
				bingBuff1UIs[i].enabled = value > i;
			}
		}
	}

	public int Buff2CurLayer
	{
		get
		{
			return buff2CurLayer;
		}
		set
		{
			buff2CurLayer = value;
			for (int i = 0; i < bingBuff2UIs.Count; i++)
			{
				bingBuff2UIs[i].enabled = value > i;
			}
		}
	}

	public override void BindUI()
	{
		base.BindUI();
		if (isInit)
		{
			BindingSet<HeroBuffUI2View, BattleUserViewModel> bindingSet = this.CreateBindingSet(viewModel);
			bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => (int)vm.HeroData.HeroIndepentType == 4);
			bindingSet.Bind().For((HeroBuffUI2View v) => v.Buff1CurLayer).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][0].CurrentFill);
			bindingSet.Bind().For((HeroBuffUI2View v) => v.Buff2CurLayer).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][1].CurrentFill);
			bindingSet.Build();
		}
	}

	public override void InitData()
	{
		base.InitData();
		_heroIndepentType = HeroIndepentType.HeroUI4;
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
