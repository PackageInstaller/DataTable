using System.Collections.Generic;
using DG.Tweening;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class YunZhaoBuffLayerView : HeroIndepentResView
{
	[SerializeField]
	private List<GameObject> addBuffShowUI;

	[SerializeField]
	private GameObject fullLayer;

	[SerializeField]
	private GameObject bgGo;

	[SerializeField]
	private Animation fullAni;

	[SerializeField]
	private Animation pointAni;

	[SerializeField]
	private CanvasGroup _canvasGroup;

	private Tweener delayShowPoint;

	private int buffLayerNumber = -1;

	private bool pointOut;

	public int BuffLayerNumber
	{
		get
		{
			return buffLayerNumber;
		}
		set
		{
			if (buffLayerNumber == value)
			{
				return;
			}
			bool flag = false;
			if (buffLayerNumber < 10 && value >= 10)
			{
				flag = true;
			}
			bool flag2 = buffLayerNumber >= 10 && value < 10;
			buffLayerNumber = value;
			if (pointOut)
			{
				pointAni.Play("yunzhao_pointenter");
				pointOut = false;
			}
			if (delayShowPoint != null)
			{
				delayShowPoint.Kill();
				delayShowPoint = null;
			}
			if (flag)
			{
				fullLayer.SetActive(value: true);
				fullAni.Play("Effects_UI_PointFill_yunzhao_fullenter");
				for (int i = 0; i < value; i++)
				{
					addBuffShowUI[i].SetActive(value: false);
					bool flag3 = true;
					flag3 = value <= 10 || value - 10 <= i;
					addBuffShowUI[i].SetActive(flag3);
				}
				delayShowPoint = DOTweenModuleUI.DOFade(_canvasGroup, 1f, 0.3f).OnComplete(delegate
				{
					ShowPoint(enterFull: true);
					delayShowPoint = null;
				});
			}
			else
			{
				for (int num = 0; num < addBuffShowUI.Count; num++)
				{
					bool flag4 = true;
					flag4 = value <= 10 || value <= num || value - 10 <= num;
					addBuffShowUI[num].SetActive((value > num) & flag4);
				}
			}
			if (flag2)
			{
				fullLayer.SetActive(value: true);
				fullAni.Play("Effects_UI_PointFill_yunzhao_fullout");
				pointAni.Play("yunzhao_pointout");
				pointOut = true;
				ShowPoint(flag);
			}
		}
	}

	private void ShowPoint(bool enterFull)
	{
		bgGo.SetActive(!enterFull);
	}

	public override void BindUI()
	{
		base.BindUI();
		if (isInit)
		{
			BindingSet<YunZhaoBuffLayerView, BattleUserViewModel> bindingSet = this.CreateBindingSet(viewModel);
			bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => (int)vm.HeroData.HeroIndepentType == 9);
			bindingSet.Bind(this).For((YunZhaoBuffLayerView v) => v.BuffLayerNumber).To((BattleUserViewModel vm) => vm.HeroData.HeroInDependentDatas["1"][0].CurrentFill);
			bindingSet.Build();
			fullLayer.SetActive(value: false);
			BuffLayerNumber = 0;
		}
	}

	public override void InitData()
	{
		base.InitData();
		_heroIndepentType = HeroIndepentType.HeroUI9;
	}

	public override void ClearBingUI(BattleUserViewModel viewModel)
	{
		BuffLayerNumber = 0;
		base.ClearBingUI(viewModel);
		if (!isInit)
		{
			this.ClearAllBindings();
		}
	}
}
