using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyItem2View : CopyPlayUnlockEffectItemView
{
	public int itemType = 1;

	public Button btn;

	public new TextMeshProUGUI name;

	public TextMeshProUGUI bossLv;

	public LoadUISprite icon;

	public Animator animator;

	public GameObject normalRoot;

	public GameObject lockRoot;

	public GameObject redRoot;

	public GameObject redRoot2;

	public GameObject selectRoot;

	public GameObject unSelectRoot;

	public GameObject firstRoot;

	public GameObject nofirstRoot;

	private CopyItemViewModel viewModel;

	public int index = -1;

	public float curAniPos;

	public int Index => index;

	public float CurAniPos => curAniPos;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<CopyItemViewModel>(userData);
		BindingSet<CopyItem2View, CopyItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (itemType == 1)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((CopyItemViewModel vm) => vm.OptCommand)
				.CommandParameter("OpenDetail");
			bindingSet.Bind(normalRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyItemViewModel vm) => !vm.Data.IsLock && vm.Data.HasPlayUnlock);
			bindingSet.Bind(lockRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyItemViewModel vm) => vm.Data.IsLock || !vm.Data.HasPlayUnlock);
			bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyItemViewModel vm) => vm.Data.CopyRankName);
			bindingSet.Bind<TextMeshProUGUI>(bossLv).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyItemViewModel vm) => vm.BossLv);
			bindingSet.Bind(icon).For((LoadUISprite v) => v.Path).ToExpression((CopyItemViewModel vm) => $"{vm.Data.BossIconPath}/{vm.Data.BossIcon}");
			bindingSet.Bind(redRoot).For((GameObject v) => v.activeSelf).To((CopyItemViewModel vm) => vm.Data.HasNew);
			bindingSet.Bind(redRoot2).For((GameObject v) => v.activeSelf).To((CopyItemViewModel vm) => vm.Data.HasNew);
			bindingSet.Bind(firstRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyItemViewModel vm) => !vm.Data.IsAccessed && !vm.Data.IsLock && vm.Data.HasPlayUnlock);
			bindingSet.Bind(nofirstRoot).For((GameObject v) => v.activeSelf).To((CopyItemViewModel vm) => vm.Data.IsAccessed);
			bindingSet.Bind(selectRoot).For((GameObject v) => v.activeSelf).To((CopyItemViewModel vm) => vm.IsOpenDetail);
			bindingSet.Bind().For((CopyItem2View v) => v.OnOpt).To((CopyItemViewModel vm) => vm.OptRequest);
			bindingSet.Bind(unSelectRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyItemViewModel vm) => !vm.IsOpenDetail);
		}
		else if (itemType == 2)
		{
			bindingSet.Bind(selectRoot).For((GameObject v) => v.activeSelf).To((CopyItemViewModel vm) => vm.IsSelect);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}

	public void SetIndex(int index)
	{
		this.index = index;
	}

	public void SetAniPos(float aniPos)
	{
		curAniPos = aniPos;
		if ((UnityEngine.Object)(object)animator != null && ((Behaviour)(object)animator).isActiveAndEnabled)
		{
			animator.Play("CopyItemView2", -1, Mathf.Clamp01(aniPos));
		}
		animator.speed = 0f;
	}

	protected override void AfterPlayNewUnlockEffect()
	{
		base.AfterPlayNewUnlockEffect();
		if (itemType == 1)
		{
			viewModel.AfterPlayNewUnlockEffect();
		}
	}
}
