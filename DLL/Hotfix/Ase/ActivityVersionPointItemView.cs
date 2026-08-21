using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class ActivityVersionPointItemView : SelectItemView
{
	public int VAItemId;

	public GameObject red;

	public GameObject conmplete;

	public new TextMeshProUGUI name;

	public UIStarGroup starGroup;

	public GameObject lockRoot;

	public GameObject effectGo;

	private ActivityVersionPointItemViewModel viewModel;

	private bool lockState;

	[HideInInspector]
	public bool LockState
	{
		get
		{
			return lockState;
		}
		set
		{
			if (lockState && !value)
			{
				effectGo.gameObject.SetActive(value: true);
			}
			lockState = value;
			lockRoot.gameObject.SetActive(value);
		}
	}

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		base.OnInit(userData);
		viewModel = GetUserData<ActivityVersionPointItemViewModel>(userData);
		BindingSet<ActivityVersionPointItemView, ActivityVersionPointItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((ActivityVersionPointItemView v) => v.LockState).To((ActivityVersionPointItemViewModel vm) => vm.Data.IsLock);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityVersionPointItemViewModel vm) => vm.Data.Name);
		bindingSet.Bind(red).For((GameObject v) => v.activeSelf).To((ActivityVersionPointItemViewModel vm) => vm.Data.IsNew);
		if (conmplete != null)
		{
			bindingSet.Bind(conmplete).For((GameObject v) => v.activeSelf).To((ActivityVersionPointItemViewModel vm) => vm.Data.IsComplete);
		}
		if (starGroup != null)
		{
			bindingSet.Bind(starGroup).For((UIStarGroup v) => v.CurCount).To((ActivityVersionPointItemViewModel vm) => vm.Data.CurStarCount);
			bindingSet.Bind(starGroup).For((UIStarGroup v) => v.MaxCount).To((ActivityVersionPointItemViewModel vm) => vm.Data.MaxStarCount);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		viewModel = GetUserData<ActivityVersionPointItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}

	public int GetRank()
	{
		return viewModel.Data.DrVersionActivity.RankSecond;
	}
}
