using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ChangePlayerInfoView : UGuiView
{
	[SerializeField]
	private Vector2 itemSize1;

	[SerializeField]
	private Vector2 itemSize2;

	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnBack2;

	[SerializeField]
	private GameObject titleRoot;

	[SerializeField]
	private GameObject AvatarRoot;

	[SerializeField]
	private LoopGridView itemList;

	[SerializeField]
	private Transform toggleRoot;

	[SerializeField]
	private GameObject timeLimitRoot;

	[SerializeField]
	private TextMeshProUGUI timeLimitDesc;

	[SerializeField]
	private GameObject acavarLimitRoot;

	[SerializeField]
	private TextMeshProUGUI acavarLimitDesc;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image iconFrame;

	[SerializeField]
	private TextMeshProUGUI iconDesc;

	[SerializeField]
	private TextMeshProUGUI titleDesc;

	[SerializeField]
	private Image title;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private GameObject enable;

	[SerializeField]
	private GameObject disable;

	[SerializeField]
	private StateItem titleTextState;

	private ChangePlayerInfoViewModel viewModel;

	private GameObject titlePrefabGo;

	private int titlePrefabLoadVersion;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<ChangePlayerInfoViewModel>(userData);
		BindingSet<ChangePlayerInfoView, ChangePlayerInfoViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((ChangePlayerInfoView v) => ((UGuiView)v).OnVisibleChanged).To((ChangePlayerInfoViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(this).For((ChangePlayerInfoView v) => v.UpdateItemList).To((ChangePlayerInfoViewModel vm) => vm.UpdateItemListRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((ChangePlayerInfoViewModel vm) => vm.Hide);
		bindingSet.Bind(btnBack2).For((Button v) => v.onClick).To((ChangePlayerInfoViewModel vm) => vm.Hide);
		bindingSet.Bind(titleRoot).For((GameObject v) => v.activeSelf).ToExpression((ChangePlayerInfoViewModel vm) => (int)vm.State == 2);
		bindingSet.Bind(toggleRoot.gameObject).For((GameObject v) => v.activeSelf).ToExpression((ChangePlayerInfoViewModel vm) => (int)vm.State != 2);
		bindingSet.Bind(AvatarRoot).For((GameObject v) => v.activeSelf).ToExpression((ChangePlayerInfoViewModel vm) => (int)vm.State != 2);
		bindingSet.Bind(this).For((ChangePlayerInfoView v) => v.UpdateDesc).To((ChangePlayerInfoViewModel vm) => vm.UpdateDescRequest);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((ChangePlayerInfoViewModel vm) => vm.CurIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(iconFrame).For((Image v) => v.sprite).ToExpression((ChangePlayerInfoViewModel vm) => $"HeadAdorn{vm.CurIconFrame}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(iconDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ChangePlayerInfoViewModel vm) => $"{vm.Desc}");
		bindingSet.Bind<TextMeshProUGUI>(titleDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ChangePlayerInfoViewModel vm) => $"{vm.Desc}");
		bindingSet.Bind(timeLimitRoot).For((GameObject v) => v.activeSelf).ToExpression((ChangePlayerInfoViewModel vm) => vm.TitleTimeLimitType != 1);
		bindingSet.Bind<TextMeshProUGUI>(timeLimitDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ChangePlayerInfoViewModel vm) => $"{vm.TitleTimeLimitDesc}");
		bindingSet.Bind(acavarLimitRoot).For((GameObject v) => v.activeSelf).ToExpression((ChangePlayerInfoViewModel vm) => vm.TitleTimeLimitType != 1);
		bindingSet.Bind<TextMeshProUGUI>(acavarLimitDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ChangePlayerInfoViewModel vm) => $"{vm.TitleTimeLimitDesc}");
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((ChangePlayerInfoViewModel vm) => vm.OptCommad);
		bindingSet.Bind(titleTextState).For((StateItem v) => v.CurState).To((ChangePlayerInfoViewModel vm) => vm.State);
		bindingSet.Build();
		itemList.InitGridView(0, OnGetItemItemByIndex);
		UpdateItemList(null, null);
		InitToggles();
		UpdateDesc(null, null);
		itemList.MovePanelToItemByIndex(viewModel.GetSelectedIndex());
	}

	protected override void OnEnable()
	{
		toggleRoot.GetChild(0).GetComponent<TabToggle>().isOn = true;
		toggleRoot.GetChild(1).GetComponent<TabToggle>().isOn = false;
		if (viewModel != null)
		{
			viewModel.Refresh();
		}
	}

	private void UpdateDesc(object sender, InteractionEventArgs e)
	{
		if (viewModel.State == RoleDecorateEnum.Title && viewModel.CurTitleId == 0)
		{
			title.gameObject.SetActive(value: false);
			((Component)(object)titleDesc).gameObject.SetActive(value: false);
			ClearTitlePrefab();
		}
		else
		{
			title.gameObject.SetActive(value: true);
			((Component)(object)titleDesc).gameObject.SetActive(value: true);
			RefreshTitlePrefab().Forget();
		}
		enable.SetActive(viewModel.Enable());
		disable.SetActive(!viewModel.Enable());
	}

	private void InitToggles()
	{
		int childCount = toggleRoot.childCount;
		for (int i = 0; i < childCount; i++)
		{
			toggleRoot.GetChild(i).GetComponent<TabToggle>().AddSelectedAction(viewModel.SetState);
		}
	}

	private void UpdateItemList(object sender, InteractionEventArgs e)
	{
		if (viewModel.State == RoleDecorateEnum.Title)
		{
			itemList.SetGridFixedGroupCount(GridFixedType.ColumnCountFixed, 2);
			itemList.ItemSize = itemSize2;
		}
		else
		{
			itemList.SetGridFixedGroupCount(GridFixedType.ColumnCountFixed, 3);
			itemList.ItemSize = itemSize1;
		}
		itemList.SetListItemCount(viewModel.GetItemCount());
		itemList.RefreshAllShownItem();
		itemList.MovePanelToItemByIndex(viewModel.GetSelectedIndex());
	}

	public void RefreshData(ChangePlayerInfoViewModel viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
		RefreshTitlePrefab().Forget();
	}

	private LoopGridViewItem OnGetItemItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.GetItemCount())
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = null;
		if (viewModel.State == RoleDecorateEnum.HeadIcon)
		{
			loopGridViewItem = gridView.NewListViewItem("HeadItem");
			if (loopGridViewItem != null)
			{
				AvatarItemView component = loopGridViewItem.GetComponent<AvatarItemView>();
				if (!loopGridViewItem.IsInitHandlerCalled)
				{
					loopGridViewItem.IsInitHandlerCalled = true;
					component.Init(viewModel.AvatarList[index]);
				}
				else
				{
					component.RefreshData(viewModel.AvatarList[index]);
				}
			}
		}
		else if (viewModel.State == RoleDecorateEnum.HeadFrame)
		{
			loopGridViewItem = gridView.NewListViewItem("HeadItem");
			if (loopGridViewItem != null)
			{
				AvatarItemView component2 = loopGridViewItem.GetComponent<AvatarItemView>();
				if (!loopGridViewItem.IsInitHandlerCalled)
				{
					loopGridViewItem.IsInitHandlerCalled = true;
					component2.Init(viewModel.AvatarFrameList[index]);
				}
				else
				{
					component2.RefreshData(viewModel.AvatarFrameList[index]);
				}
			}
		}
		else if (viewModel.State == RoleDecorateEnum.Title)
		{
			loopGridViewItem = gridView.NewListViewItem("TitleItem");
			if (loopGridViewItem != null)
			{
				TitleItemView component3 = loopGridViewItem.GetComponent<TitleItemView>();
				if (!loopGridViewItem.IsInitHandlerCalled)
				{
					loopGridViewItem.IsInitHandlerCalled = true;
					component3.Init(viewModel.TitleList[index]);
				}
				else
				{
					component3.RefreshData(viewModel.TitleList[index]);
				}
			}
		}
		return loopGridViewItem;
	}

	protected override void OnVisibleChanged(object sender, InteractionEventArgs e)
	{
		base.OnVisibleChanged(sender, e);
	}

	protected override void OnDestroy()
	{
		titlePrefabLoadVersion++;
		ClearTitlePrefab();
		base.OnDestroy();
		viewModel.Close();
	}

	private async UniTaskVoid RefreshTitlePrefab()
	{
		int loadVersion = ++titlePrefabLoadVersion;
		ClearTitlePrefab();
		title.sprite = null;
		if (viewModel == null || viewModel.State != RoleDecorateEnum.Title || viewModel.CurTitleId == 0)
		{
			return;
		}
		DRTitle dataRow = GameEntry.DataTable.GetDataRow<DRTitle>(viewModel.CurTitleId);
		if (dataRow == null || string.IsNullOrEmpty(dataRow.Icon))
		{
			return;
		}
		GameObject gameObject = await InstantiateAsync(AssetUtility.GetDynamicDecorationPrefab(dataRow.Icon), title.transform);
		if (!(gameObject == null))
		{
			if (loadVersion != titlePrefabLoadVersion)
			{
				UnityEngine.Object.Destroy(gameObject);
				return;
			}
			titlePrefabGo = gameObject;
			titlePrefabGo.transform.localScale = Vector3.one;
			titlePrefabGo.transform.localPosition = Vector3.zero;
			titlePrefabGo.transform.localRotation = Quaternion.identity;
		}
	}

	private void ClearTitlePrefab()
	{
		if (titlePrefabGo != null)
		{
			UnityEngine.Object.Destroy(titlePrefabGo);
			titlePrefabGo = null;
		}
	}
}
