#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyItemDetail1View : UGuiView
{
	public Button btn;

	public Button btnBossDetail;

	public Button btnCloseDetail;

	public LoadUISprite sceneIcon;

	public GameObject firstItem;

	public new TextMeshProUGUI name;

	public TextMeshProUGUI desc;

	public TextMeshProUGUI consumCount;

	public Image consumIcon;

	public TextMeshProUGUI energyNeed;

	public LoopListView2 dropList;

	public GameObject monsterRoot;

	public LoopGridView monsterList;

	public LoopListView2 attributeList;

	private CopyItemDetail1ViewModel viewModel;

	public CopyItemDetail1ViewModel ViewModel
	{
		get
		{
			return viewModel;
		}
		set
		{
			if (viewModel == null)
			{
				OnInit(value);
			}
			else
			{
				RefreshData(value);
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
		viewModel = GetUserData<CopyItemDetail1ViewModel>(userData);
		BindingSet<CopyItemDetail1View, CopyItemDetail1ViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((CopyItemDetail1ViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenSingle");
		bindingSet.Bind(btnBossDetail).For((Button v) => v.onClick).To((CopyItemDetail1ViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenMonsterInfo");
		bindingSet.Bind(btnBossDetail.gameObject).For((GameObject v) => v.activeSelf).ToExpression((CopyItemDetail1ViewModel vm) => !vm.Data.IsBoss);
		bindingSet.Bind(sceneIcon).For((LoadUISprite v) => v.Path).ToExpression((CopyItemDetail1ViewModel vm) => $"{vm.Data.BossIconPath}/{vm.Data.BossIcon}");
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyItemDetail1ViewModel vm) => vm.Data.Name);
		if (consumIcon != null)
		{
			bindingSet.Bind(consumIcon).For((Image v) => v.sprite).ToExpression((CopyItemDetail1ViewModel vm) => vm.Data.PropIcon)
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)consumCount != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(consumCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((CopyItemDetail1ViewModel vm) => $"{vm.Data.PropCount}");
		}
		bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyItemDetail1ViewModel vm) => vm.Desc);
		bindingSet.Bind(firstItem).For((GameObject v) => v.activeSelf).ToExpression((CopyItemDetail1ViewModel vm) => vm.Data.IsNeedFirst && !vm.Data.IsAccessed);
		if ((UnityEngine.Object)(object)energyNeed != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(energyNeed).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((CopyItemDetail1ViewModel vm) => (vm.Data.IsNeedFirst && !vm.Data.IsAccessed) ? 0 : vm.Data.UseEnergy);
		}
		bindingSet.Bind(this).For((CopyItemDetail1View v) => v.OnOpt).To((CopyItemDetail1ViewModel vm) => vm.OptRequest);
		bindingSet.Build();
		if (monsterRoot != null)
		{
			monsterRoot.gameObject.SetActive(value: false);
		}
		if (btnCloseDetail != null)
		{
			btnCloseDetail.onClick.AddListener(delegate
			{
				SettleOpt("CloseMonsterInfo");
			});
		}
		if (attributeList != null)
		{
			attributeList.InitListView(viewModel.AdItemList.Count, OnGetAttributeItemByIndex);
		}
		dropList.InitListView(viewModel.DropProps.Count, OnGetDropItemByIndex);
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (viewModel != null)
		{
			SettleOpt("RefreshDrops");
		}
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyItemDetail1ViewModel>(userData);
		this.SetDataContext(viewModel);
		dropList.SetListItemCount(viewModel.DropProps.Count);
		dropList.RefreshAllShownItem();
		if (attributeList != null)
		{
			attributeList.SetListItemCount(viewModel.AdItemList.Count);
			attributeList.RefreshAllShownItem();
		}
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("OpenMonsterInfo".Equals(optName))
		{
			if (viewModel.MaxCol == 0)
			{
				Log.Error("数据异常，无法打开界面！");
				return;
			}
			monsterRoot.gameObject.SetActive(value: true);
			monsterList.SetGridFixedGroupCount(GridFixedType.ColumnCountFixed, viewModel.MaxCol);
			if (monsterList.MListViewInited)
			{
				monsterList.SetListItemCount(viewModel.GetMonsterCount());
				monsterList.RefreshAllShownItem();
			}
			else
			{
				monsterList.InitGridView(viewModel.GetMonsterCount(), OnGetMonsterItemByIndex);
			}
		}
		else if ("CloseMonsterInfo".Equals(optName))
		{
			monsterRoot.gameObject.SetActive(value: false);
		}
		else if ("RefreshDrops".Equals(optName))
		{
			dropList.SetListItemCount(viewModel.DropProps.Count);
			dropList.RefreshAllShownItem();
			if (attributeList != null)
			{
				attributeList.SetListItemCount(viewModel.AdItemList.Count);
				attributeList.RefreshAllShownItem();
			}
		}
	}

	private LoopGridViewItem OnGetMonsterItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.GetMonsterCount())
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = null;
		int index2 = viewModel.GetIndex(index);
		if (index2 > 0)
		{
			loopGridViewItem = gridView.NewListViewItem("IndexItem");
			if (loopGridViewItem != null)
			{
				loopGridViewItem.GetComponent<CopyMonsterInfoItem>().AddIndex(index2);
				return loopGridViewItem;
			}
		}
		else
		{
			MonsterInfoData monster = viewModel.GetMonster(index);
			if (monster == null)
			{
				return gridView.NewListViewItem("EmptyItem");
			}
			loopGridViewItem = gridView.NewListViewItem("MonsterItem");
			if (loopGridViewItem != null)
			{
				loopGridViewItem.GetComponent<CopyMonsterInfoItem>().AddMonster(monster);
				return loopGridViewItem;
			}
		}
		return loopGridViewItem;
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
			component.SetIcon(viewModel.AdItemList[index]);
		}
		return loopListViewItem;
	}
}
