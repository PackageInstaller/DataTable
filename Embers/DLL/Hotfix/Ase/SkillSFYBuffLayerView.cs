using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class SkillSFYBuffLayerView : HeroIndepentResView
{
	[SerializeField]
	private List<Animation> sideShowAni;

	[SerializeField]
	private GameObject leftFullGo;

	[SerializeField]
	private GameObject leftUseGo;

	[SerializeField]
	private GameObject rightFullGo;

	[SerializeField]
	private GameObject rightUseGo;

	[SerializeField]
	private List<Animation> midShowAni;

	[SerializeField]
	private GameObject midFullGo;

	[SerializeField]
	private GameObject midUseGo;

	private string fullAniName = "SteelFeathers_enter";

	private string costAniName = "SteelFeathers_out";

	private int sideBuffCurLayer;

	private int midBuffCurLayer;

	public int SideBuffCurLayer
	{
		get
		{
			return sideBuffCurLayer;
		}
		set
		{
			if (sideBuffCurLayer == value)
			{
				return;
			}
			int count = sideShowAni.Count;
			int num = count / 2;
			if (value > sideBuffCurLayer)
			{
				PlayShowGoAnimation(sideBuffCurLayer, value, fullAniName, sideShowAni);
				leftFullGo.SetActive(value >= num);
				rightFullGo.SetActive(value >= count);
			}
			else if (value == 0)
			{
				if (sideBuffCurLayer == num)
				{
					PlayShowGoAnimation(0, num, costAniName, sideShowAni);
					FullCostShowContent(showFull: false, playCost: true, leftFullGo, leftUseGo);
				}
				else
				{
					PlayShowGoAnimation(0, count, costAniName, sideShowAni);
					FullCostShowContent(showFull: false, playCost: true, leftFullGo, leftUseGo);
					FullCostShowContent(showFull: false, playCost: true, rightFullGo, rightUseGo);
				}
			}
			else if (value >= num)
			{
				PlayShowGoAnimation(num, count, costAniName, sideShowAni);
				FullCostShowContent(showFull: false, playCost: true, rightFullGo, rightUseGo);
			}
			else
			{
				PlayShowGoAnimation(0, value, fullAniName, sideShowAni);
				PlayShowGoAnimation(value, sideBuffCurLayer, costAniName, sideShowAni);
				FullCostShowContent(showFull: false, playCost: true, leftFullGo, leftUseGo);
			}
			sideBuffCurLayer = value;
		}
	}

	public int MidBuffCurLayer
	{
		get
		{
			return midBuffCurLayer;
		}
		set
		{
			if (midBuffCurLayer != value)
			{
				if (value > midBuffCurLayer)
				{
					PlayShowGoAnimation(midBuffCurLayer, value, fullAniName, midShowAni);
				}
				else
				{
					PlayShowGoAnimation(value, midBuffCurLayer, costAniName, midShowAni);
				}
				FullCostShowContent(value >= midShowAni.Count, value == 0, midFullGo, midUseGo);
				midBuffCurLayer = value;
			}
		}
	}

	private void PlayShowGoAnimation(int startIdex, int endIndex, string animationName, List<Animation> animations)
	{
		for (int i = startIdex; i < endIndex; i++)
		{
			if (!((Component)(object)animations[i]).gameObject.activeSelf)
			{
				((Component)(object)animations[i]).gameObject.SetActive(value: true);
			}
			animations[i].Play(animationName);
		}
	}

	private void FullCostShowContent(bool showFull, bool playCost, GameObject fullGo, GameObject costGo)
	{
		fullGo.SetActive(showFull);
		if (playCost)
		{
			costGo.SetActive(value: false);
			costGo.SetActive(value: true);
		}
	}

	public override void BindUI()
	{
		base.BindUI();
		if (isInit)
		{
			BindingSet<SkillSFYBuffLayerView, BattleUserViewModel> bindingSet = this.CreateBindingSet(viewModel);
			bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => (int)vm.HeroData.HeroIndepentType == 11);
			bindingSet.Bind().For((SkillSFYBuffLayerView v) => v.SideBuffCurLayer).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][0].CurrentFill);
			bindingSet.Bind().For((SkillSFYBuffLayerView v) => v.MidBuffCurLayer).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][1].CurrentFill);
			bindingSet.Build();
		}
	}

	public override void InitData()
	{
		base.InitData();
		_heroIndepentType = HeroIndepentType.HeroUI11;
	}

	public override void ClearBingUI(BattleUserViewModel viewModel)
	{
		SideBuffCurLayer = 0;
		MidBuffCurLayer = 0;
		base.ClearBingUI(viewModel);
		if (!isInit)
		{
			this.ClearAllBindings();
		}
	}
}
