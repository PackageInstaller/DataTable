using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TowerTalentStrengthenWindow : UGuiWindow
{
	[SerializeField]
	private string unEnoughColor = "#ff8a7a";

	[SerializeField]
	private string normalColor = "#";

	[SerializeField]
	private List<TowerTalentItemView> towerTalentItemViews;

	[SerializeField]
	private Button backButton;

	[SerializeField]
	private Button upLevelDes;

	[SerializeField]
	private Button upLevelClose;

	[SerializeField]
	private Button upTalentLevelBtn;

	[SerializeField]
	private TextMeshProUGUI upTalentLevelText;

	[SerializeField]
	private Button resetTalentBtn;

	[SerializeField]
	private GameObject maxLevelGo;

	[SerializeField]
	private GameObject lockBtnGo;

	[SerializeField]
	private TextMeshProUGUI upLevelCostText;

	[SerializeField]
	private TextMeshProUGUI talentDes;

	[SerializeField]
	private GameObject talentType1;

	[SerializeField]
	private GameObject talentType2;

	[SerializeField]
	private GameObject upLevelDesPanel;

	[SerializeField]
	private TextMeshProUGUI talentNameText;

	[SerializeField]
	private TowerTalentItemView towerTalentType1;

	[SerializeField]
	private TowerTalentItemView towerTalentType2;

	[SerializeField]
	private TextMeshProUGUI CostItemCount;

	[SerializeField]
	private Image CostIcon;

	[SerializeField]
	private LoopListView2 talentLevelDes;

	[SerializeField]
	private MoneyView moneyView;

	[SerializeField]
	private Button specialTalentBtn;

	[SerializeField]
	private GameObject specialPart;

	[SerializeField]
	private GameObject normalPart;

	[SerializeField]
	private GameObject specialTalentSelect;

	[SerializeField]
	private TextMeshProUGUI tagText;

	private TowerTalentStrengthViewModel viewModel;

	protected override void OnInit()
	{
		viewModel = GetData<TowerTalentStrengthViewModel>();
		BindingSet<TowerTalentStrengthenWindow, TowerTalentStrengthViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((TowerTalentStrengthenWindow v) => v.OnDismissRequest).To((TowerTalentStrengthViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(upTalentLevelBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((TowerTalentStrengthViewModel vm) => vm.SelectTalent.Data.UnLock && vm.SelectTalent.Data.TalntLevel < vm.SelectTalent.Data.MaxLevel);
		bindingSet.Bind(maxLevelGo).For((GameObject v) => v.activeSelf).ToExpression((TowerTalentStrengthViewModel vm) => !vm.ShowNormal || vm.SelectTalent.Data.TalntLevel >= vm.SelectTalent.Data.MaxLevel);
		bindingSet.Bind(upLevelDes.gameObject).For((GameObject v) => v.activeSelf).ToExpression((TowerTalentStrengthViewModel vm) => vm.SelectTalent.Data.TalntLevel < vm.SelectTalent.Data.MaxLevel);
		bindingSet.Bind(lockBtnGo).For((GameObject v) => v.activeSelf).ToExpression((TowerTalentStrengthViewModel vm) => !vm.SelectTalent.Data.UnLock);
		bindingSet.Bind<TextMeshProUGUI>(talentDes).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TowerTalentStrengthViewModel vm) => vm.TalentDes);
		bindingSet.Bind<TextMeshProUGUI>(upTalentLevelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TowerTalentStrengthViewModel vm) => vm.UpLevelBtnText);
		bindingSet.Bind<TextMeshProUGUI>(upLevelCostText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TowerTalentStrengthViewModel vm) => $"<color={((vm.CostData.Amount < vm.CostNum) ? unEnoughColor : normalColor)}>{vm.CostData.Amount}</color>/{vm.CostNum}");
		bindingSet.Bind(talentType1).For((GameObject v) => v.activeSelf).To((TowerTalentStrengthViewModel vm) => vm.ShowType1);
		bindingSet.Bind(talentType2).For((GameObject v) => v.activeSelf).ToExpression((TowerTalentStrengthViewModel vm) => !vm.ShowType1);
		bindingSet.Bind<TextMeshProUGUI>(talentNameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TowerTalentStrengthViewModel vm) => vm.TalentName);
		bindingSet.Bind<TextMeshProUGUI>(CostItemCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TowerTalentStrengthViewModel vm) => vm.CostData.Amount);
		bindingSet.Bind(CostIcon).For((Image v) => v.sprite).To((TowerTalentStrengthViewModel vm) => vm.CostData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind().For((TowerTalentStrengthenWindow v) => v.OnSelectChange).To((TowerTalentStrengthViewModel vm) => vm.ChangeSelectRequest);
		bindingSet.Bind(specialPart).For((GameObject v) => v.activeSelf).ToExpression((TowerTalentStrengthViewModel vm) => !vm.ShowNormal);
		bindingSet.Bind(normalPart).For((GameObject v) => v.activeSelf).To((TowerTalentStrengthViewModel vm) => vm.ShowNormal);
		bindingSet.Bind(specialTalentSelect).For((GameObject v) => v.activeSelf).ToExpression((TowerTalentStrengthViewModel vm) => !vm.ShowNormal);
		bindingSet.Bind(specialTalentBtn).For((Button v) => v.onClick).To((TowerTalentStrengthViewModel vm) => vm.OptCmd)
			.CommandParameter("ClickSpecialTalent");
		bindingSet.Bind<TextMeshProUGUI>(tagText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TowerTalentStrengthViewModel vm) => vm.SelectTalent.Data.TalentTag);
		bindingSet.Build();
		for (int num = 0; num < towerTalentItemViews.Count; num++)
		{
			viewModel.TowerTalentViewModels.TryGetValue(towerTalentItemViews[num].TalentId, out var value);
			towerTalentItemViews[num].Init(value);
		}
		moneyView.Init(new MoneyViewModel(viewModel));
		upLevelDesPanel.SetActive(value: false);
		InitListView();
		backButton.onClick.AddListener(Close);
		upTalentLevelBtn.onClick.AddListener(UpTalentLevel);
		resetTalentBtn.onClick.AddListener(ResetTalentLevel);
		upLevelDes.onClick.AddListener(ShowUpLevelDes);
		upLevelClose.onClick.AddListener(CloseUpLevelDes);
		towerTalentType1.Init(viewModel.SelectTalent);
		towerTalentType2.Init(viewModel.SelectTalent);
		moneyView.SetShow(RoleMoneyEnum.TowerTalent);
	}

	private new void Close()
	{
		viewModel.Close();
	}

	private void UpTalentLevel()
	{
		viewModel.UpTalentLevel();
	}

	private void ResetTalentLevel()
	{
		IAsyncResult<int> result = AlertDialog.Show("提示", "全部天赋即将重置并返还所消耗的材料。是否确定重置？", "同意", "拒绝");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				viewModel.ResetTalentLevel();
			}
		});
	}

	private void ShowUpLevelDes()
	{
		upLevelDesPanel.SetActive(value: true);
		talentLevelDes.SetListItemCount(viewModel.TalentLevelDesList.Count);
		talentLevelDes.RefreshAllShownItem();
	}

	private void CloseUpLevelDes()
	{
		upLevelDesPanel.SetActive(value: false);
	}

	private void OnSelectChange(object sender, InteractionEventArgs args)
	{
		towerTalentType1.RefreshData(viewModel.SelectTalent);
		towerTalentType2.RefreshData(viewModel.SelectTalent);
	}

	private void InitListView()
	{
		talentLevelDes.InitListView(viewModel.TalentLevelDesList.Count, OnGetAttributeItemByIndex);
	}

	private LoopListViewItem2 OnGetAttributeItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TalentLevelDesList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("LevelItem");
		if (loopListViewItem != null)
		{
			TowerTalentLevelItemView component = loopListViewItem.GetComponent<TowerTalentLevelItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.TalentLevelDesList[index]);
				component.SetFitter();
			}
			else
			{
				component.RefreshData(viewModel.TalentLevelDesList[index]);
				component.SetFitter();
			}
		}
		return loopListViewItem;
	}
}
