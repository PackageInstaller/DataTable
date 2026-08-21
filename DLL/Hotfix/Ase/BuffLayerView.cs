using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BuffLayerView : HeroIndepentResView
{
	public List<GameObject> LightShows;

	public List<GameObject> LightArrowShows;

	public List<GameObject> LightEffect;

	public List<AutoDispose> DarkEffect;

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
				LightShows[i].SetActive(value >= i + 1);
			}
			for (int j = 0; j < LightArrowShows.Count; j++)
			{
				LightArrowShows[j].SetActive(value / 3 > j);
			}
			for (int k = 0; k < LightEffect.Count; k++)
			{
				LightEffect[k].SetActive(value / 3 > k);
			}
			if (value < buffCurLayer)
			{
				if (buffCurLayer >= 3 && value < 3)
				{
					if (DarkEffect[0].gameObject.activeSelf)
					{
						DarkEffect[0].ResetTime(1f);
					}
					else
					{
						DarkEffect[0].gameObject.SetActive(value: true);
					}
				}
				if (buffCurLayer >= 6 && value <= 3)
				{
					if (DarkEffect[1].gameObject.activeSelf)
					{
						DarkEffect[1].ResetTime(1f);
					}
					else
					{
						DarkEffect[1].gameObject.SetActive(value: true);
					}
				}
			}
			buffCurLayer = value;
		}
	}

	public override void BindUI()
	{
		base.BindUI();
		if (!isInit)
		{
			return;
		}
		for (int i = 0; i < DarkEffect.Count; i++)
		{
			DarkEffect[i].AddDisposeAction(delegate(GameObject e)
			{
				e.SetActive(value: false);
			});
		}
		BindingSet<BuffLayerView, BattleUserViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => (int)vm.HeroData.HeroIndepentType == 3);
		bindingSet.Bind().For((BuffLayerView v) => v.BuffCurLayer).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][0].CurrentFill);
		bindingSet.Build();
	}

	public override void InitData()
	{
		base.InitData();
		_heroIndepentType = HeroIndepentType.HeroUI3;
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
