using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SkillNLLBuffLayerView : HeroIndepentResView
{
	[SerializeField]
	private GameObject boomerangMinLevelRoot;

	[SerializeField]
	private GameObject boomerangMinLevelGo;

	[SerializeField]
	private GameObject boomerangMaxLevelGo;

	[SerializeField]
	private GameObject chargeMinLevelRoot;

	[SerializeField]
	private GameObject chargeMinLevelGo;

	[SerializeField]
	private List<Image> chargeMinLevelImages;

	[SerializeField]
	private GameObject chargeMaxLevelGo;

	[SerializeField]
	private List<Image> chargeMaxLevelImages;

	[SerializeField]
	private List<GameObject> imprintLayerGos;

	private int boomerangMinLevelBuff;

	private int boomerangMaxLevelBuff;

	private int chargeMinLevelBuff;

	private int chargeMaxLevelBuff;

	private int imprintLayerBuff;

	private float chargeMinTimer;

	private float chargeMaxTimer;

	public int BoomerangMinLevelBuff
	{
		get
		{
			return boomerangMinLevelBuff;
		}
		set
		{
			boomerangMinLevelBuff = value;
			boomerangMinLevelGo.SetActive(value != 0);
		}
	}

	public int BoomerangMaxLevelBuff
	{
		get
		{
			return boomerangMaxLevelBuff;
		}
		set
		{
			boomerangMaxLevelBuff = value;
			if (value > 0)
			{
				boomerangMaxLevelGo.SetActive(value: true);
				boomerangMinLevelRoot.SetActive(value: false);
			}
			else
			{
				boomerangMaxLevelGo.SetActive(value: false);
				boomerangMinLevelRoot.SetActive(value: true);
			}
		}
	}

	public int ChargeMinLevelBuff
	{
		get
		{
			return chargeMinLevelBuff;
		}
		set
		{
			chargeMinLevelBuff = value;
			chargeMinLevelGo.SetActive(value != 0);
		}
	}

	public int ChargeMaxLevelBuff
	{
		get
		{
			return chargeMaxLevelBuff;
		}
		set
		{
			chargeMaxLevelBuff = value;
			if (value > 0)
			{
				chargeMaxLevelGo.SetActive(value: true);
				chargeMinLevelRoot.SetActive(value: false);
			}
			else
			{
				chargeMaxLevelGo.SetActive(value: false);
				chargeMinLevelRoot.SetActive(value: true);
			}
		}
	}

	public int ImprintLayerBuff
	{
		get
		{
			return imprintLayerBuff;
		}
		set
		{
			imprintLayerBuff = value;
			for (int i = 0; i < imprintLayerGos.Count; i++)
			{
				imprintLayerGos[i].SetActive(value > i);
			}
		}
	}

	public float ChargeMinLevelTimer
	{
		get
		{
			return chargeMinTimer;
		}
		set
		{
			for (int i = 0; i < chargeMinLevelImages.Count; i++)
			{
				chargeMinLevelImages[i].fillAmount = value;
			}
		}
	}

	public float ChargeMaxLevelTimer
	{
		get
		{
			return chargeMaxTimer;
		}
		set
		{
			for (int i = 0; i < chargeMaxLevelImages.Count; i++)
			{
				chargeMaxLevelImages[i].fillAmount = value;
			}
		}
	}

	public override void BindUI()
	{
		base.BindUI();
		if (isInit)
		{
			BindingSet<SkillNLLBuffLayerView, BattleUserViewModel> bindingSet = this.CreateBindingSet(viewModel);
			bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => (int)vm.HeroData.HeroIndepentType == 12);
			bindingSet.Bind().For((SkillNLLBuffLayerView v) => v.BoomerangMinLevelBuff).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][0].CurrentFill);
			bindingSet.Bind().For((SkillNLLBuffLayerView v) => v.BoomerangMaxLevelBuff).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][1].CurrentFill);
			bindingSet.Bind().For((SkillNLLBuffLayerView v) => v.ChargeMinLevelBuff).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][2].CurrentFill);
			bindingSet.Bind().For((SkillNLLBuffLayerView v) => v.ChargeMinLevelTimer).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][2].ResFillAmount);
			bindingSet.Bind().For((SkillNLLBuffLayerView v) => v.ChargeMaxLevelBuff).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][3].CurrentFill);
			bindingSet.Bind().For((SkillNLLBuffLayerView v) => v.ChargeMaxLevelTimer).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][3].ResFillAmount);
			bindingSet.Bind().For((SkillNLLBuffLayerView v) => v.ImprintLayerBuff).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][4].CurrentFill);
			bindingSet.Build();
		}
	}

	public override void InitData()
	{
		base.InitData();
		_heroIndepentType = HeroIndepentType.HeroUI12;
	}

	public override void ClearBingUI(BattleUserViewModel viewModel)
	{
		base.ClearBingUI(viewModel);
		if (!isInit)
		{
			this.ClearAllBindings();
		}
		ImprintLayerBuff = 0;
		ChargeMaxLevelBuff = 0;
		ChargeMinLevelBuff = 0;
		BoomerangMaxLevelBuff = 0;
		BoomerangMinLevelBuff = 0;
	}
}
