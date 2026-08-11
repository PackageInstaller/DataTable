using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class SkillQMMBuffLayerView : HeroIndepentResView
{
	[SerializeField]
	private List<GameObject> LightShows;

	[SerializeField]
	private GameObject fullGameObject;

	private int buffCurLayer;

	public int BuffCurLayer
	{
		get
		{
			return buffCurLayer;
		}
		set
		{
			for (int i = 0; i < LightShows.Count; i++)
			{
				LightShows[i].SetActive(value > i);
			}
			fullGameObject.SetActive(value == LightShows.Count);
			buffCurLayer = value;
		}
	}

	public override void BindUI()
	{
		base.BindUI();
		if (isInit)
		{
			fullGameObject.SetActive(value: false);
			BindingSet<SkillQMMBuffLayerView, BattleUserViewModel> bindingSet = this.CreateBindingSet(viewModel);
			bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => (int)vm.HeroData.HeroIndepentType == 10);
			bindingSet.Bind().For((SkillQMMBuffLayerView v) => v.BuffCurLayer).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][0].CurrentFill);
			bindingSet.Build();
			BuffCurLayer = 0;
		}
	}

	public override void InitData()
	{
		base.InitData();
		_heroIndepentType = HeroIndepentType.HeroUI10;
	}

	public override void ClearBingUI(BattleUserViewModel viewModel)
	{
		BuffCurLayer = 0;
		base.ClearBingUI(viewModel);
		if (!isInit)
		{
			this.ClearAllBindings();
		}
	}
}
