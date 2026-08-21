using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BuffLayer2View : HeroIndepentResView
{
	[SerializeField]
	private List<GameObject> LightShows;

	[SerializeField]
	private AutoDispose costAllEffect;

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
				LightShows[i].SetActive(value == i + 1);
			}
			if (buffCurLayer == LightShows.Count && value != buffCurLayer)
			{
				if (costAllEffect.gameObject.activeSelf)
				{
					costAllEffect.gameObject.SetActive(value: false);
				}
				costAllEffect.gameObject.SetActive(value: true);
			}
			buffCurLayer = value;
		}
	}

	public override void BindUI()
	{
		base.BindUI();
		if (isInit)
		{
			costAllEffect.AddDisposeAction(delegate(GameObject e)
			{
				e.SetActive(value: false);
			});
			costAllEffect.time = 1f;
			costAllEffect.gameObject.SetActive(value: false);
			BindingSet<BuffLayer2View, BattleUserViewModel> bindingSet = this.CreateBindingSet(viewModel);
			bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => (int)vm.HeroData.HeroIndepentType == 6);
			bindingSet.Bind().For((BuffLayer2View v) => v.BuffCurLayer).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][0].CurrentFill);
			bindingSet.Build();
		}
	}

	public override void InitData()
	{
		base.InitData();
		_heroIndepentType = HeroIndepentType.HeroUI6;
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
