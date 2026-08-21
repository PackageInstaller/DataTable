using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TowerActivityAreaWindow : UGuiWindow
{
	[SerializeField]
	private Button talentStrengthBtn;

	[SerializeField]
	private Button backBtn;

	[SerializeField]
	private Button rewardBtn;

	[SerializeField]
	private Button gameExplainBtn;

	[SerializeField]
	private GameObject rewardRedPointImg;

	[SerializeField]
	private TextMeshProUGUI rewaradNum;

	[SerializeField]
	private GameObject talentPointRed;

	[SerializeField]
	private List<ActivityTabItem2> activityTabItem2;

	[SerializeField]
	private Button btnRank;

	[SerializeField]
	private TextMeshProUGUI score;

	private TowerActivityAreaViewModel viewModel;

	protected override void OnInit()
	{
		viewModel = GetData<TowerActivityAreaViewModel>();
		base.OnInit();
		BindingSet<TowerActivityAreaWindow, TowerActivityAreaViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((TowerActivityAreaWindow v) => v.OnDismissRequest).To((TowerActivityAreaViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((TowerActivityAreaWindow v) => v.OpenUguiWindow).To((TowerActivityAreaViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(rewardBtn).For((Button v) => v.onClick).To((TowerActivityAreaViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenRewardWindow");
		bindingSet.Bind(gameExplainBtn).For((Button v) => v.onClick).To((TowerActivityAreaViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenGameExplain");
		bindingSet.Bind(rewardRedPointImg).For((GameObject v) => v.activeSelf).To((TowerActivityAreaViewModel vm) => vm.RewardRedPoint);
		bindingSet.Bind<TextMeshProUGUI>(rewaradNum).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TowerActivityAreaViewModel vm) => vm.RewardNum);
		bindingSet.Bind(btnRank).For((Button v) => v.onClick).To((TowerActivityAreaViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenRankWindow");
		bindingSet.Bind<TextMeshProUGUI>(score).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TowerActivityAreaViewModel vm) => vm.Score);
		bindingSet.Build();
		viewModel.GetTabLockFinishInfo();
		for (int num = 0; num < activityTabItem2.Count; num++)
		{
			activityTabItem2[num].Init(viewModel.ActivityTabItemData2[num]);
		}
		talentStrengthBtn.onClick.AddListener(OpenTowerTalentStrengthWindow);
		backBtn.onClick.AddListener(ClickBackBtn);
		RedPointInfo();
	}

	private async void OpenTowerTalentStrengthWindow()
	{
		TowerTalentStrengthViewModel userData = new TowerTalentStrengthViewModel();
		(await GameEntry.UI.LoadWindow<TowerTalentStrengthenWindow>("OperatingActivity/TownChallenge/TowerTalentStrengthenWindow", userData)).Show();
	}

	private void ClickBackBtn()
	{
		viewModel.Close();
	}

	private void RedPointInfo()
	{
		talentPointRed.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.TowerUpTalent).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).CanUpTalent)
			.Invoke();
	}
}
