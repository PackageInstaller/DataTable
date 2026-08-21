using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyType5ItemView : UGuiView
{
	public float selectScale;

	public Button btn;

	public new TextMeshProUGUI name;

	public LoadUISprite icon;

	public TextMeshProUGUI score;

	public GameObject selectRoot;

	public LoopListView2 heroList;

	public TextMeshProUGUI teamTag;

	private CopyTypeItemViewModel viewModel;

	private bool selectItem;

	public bool SelectItem
	{
		get
		{
			return selectItem;
		}
		set
		{
			selectItem = value;
			selectRoot.gameObject.SetActive(value);
			if (value)
			{
				RectTransform.transform.localScale = new Vector3(selectScale, selectScale, 1f);
			}
			else
			{
				RectTransform.transform.localScale = Vector3.one;
			}
		}
	}

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<CopyTypeItemViewModel>(userData);
		BindingSet<CopyType5ItemView, CopyTypeItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((CopyTypeItemViewModel vm) => vm.OptCommand);
		bindingSet.Bind(this).For((CopyType5ItemView v) => v.OnOpt).To((CopyTypeItemViewModel vm) => vm.OptRequest);
		bindingSet.Bind(this).For((CopyType5ItemView v) => v.SelectItem).To((CopyTypeItemViewModel vm) => vm.IsSelect);
		bindingSet.Bind<TextMeshProUGUI>(score).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyTypeItemViewModel vm) => vm.Data.CurScore);
		bindingSet.Bind<TextMeshProUGUI>(teamTag).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyTypeItemViewModel vm) => vm.TeamTag);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyTypeItemViewModel vm) => vm.Data.CopyTypeName);
		bindingSet.Bind(icon).For((LoadUISprite v) => v.Path).ToExpression((CopyTypeItemViewModel vm) => $"{vm.Data.CopyTypeIconPath}/{vm.Data.CopyTypeIcon}");
		bindingSet.Build();
		heroList.InitListView(viewModel.TeamItemList.Count, OnGetTeamItemByIndex);
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyTypeItemViewModel>(userData);
		this.SetDataContext(viewModel);
		heroList.SetListItemCount(viewModel.TeamItemList.Count);
		heroList.RefreshAllShownItem();
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("RefreshType5List".Equals(optName))
		{
			heroList.SetListItemCount(viewModel.TeamItemList.Count);
			heroList.RefreshAllShownItem();
		}
	}

	private LoopListViewItem2 OnGetTeamItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TeamItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("TeamItem");
		if (loopListViewItem != null)
		{
			CopyTeamItemView component = loopListViewItem.GetComponent<CopyTeamItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.TeamItemList[index]);
			}
			else
			{
				component.RefreshData(viewModel.TeamItemList[index]);
			}
			component.CurIndex = index;
		}
		return loopListViewItem;
	}
}
