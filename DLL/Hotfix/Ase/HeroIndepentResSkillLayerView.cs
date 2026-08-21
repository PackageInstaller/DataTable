using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class HeroIndepentResSkillLayerView : HeroIndepentResView
{
	public List<HeroIndepentSkillLayerItem> HeroIndepentSkillLayerItems;

	public GameObject FillFour;

	private float skillLayer;

	private float skillMaxLayer;

	public float SkillLayer
	{
		get
		{
			return skillLayer;
		}
		set
		{
			SkillLayerChange();
			skillLayer = value;
		}
	}

	public float SkillMaxLayer
	{
		get
		{
			return skillMaxLayer;
		}
		set
		{
			SkillMaxLayerChange();
			skillMaxLayer = value;
		}
	}

	private void SkillLayerChange()
	{
		for (int i = 0; i < HeroIndepentSkillLayerItems.Count; i++)
		{
			HeroIndepentSkillLayerItems[i].Full.SetActive((float)viewModel.HeroData.HeroInDependentDatas["3"][0].CurrentFill * 1f / 10f - 1f >= (float)i);
			HeroIndepentSkillLayerItems[i].ImageFill.fillAmount = (((float)viewModel.HeroData.HeroInDependentDatas["3"][0].CurrentFill * 1f / 10f - 1f > (float)i) ? 1f : ((float)viewModel.HeroData.HeroInDependentDatas["3"][0].CurrentFill * 1f / 10f - (float)i));
		}
	}

	public override void BindUI()
	{
		base.BindUI();
		if (isInit)
		{
			base.gameObject.SetActive(viewModel.HeroData.HeroIndepentType == _heroIndepentType);
			skillMaxLayer = -1f;
			skillLayer = -1f;
		}
	}

	private void SkillMaxLayerChange()
	{
		for (int i = 0; i < HeroIndepentSkillLayerItems.Count; i++)
		{
			HeroIndepentSkillLayerItems[i].Item.SetActive(viewModel.HeroData.HeroInDependentDatas["3"][0].MaxFill / 10 > i);
		}
	}

	private void LateUpdate()
	{
		if (viewModel != null && viewModel.HeroData != null && viewModel.HeroData.HeroInDependentDatas.TryGetValue("3", out var value))
		{
			int currentFill = value[0].CurrentFill;
			int maxFill = value[0].MaxFill;
			if ((float)currentFill != SkillLayer)
			{
				SkillLayer = currentFill;
			}
			if (SkillMaxLayer != (float)maxFill)
			{
				SkillMaxLayer = maxFill;
			}
			bool flag = currentFill / 10 >= 4;
			if (FillFour.activeSelf != flag)
			{
				FillFour.SetActive(flag);
			}
		}
	}

	public override void InitData()
	{
		base.InitData();
		_heroIndepentType = HeroIndepentType.HeroUI1;
	}
}
