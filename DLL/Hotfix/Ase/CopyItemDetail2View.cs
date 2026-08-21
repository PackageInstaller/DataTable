using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyItemDetail2View : UGuiView
{
	public Button btnSingle;

	public Button btnMulti;

	public Button btnChangeDrop;

	public LoadUISprite sceneIcon;

	public new TextMeshProUGUI name;

	public TextMeshProUGUI desc;

	public TextMeshProUGUI energyNeed;

	public GameObject firstItem;

	public GameObject normalDropRoot;

	public GameObject openDropRoot;

	public LoopListView2 dropList;

	public LoopListView2 openDropList;

	public LoopListView2 attributeList;

	public LoopListView2 entryList;

	public GameObject normalRoot;

	public GameObject lockRoot;

	public GameObject detailCloseRoot;

	public GameObject detailOpenRoot;

	public CopyLockTextItem lockDesc;

	public EntryInfoView entryInfoView;

	public CopyBuffItemView2 copyBuff;

	private CopyItemDetail2ViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<CopyItemDetail2ViewModel>(userData);
		BindingSet<CopyItemDetail2View, CopyItemDetail2ViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnSingle).For((Button v) => v.onClick).To((CopyItemDetail2ViewModel vm) => vm.OptCommand)
			.CommandParameter("OnSingle");
		bindingSet.Bind(btnMulti).For((Button v) => v.onClick).To((CopyItemDetail2ViewModel vm) => vm.OptCommand)
			.CommandParameter("OnMulti");
		bindingSet.Bind(btnChangeDrop).For((Button v) => v.onClick).To((CopyItemDetail2ViewModel vm) => vm.OptCommand)
			.CommandParameter("ChangeDrop");
		bindingSet.Bind(sceneIcon).For((LoadUISprite v) => v.Path).ToExpression((CopyItemDetail2ViewModel vm) => $"{vm.Data.BossIconPath}/{vm.Data.BossIcon}");
		bindingSet.Bind(sceneIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((CopyItemDetail2ViewModel vm) => !vm.Data.IsLock);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyItemDetail2ViewModel vm) => vm.Data.Name);
		bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyItemDetail2ViewModel vm) => vm.Desc);
		bindingSet.Bind<TextMeshProUGUI>(energyNeed).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((CopyItemDetail2ViewModel vm) => (vm.Data.IsNeedFirst && !vm.Data.IsAccessed) ? 0 : vm.Data.UseEnergy);
		bindingSet.Bind(firstItem).For((GameObject v) => v.activeSelf).ToExpression((CopyItemDetail2ViewModel vm) => vm.Data.IsNeedFirst && !vm.Data.IsAccessed);
		bindingSet.Bind(this).For((CopyItemDetail2View v) => v.OnOpt).To((CopyItemDetail2ViewModel vm) => vm.OptRequest);
		bindingSet.Bind(normalRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyItemDetail2ViewModel vm) => !vm.Data.IsLock && vm.Data.HasPlayUnlock);
		bindingSet.Bind(lockRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyItemDetail2ViewModel vm) => vm.Data.IsLock || !vm.Data.HasPlayUnlock);
		bindingSet.Bind(lockDesc).For((CopyLockTextItem v) => v.CopyData).To((CopyItemDetail2ViewModel vm) => vm.Data);
		bindingSet.Bind(this).For((CopyItemDetail2View v) => v.ShowEntryDetail).To((CopyItemDetail2ViewModel vm) => vm.ShowEntryDetailRequest);
		bindingSet.Build();
		entryInfoView.gameObject.SetActive(value: false);
		entryInfoView.Init();
		normalDropRoot.gameObject.SetActive(value: true);
		openDropRoot.gameObject.SetActive(value: false);
		dropList.InitListView(viewModel.DropProps.Count, OnGetDropItemByIndex);
		attributeList.InitListView(viewModel.AdItemList.Count, OnGetAttributeItemByIndex);
		copyBuff.Init(viewModel.BuffVM);
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyItemDetail2ViewModel>(userData);
		this.SetDataContext(viewModel);
		dropList.SetListItemCount(viewModel.DropProps.Count);
		dropList.RefreshAllShownItem();
		copyBuff.RefreshData(viewModel.BuffVM);
	}

	private void ShowEntryDetail(object sender, InteractionEventArgs e)
	{
		EntryItem entryItem = (EntryItem)e.Context;
		entryInfoView.Show3(entryItem.ViewModel);
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (viewModel != null)
		{
			SettleOpt("RefreshDrops");
		}
	}

	private void SettleOpt(string optName)
	{
		if ("ChangeDrop".Equals(optName))
		{
			normalDropRoot.SetActive(!viewModel.IsOpenDrop);
			openDropRoot.SetActive(viewModel.IsOpenDrop);
			detailCloseRoot.SetActive(!viewModel.IsOpenDrop);
			detailOpenRoot.SetActive(viewModel.IsOpenDrop);
		}
		else if ("RefreshDrops".Equals(optName))
		{
			if (dropList.IsInited)
			{
				dropList.SetListItemCount(viewModel.DropProps.Count);
				dropList.RefreshAllShownItem();
			}
			if (!openDropList.IsInited)
			{
				openDropList.InitListView(viewModel.DropDtailProps.Count, OnGetOpenDropItemByIndex);
			}
			else
			{
				openDropList.SetListItemCount(viewModel.DropDtailProps.Count);
				openDropList.RefreshAllShownItem();
			}
			if (attributeList.IsInited)
			{
				attributeList.SetListItemCount(viewModel.AdItemList.Count);
				attributeList.RefreshAllShownItem();
			}
		}
	}

	private LoopListViewItem2 OnGetOpenDropItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.DropDtailProps.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("CopyEquipItemView");
		if (loopListViewItem != null)
		{
			CopyEquipDropItemView component = loopListViewItem.GetComponent<CopyEquipDropItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.DropDtailProps[index]);
			}
			else
			{
				component.RefreshData(viewModel.DropDtailProps[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetDropItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.DropProps.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		loopListViewItem = (viewModel.DropProps[index].IsLock ? listView2.NewListViewItem("MailAttachmentItemFirst") : ((!string.IsNullOrEmpty(viewModel.DropProps[index].CountRange)) ? listView2.NewListViewItem("MailAttachmentItemNormal") : listView2.NewListViewItem("MailAttachmentItemNoBar")));
		if (loopListViewItem != null)
		{
			ReceiveItemView component = loopListViewItem.GetComponent<ReceiveItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.DropProps[index]);
			}
			else
			{
				component.RefreshData(viewModel.DropProps[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetAttributeItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.AdItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("AttriItem");
		if (loopListViewItem != null)
		{
			CopyBuffItemView component = loopListViewItem.GetComponent<CopyBuffItemView>();
			component.Init();
			component.btn.onClick.RemoveAllListeners();
			component.btn.onClick.AddListener(viewModel.OnBuffClick);
			component.SetIcon(viewModel.AdItemList[index]);
		}
		return loopListViewItem;
	}
}
