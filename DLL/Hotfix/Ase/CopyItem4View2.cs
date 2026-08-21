using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyItem4View2 : UGuiView
{
	public Button btn;

	public new TextMeshProUGUI name;

	public LoadUISprite icon;

	public LoopListView2 attributeList;

	public GameObject complete;

	public GameObject nextCopy;

	private CopyItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<CopyItemViewModel>(userData);
		BindingSet<CopyItem4View2, CopyItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((CopyItemViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenDetail");
		bindingSet.Bind(icon).For((LoadUISprite v) => v.Path).ToExpression((CopyItemViewModel vm) => $"{vm.Data.BossIconPath}/{vm.Data.BossIcon}");
		bindingSet.Bind(complete).For((GameObject v) => v.activeSelf).ToExpression((CopyItemViewModel vm) => vm.IsSelect && vm.Quality == 1);
		bindingSet.Bind(nextCopy).For((GameObject v) => v.activeSelf).ToExpression((CopyItemViewModel vm) => !vm.IsSelect && vm.Quality == 1);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyItemViewModel vm) => vm.LockDesc);
		bindingSet.Build();
		attributeList.InitListView(viewModel.Data.Buffs.Count, OnGetAttributeItemByIndex);
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}

	private LoopListViewItem2 OnGetAttributeItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.Data.Buffs.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("AttriItem");
		if (loopListViewItem != null)
		{
			LoadUISprite component = loopListViewItem.GetComponent<LoadUISprite>();
			Button component2 = loopListViewItem.GetComponent<Button>();
			component2.onClick.RemoveAllListeners();
			component2.onClick.AddListener(viewModel.OnBuffClick);
			component.Path = $"ItemIcons/Copy/CopyBuff/boss_property_{viewModel.Data.Buffs[index]}";
		}
		return loopListViewItem;
	}
}
