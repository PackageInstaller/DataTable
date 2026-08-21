using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class SkillMYBuffLayerView : HeroIndepentResView
{
	[SerializeField]
	private GameObject hitNormalGo;

	[SerializeField]
	private GameObject hitWeaknessGo;

	[SerializeField]
	private GameObject hitFatalWeaknessGo;

	[SerializeField]
	private GameObject twoHitGo;

	[SerializeField]
	private GameObject backGround;

	private int hitNormalBuff;

	private int hitWeaknessBuff;

	private int hitFatalWeaknessBuff;

	private int twoHitBuff1;

	public int HitNormalBuff
	{
		get
		{
			return hitNormalBuff;
		}
		set
		{
			hitNormalBuff = value;
			hitNormalGo.SetActive(value > 0);
			SetBackGround();
		}
	}

	public int HitWeaknessBuff
	{
		get
		{
			return hitWeaknessBuff;
		}
		set
		{
			hitWeaknessBuff = value;
			hitWeaknessGo.SetActive(value > 0);
			SetBackGround();
		}
	}

	public int HitFatalWeaknessBuff
	{
		get
		{
			return hitFatalWeaknessBuff;
		}
		set
		{
			hitFatalWeaknessBuff = value;
			hitFatalWeaknessGo.SetActive(value > 0);
			SetBackGround();
		}
	}

	public int TwoHitBuff1
	{
		get
		{
			return twoHitBuff1;
		}
		set
		{
			twoHitBuff1 = value;
			if (twoHitGo.activeSelf)
			{
				twoHitGo.SetActive(value: false);
			}
			twoHitGo.SetActive(value: true);
			SetBackGround();
		}
	}

	private void SetBackGround()
	{
		if (hitNormalBuff > 0 || hitWeaknessBuff > 0 || hitFatalWeaknessBuff > 0)
		{
			backGround.SetActive(value: true);
		}
		else
		{
			backGround.SetActive(value: false);
		}
	}

	public override void BindUI()
	{
		base.BindUI();
		if (isInit)
		{
			BindingSet<SkillMYBuffLayerView, BattleUserViewModel> bindingSet = this.CreateBindingSet(viewModel);
			bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => (int)vm.HeroData.HeroIndepentType == 13);
			bindingSet.Bind().For((SkillMYBuffLayerView v) => v.HitNormalBuff).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][0].CurrentFill);
			bindingSet.Bind().For((SkillMYBuffLayerView v) => v.HitWeaknessBuff).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][1].CurrentFill);
			bindingSet.Bind().For((SkillMYBuffLayerView v) => v.HitFatalWeaknessBuff).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][2].CurrentFill);
			bindingSet.Bind().For((SkillMYBuffLayerView v) => v.TwoHitBuff1).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][3].CurrentFill);
			bindingSet.Build();
		}
	}

	public override void InitData()
	{
		base.InitData();
		_heroIndepentType = HeroIndepentType.HeroUI13;
	}

	public override void ClearBingUI(BattleUserViewModel viewModel)
	{
		base.ClearBingUI(viewModel);
		if (!isInit)
		{
			this.ClearAllBindings();
		}
		HitNormalBuff = 0;
		HitWeaknessBuff = 0;
		HitFatalWeaknessBuff = 0;
		TwoHitBuff1 = 0;
	}
}
