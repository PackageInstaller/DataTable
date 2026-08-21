using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GameMapInfoWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private TextMeshProUGUI mapName;

	[SerializeField]
	private TextMeshProUGUI mapDesc;

	[SerializeField]
	private LoopListView2 mapNpcList;

	[SerializeField]
	private GameObject npcEmptyObj;

	[SerializeField]
	private RollingView rollingView;

	[SerializeField]
	private Button btnPrevious;

	[SerializeField]
	private Button btnNext;

	private GameMapInfoViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<GameMapInfoViewModel>();
		BindingSet<GameMapInfoWindow, GameMapInfoViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GameMapInfoViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((GameMapInfoWindow v) => v.OpenUguiWindow).To((GameMapInfoViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((GameMapInfoWindow v) => v.CloseWindow).To((GameMapInfoViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TextMeshProUGUI>(mapName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameMapInfoViewModel vm) => vm.MapName);
		bindingSet.Bind<TextMeshProUGUI>(mapDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameMapInfoViewModel vm) => vm.MapDesc);
		bindingSet.Bind(btnPrevious).For((Button v) => v.onClick).To((GameMapInfoViewModel vm) => vm.Previous);
		bindingSet.Bind(btnNext).For((Button v) => v.onClick).To((GameMapInfoViewModel vm) => vm.Next);
		bindingSet.Bind(this).For((GameMapInfoWindow v) => v.RefreshNpcList).To((GameMapInfoViewModel vm) => vm.RefreshNpcRequest);
		bindingSet.Build();
		mapNpcList.InitListView(viewModel.NpcDataList.Count, OnGetNpcItemByIndex);
		rollingView.Init(viewModel.RollingViewModel);
		npcEmptyObj.SetActive(viewModel.NpcDataList.Count == 0);
		btnPrevious.gameObject.SetActive(viewModel.GameMapInfoDataList.Count > 1);
		btnNext.gameObject.SetActive(viewModel.GameMapInfoDataList.Count > 1);
	}

	private void RefreshNpcList(object sender, InteractionEventArgs e)
	{
		mapNpcList.SetListItemCount(viewModel.NpcDataList.Count);
		mapNpcList.RefreshAllShownItem();
		npcEmptyObj.SetActive(viewModel.NpcDataList.Count == 0);
	}

	private LoopListViewItem2 OnGetNpcItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.NpcDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("NpcItem");
		if (loopListViewItem != null)
		{
			TabItemNormal component = loopListViewItem.GetComponent<TabItemNormal>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.NpcDataList[index]);
			}
			else
			{
				component.RefreshData(viewModel.NpcDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
