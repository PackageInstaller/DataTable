using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EntryDetailItem : UGuiView
{
	[SerializeField]
	private Image entryImg;

	[SerializeField]
	private TextMeshProUGUI entryName;

	[SerializeField]
	private TextMeshProUGUI entryDetail;

	[SerializeField]
	private TextMeshProUGUI entryLevel;

	[SerializeField]
	private LoopListView2 levelItemList;

	private EntryDetailItemData viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<EntryDetailItemData>(userData);
		BindingSet<EntryDetailItem, EntryDetailItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(entryImg).For((Image v) => v.sprite).ToExpression((EntryDetailItemData vm) => vm.EntryIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(entryName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryDetailItemData vm) => vm.EntryName);
		bindingSet.Bind<TextMeshProUGUI>(entryDetail).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryDetailItemData vm) => vm.EntryDetail);
		bindingSet.Bind<TextMeshProUGUI>(entryLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EntryDetailItemData vm) => vm.EntryLevel);
		bindingSet.Build();
		levelItemList.InitListView(viewModel.LevelItem.Count, OnGetEntryLevelItemByIndex);
	}

	public void RefreshEntryDetailItem(EntryDetailItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
		levelItemList.SetListItemCount(viewModel.LevelItem.Count);
		levelItemList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetEntryLevelItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.LevelItem.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("EntryLevelItem");
		if (loopListViewItem != null)
		{
			TabItemNormal component = loopListViewItem.GetComponent<TabItemNormal>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.LevelItem[index]);
			}
			else
			{
				component.RefreshData(viewModel.LevelItem[index]);
			}
		}
		return loopListViewItem;
	}
}
