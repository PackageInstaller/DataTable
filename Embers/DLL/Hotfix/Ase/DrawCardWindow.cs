#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DrawCardWindow : UGuiWindowBase
{
	[SerializeField]
	private Button backBtn;

	[SerializeField]
	private MoneyView moneyView;

	[SerializeField]
	private GameObject deadLineTextObj;

	[SerializeField]
	private TextMeshProUGUI deadLine;

	[SerializeField]
	private DrawCardInfoItem drawCardInfoItem;

	[SerializeField]
	private GameObject drawCardInfoObj;

	[SerializeField]
	private GameObject drawCardCountParent;

	[SerializeField]
	private TextMeshProUGUI purpleCardCountTxt;

	[SerializeField]
	private TextMeshProUGUI goldenCardCountTxt;

	[SerializeField]
	private TextMeshProUGUI purpleCardTxt;

	[SerializeField]
	private TextMeshProUGUI goldenCardTxt;

	[SerializeField]
	private GameObject ramainCountObj;

	[SerializeField]
	private TextMeshProUGUI remainCount;

	[SerializeField]
	private Button oneTimeBtn;

	[SerializeField]
	private Button tenTimeBtn;

	[SerializeField]
	private GameObject oneTimeBtnObj;

	[SerializeField]
	private GameObject tenTimeSaleObj;

	[SerializeField]
	private TextMeshProUGUI tenTimeSaleText;

	[SerializeField]
	private TextMeshProUGUI tenTimePriceText;

	[SerializeField]
	private Image oneTimeImg;

	[SerializeField]
	private Image tenTimeImg;

	[SerializeField]
	private Button openExChangeBtn;

	[SerializeField]
	private Button openDetailBtn;

	[SerializeField]
	private Button openPreviewBtn;

	[SerializeField]
	private GameObject openPreviewBtnObj;

	[SerializeField]
	private List<GameObject> cardPoolList;

	[SerializeField]
	private LoopListView2 drawCardList;

	[SerializeField]
	private GameObject maskObj;

	[SerializeField]
	private ScrollRect scrollRect;

	private DrawCardViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<DrawCardViewModel>();
		BindingSet<DrawCardWindow, DrawCardViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((DrawCardWindow v) => v.CloseWindow).To((DrawCardViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((DrawCardWindow v) => v.OpenUguiWindow).To((DrawCardViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(backBtn).For((Button v) => v.onClick).To((DrawCardViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(maskObj).For((GameObject v) => v.activeSelf).To((DrawCardViewModel vm) => vm.IsMask);
		bindingSet.Bind(oneTimeBtn).For((Button v) => v.onClick).To((DrawCardViewModel vm) => vm.OneTimeCommand);
		bindingSet.Bind(tenTimeBtn).For((Button v) => v.onClick).To((DrawCardViewModel vm) => vm.TenTimeCommand);
		bindingSet.Bind(oneTimeImg).For((Image v) => v.sprite).To((DrawCardViewModel vm) => vm.CurPoolInfo.DrawCardPoolInfo.CostPropIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(tenTimeImg).For((Image v) => v.sprite).To((DrawCardViewModel vm) => vm.CurPoolInfo.DrawCardPoolInfo.CostPropIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(deadLineTextObj).For((GameObject v) => v.activeSelf).ToExpression((DrawCardViewModel vm) => !vm.LeftRefreshTimeText.Equals("") && vm.IsCardTimesOrCardCount == 1);
		bindingSet.Bind<TextMeshProUGUI>(deadLine).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardViewModel vm) => vm.LeftRefreshTimeText);
		bindingSet.Bind(ramainCountObj).For((GameObject v) => v.activeSelf).ToExpression((DrawCardViewModel vm) => !vm.LeftRefreshTimeText.Equals("") && vm.IsCardTimesOrCardCount == 2);
		bindingSet.Bind<TextMeshProUGUI>(remainCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardViewModel vm) => vm.LeftRefreshTimeText);
		bindingSet.Bind(oneTimeBtnObj).For((GameObject v) => v.activeSelf).To((DrawCardViewModel vm) => vm.CurPoolInfo.DrawCardPoolInfo.HaveSingle);
		bindingSet.Bind(tenTimeSaleObj).For((GameObject v) => v.activeSelf).To((DrawCardViewModel vm) => vm.IsSale);
		bindingSet.Bind<TextMeshProUGUI>(tenTimeSaleText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((DrawCardViewModel vm) => $"-{vm.SaleCount}%");
		bindingSet.Bind<TextMeshProUGUI>(tenTimePriceText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((DrawCardViewModel vm) => vm.TenTimePrice);
		bindingSet.Bind(openExChangeBtn).For((Button v) => v.onClick).To((DrawCardViewModel vm) => vm.OpenExchangeCommand);
		bindingSet.Bind(openDetailBtn).For((Button v) => v.onClick).To((DrawCardViewModel vm) => vm.OpenDetailCommand);
		bindingSet.Bind(openPreviewBtn).For((Button v) => v.onClick).To((DrawCardViewModel vm) => vm.OpenPreviewCommand);
		bindingSet.Bind(openPreviewBtnObj).For((GameObject v) => v.activeSelf).To((DrawCardViewModel vm) => vm.IsShowPreview);
		bindingSet.Bind(drawCardInfoObj).For((GameObject v) => v.activeSelf).To((DrawCardViewModel vm) => vm.ShowOption);
		bindingSet.Bind(drawCardCountParent).For((GameObject v) => v.activeSelf).To((DrawCardViewModel vm) => vm.IsShowDrawCardTxt);
		bindingSet.Bind<TextMeshProUGUI>(purpleCardCountTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardViewModel vm) => vm.RemainPurpleCardCountTxt);
		bindingSet.Bind<TextMeshProUGUI>(goldenCardCountTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardViewModel vm) => vm.RemainGoldenCardCountTxt);
		bindingSet.Bind<TextMeshProUGUI>(purpleCardTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardViewModel vm) => vm.PurpleCardTxt);
		bindingSet.Bind<TextMeshProUGUI>(goldenCardTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardViewModel vm) => vm.GoldenCardTxt);
		bindingSet.Bind(this).For((DrawCardWindow v) => v.OpenCardPanel).To((DrawCardViewModel vm) => vm.SwitchImgRequest);
		bindingSet.Bind(this).For((DrawCardWindow v) => v.UpdateCardPool).To((DrawCardViewModel vm) => vm.RefreshPoolRequest);
		bindingSet.Bind(this).For((DrawCardWindow v) => v.SetAlphaToOne).To((DrawCardViewModel vm) => vm.SetWindowAlphaToOneRequest);
		bindingSet.Build();
		drawCardList.InitListView(viewModel.PoolTabsData.Count, OnGetDrawCardItemByIndex);
		moneyView.Init(new MoneyViewModel(viewModel));
		drawCardInfoItem.Init(viewModel.DrawCardInfoItemData);
	}

	private void SetAlphaToOne(object sender, InteractionEventArgs e)
	{
		SetViewAlpha(1);
	}

	private void UpdateCardPool(object sender, InteractionEventArgs e)
	{
		drawCardList.SetListItemCount(viewModel.PoolTabsData.Count);
		drawCardList.RefreshAllShownItem();
		scrollRect.verticalNormalizedPosition = 1f;
	}

	protected override void OnShow()
	{
		base.OnShow();
		OpenCardPanel();
	}

	private void RefreshMoneyView()
	{
		moneyView.HideAll();
		moneyView.SetShow(new List<RoleMoneyEnum>
		{
			viewModel.CurPoolInfo.DrawCardPoolInfo.CostPropType,
			RoleMoneyEnum.Diamond
		});
	}

	private void OpenCardPanel(object sender = null, InteractionEventArgs e = null)
	{
		string text = $"{viewModel.CurPoolInfo.DrawCardPoolInfo.Id}";
		for (int i = 0; i < cardPoolList.Count; i++)
		{
			GameObject gameObject = cardPoolList[i];
			if (gameObject == null)
			{
				Log.Error($"DrawCardWindow cardPoolList 存在空引用 index={i}, curPoolId={text}");
			}
			else
			{
				gameObject.SetActive(gameObject.name.Equals(text));
			}
		}
		RefreshMoneyView();
	}

	private LoopListViewItem2 OnGetDrawCardItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.PoolTabsData.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("PoolItem");
		if (loopListViewItem != null)
		{
			DrawCardTabItem component = loopListViewItem.GetComponent<DrawCardTabItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.PoolTabsData[index]);
			}
			else
			{
				component.RefreshData(viewModel.PoolTabsData[index]);
			}
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
