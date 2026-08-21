using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TeachingManualView : UGuiView
{
	[SerializeField]
	private LoopListView2 pointList;

	[SerializeField]
	private InputField searchInput;

	[SerializeField]
	private Button btnClearSearch;

	[SerializeField]
	private GameObject noContent;

	[SerializeField]
	private GameObject main;

	[SerializeField]
	private LoadUISprite pageIcon;

	[SerializeField]
	private TextMeshProUGUI pageTitle;

	[SerializeField]
	private TextMeshProUGUI pageContent;

	[SerializeField]
	private TextMeshProUGUI pageIndex;

	[SerializeField]
	private Button btnLast;

	[SerializeField]
	private GameObject btnLastMask;

	[SerializeField]
	private Button btnNext;

	[SerializeField]
	private GameObject btnNextMask;

	private TeachingManualViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<TeachingManualViewModel>(userData);
		BindingSet<TeachingManualView, TeachingManualViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(pageIcon).For((LoadUISprite v) => v.Path).To((TeachingManualViewModel vm) => vm.PageIcon);
		bindingSet.Bind<TextMeshProUGUI>(pageTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TeachingManualViewModel vm) => vm.PageTitle);
		bindingSet.Bind<TextMeshProUGUI>(pageContent).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TeachingManualViewModel vm) => vm.PageContent);
		bindingSet.Bind<TextMeshProUGUI>(pageIndex).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TeachingManualViewModel vm) => $"<{vm.CurPage}/{vm.TotalPage}>");
		bindingSet.Bind(btnLast).For((Button v) => v.onClick).To((TeachingManualViewModel vm) => vm.OnLastBtnClick);
		bindingSet.Bind(btnNext).For((Button v) => v.onClick).To((TeachingManualViewModel vm) => vm.OnNextBtnClick);
		bindingSet.Bind(btnLastMask).For((GameObject v) => v.activeSelf).ToExpression((TeachingManualViewModel vm) => vm.CurPage <= 1);
		bindingSet.Bind(btnNextMask).For((GameObject v) => v.activeSelf).ToExpression((TeachingManualViewModel vm) => vm.CurPage >= vm.TotalPage);
		bindingSet.Bind(searchInput.gameObject).For((GameObject v) => v.activeSelf).To((TeachingManualViewModel vm) => vm.ShowSearch);
		bindingSet.Bind(btnClearSearch.gameObject).For((GameObject v) => v.activeSelf).To((TeachingManualViewModel vm) => vm.ShowClearcSearch);
		bindingSet.Bind(noContent).For((GameObject v) => v.activeSelf).To((TeachingManualViewModel vm) => vm.ShowNoContent);
		bindingSet.Bind(main).For((GameObject v) => v.activeSelf).ToExpression((TeachingManualViewModel vm) => !vm.ShowNoContent);
		bindingSet.Bind().For((TeachingManualView v) => v.ClearInput).To((TeachingManualViewModel vm) => vm.ClearSearchRst);
		bindingSet.Bind().For((TeachingManualView v) => v.OnFilterDataChanged).To((TeachingManualViewModel vm) => vm.OnFilterDataChanged);
		bindingSet.Build();
		searchInput.onEndEdit.AddListener(_viewModel.OnInputFieldEndEdit);
		btnClearSearch.onClick.AddListener(OnClearInput);
		pointList.InitListView(_viewModel.FilterDatas.Count, OnGetItemByIndex);
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		OnFilterDataChanged();
	}

	private void OnClearInput()
	{
		searchInput.text = string.Empty;
		_viewModel.OnInputFieldEndEdit(string.Empty);
	}

	private void ClearInput(object sender, InteractionEventArgs e)
	{
		searchInput.text = string.Empty;
	}

	private void OnFilterDataChanged(object sender = null, InteractionEventArgs e = null)
	{
		if (_viewModel != null && _viewModel.FilterDatas != null)
		{
			pointList.SetListItemCount(_viewModel.FilterDatas.Count);
			pointList.RefreshAllShownItem();
		}
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.FilterDatas.Count)
		{
			return null;
		}
		TeachingPoint data = _viewModel.FilterDatas[index];
		if (data == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = pointList.NewListViewItem("PointTabItem");
		TabItemData tabItemData = new TabItemData(_viewModel, data.Id);
		tabItemData.TextNormal = data.PointName;
		tabItemData.TextSelected = data.PointName;
		TabItem component = loopListViewItem.GetComponent<TabItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(tabItemData);
		}
		else
		{
			component.RefreshData(tabItemData);
		}
		if (!_viewModel.IsInBattle)
		{
			loopListViewItem.GetComponent<UIRedPoint>()?.Dispose();
			loopListViewItem.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.TeachingManualUpdate).SetFuncOnMessage((RedPointMessage message) => !TeachingDefinition.GetManualRewardState(data.Index))
				.Invoke();
		}
		if (_viewModel.CurData != null)
		{
			if (data.Id == _viewModel.CurData.Id)
			{
				tabItemData.TabOnClick();
			}
		}
		else if (index == 0)
		{
			tabItemData.TabOnClick();
		}
		return loopListViewItem;
	}
}
