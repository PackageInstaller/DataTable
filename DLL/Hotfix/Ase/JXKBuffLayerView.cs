using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class JXKBuffLayerView : HeroIndepentResView
{
	[SerializeField]
	private List<GameObject> topPointObjs;

	[SerializeField]
	private List<GameObject> bottomAddEffects;

	[SerializeField]
	private List<AutoDispose> bottomRemoveEffects;

	[SerializeField]
	private List<GameObject> bottomPointObjects;

	[SerializeField]
	private GameObject bottomHalfEffect;

	[SerializeField]
	private GameObject bottomFullEffect;

	private int bottomAddEffectLayer;

	private int bottomRemoveEffectLayer;

	private int topBuffLayer;

	public int BottomAddEffectLayer
	{
		get
		{
			return bottomAddEffectLayer;
		}
		set
		{
			if (value != bottomAddEffectLayer)
			{
				for (int i = 0; i < bottomPointObjects.Count; i++)
				{
					bottomAddEffects[i].SetActive(value > i);
					bottomPointObjects[i].SetActive(value > i);
				}
				bottomHalfEffect.SetActive(value >= 3 && value != 6);
				bottomFullEffect.SetActive(value == 6);
				bottomAddEffectLayer = value;
			}
		}
	}

	public int BottomRemoveEffectLayer
	{
		get
		{
			return bottomRemoveEffectLayer;
		}
		set
		{
			if (value == bottomRemoveEffectLayer || value != 1)
			{
				return;
			}
			for (int i = 0; i < bottomPointObjects.Count; i++)
			{
				if (bottomRemoveEffects[i].gameObject.activeSelf)
				{
					bottomRemoveEffects[i].ResetTime(1f);
				}
				else
				{
					bottomRemoveEffects[i].gameObject.SetActive(value: true);
				}
				bottomPointObjects[i].SetActive(value: false);
			}
			bottomRemoveEffectLayer = value;
		}
	}

	public int TopBuffLayer
	{
		get
		{
			return topBuffLayer;
		}
		set
		{
			if (value != topBuffLayer)
			{
				for (int i = 0; i < topPointObjs.Count; i++)
				{
					topPointObjs[i].SetActive(value - 1 == i);
				}
				topBuffLayer = value;
			}
		}
	}

	public override void BindUI()
	{
		base.BindUI();
		if (!isInit)
		{
			return;
		}
		for (int i = 0; i < bottomRemoveEffects.Count; i++)
		{
			bottomRemoveEffects[i].AddDisposeAction(delegate(GameObject e)
			{
				e.SetActive(value: false);
			});
		}
		BindingSet<JXKBuffLayerView, BattleUserViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => (int)vm.HeroData.HeroIndepentType == 7);
		bindingSet.Bind().For((JXKBuffLayerView v) => v.BottomAddEffectLayer).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][0].CurrentFill);
		bindingSet.Bind().For((JXKBuffLayerView v) => v.BottomRemoveEffectLayer).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][1].CurrentFill);
		bindingSet.Bind().For((JXKBuffLayerView v) => v.TopBuffLayer).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][2].CurrentFill);
		bindingSet.Build();
	}

	public override void InitData()
	{
		base.InitData();
		_heroIndepentType = HeroIndepentType.HeroUI7;
	}

	public override void ClearBingUI(BattleUserViewModel viewModel)
	{
		base.ClearBingUI(viewModel);
		if (!isInit)
		{
			this.ClearAllBindings();
		}
		TopBuffLayer = 0;
		BottomRemoveEffectLayer = 0;
		BottomAddEffectLayer = 0;
	}
}
