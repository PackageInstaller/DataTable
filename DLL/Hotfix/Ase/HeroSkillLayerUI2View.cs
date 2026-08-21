using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class HeroSkillLayerUI2View : HeroIndepentResView
{
	public List<GameObject> HeroIndepentSkillLayerItems;

	[SerializeField]
	private AutoDispose costAllEffect;

	private int skillLayer;

	private bool skillLayerMax;

	public override void BindUI()
	{
		base.BindUI();
		if (isInit)
		{
			base.gameObject.SetActive(value: true);
			skillLayer = -1;
			skillLayerMax = false;
		}
	}

	private void LateUpdate()
	{
		if (viewModel != null && viewModel.HeroData != null && viewModel.HeroData.HeroInDependentDatas.TryGetValue("3", out var value) && skillLayer != value[0].CurrentFill)
		{
			skillLayer = value[0].CurrentFill;
			SkillLayerChange();
		}
	}

	private void SkillLayerChange()
	{
		int num = skillLayer / 5;
		bool flag = num == HeroIndepentSkillLayerItems.Count;
		if (skillLayerMax && !flag)
		{
			if (costAllEffect.gameObject.activeSelf)
			{
				costAllEffect.gameObject.SetActive(value: false);
			}
			costAllEffect.gameObject.SetActive(value: true);
		}
		for (int i = 0; i < HeroIndepentSkillLayerItems.Count; i++)
		{
			if (flag)
			{
				HeroIndepentSkillLayerItems[i].SetActive(num - 1 == i);
			}
			else
			{
				HeroIndepentSkillLayerItems[i].SetActive(num > i);
			}
		}
		skillLayerMax = flag;
	}

	public override void InitData()
	{
		base.InitData();
		_heroIndepentType = HeroIndepentType.HeroUI5;
		costAllEffect.AddDisposeAction(delegate(GameObject e)
		{
			e.SetActive(value: false);
		});
		costAllEffect.time = 1f;
	}

	public override void ClearBingUI(BattleUserViewModel viewModel)
	{
		base.ClearBingUI(viewModel);
	}
}
