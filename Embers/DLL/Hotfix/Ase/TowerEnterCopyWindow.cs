using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TowerEnterCopyWindow : UGuiWindow
{
	[SerializeField]
	private TeamBPConfigView teamBpConfigView;

	[SerializeField]
	private List<TowerAreaInfo> towerAreaInfos;

	[SerializeField]
	private Button rewardBtn;

	[SerializeField]
	private Button backButton;

	[SerializeField]
	private Button showRewardBtn;

	[SerializeField]
	private Button showDesBtn;

	[SerializeField]
	private Button talentStrengthBtn;

	[SerializeField]
	private Button selectHeroBtn;

	[SerializeField]
	private TowerCopyDetailView towerCopyDetailView;

	[SerializeField]
	private GameObject rewardPart;

	[SerializeField]
	private GameObject desPart;

	[SerializeField]
	private Image selectHeroIcon;

	[SerializeField]
	private Button startChallenge;

	[SerializeField]
	private GameObject lockChallenge;

	[SerializeField]
	private GameObject rewardRedPointImg;

	[SerializeField]
	private TextMeshProUGUI rewaradNum;

	[SerializeField]
	private GameObject talentPointRed;

	private TowerEnterCopyViewModel viewModel;

	private TowerAreaInfo towerAreaInfo;

	protected override void OnInit()
	{
		base.OnInit();
		viewModel = GetData<TowerEnterCopyViewModel>();
		BindingSet<TowerEnterCopyWindow, TowerEnterCopyViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((TowerEnterCopyWindow v) => v.OnDismissRequest).To((TowerEnterCopyViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((TowerEnterCopyWindow v) => v.OnSelectChange).To((TowerEnterCopyViewModel vm) => vm.ChangeSelectRequest);
		bindingSet.Bind().For((TowerEnterCopyWindow v) => v.OpenUguiWindow).To((TowerEnterCopyViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(selectHeroBtn).For((Button v) => v.onClick).To((TowerEnterCopyViewModel vm) => vm.OpenHeroSelectWindow);
		bindingSet.Bind(selectHeroIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((TowerEnterCopyViewModel vm) => vm.SelectHeroId != 0);
		bindingSet.Bind(startChallenge.gameObject).For((GameObject v) => v.activeSelf).To((TowerEnterCopyViewModel vm) => vm.SelectLevelItem.UnLock);
		bindingSet.Bind(lockChallenge).For((GameObject v) => v.activeSelf).ToExpression((TowerEnterCopyViewModel vm) => !vm.SelectLevelItem.UnLock);
		bindingSet.Bind(selectHeroIcon).For((Image v) => v.sprite).ToExpression((TowerEnterCopyViewModel vm) => HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.SquareSmall, vm.SelectHeroId, vm.HeroSkinSuffix, vm.SkinConfigId))
			.WithConversion("ItemIcon");
		bindingSet.Bind(rewardBtn).For((Button v) => v.onClick).To((TowerEnterCopyViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenRewardWindow");
		bindingSet.Bind(rewardRedPointImg).For((GameObject v) => v.activeSelf).To((TowerEnterCopyViewModel vm) => vm.RewardRedPoint);
		bindingSet.Bind<TextMeshProUGUI>(rewaradNum).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TowerEnterCopyViewModel vm) => vm.RewardNum);
		bindingSet.Build();
		backButton.onClick.AddListener(OnClickBack);
		startChallenge.onClick.AddListener(OnClickChanllenge);
		InitOtherItem();
	}

	private void InitOtherItem()
	{
		for (int i = 0; i < towerAreaInfos.Count; i++)
		{
			if (viewModel.AreaIndex == i)
			{
				towerAreaInfos[i].gameObject.SetActive(value: true);
				for (int j = 0; j < towerAreaInfos[i].TowerCopyItemViews.Count; j++)
				{
					towerAreaInfos[i].TowerCopyItemViews[j].Init(viewModel.CopyItemVms[j]);
				}
				towerAreaInfo = towerAreaInfos[i];
			}
			else
			{
				towerAreaInfos[i].gameObject.SetActive(value: false);
			}
		}
		towerCopyDetailView.Init(viewModel.CopyDetailViewModel);
		teamBpConfigView.Init(viewModel.BpConfigViewModel);
		showRewardBtn.onClick.AddListener(OnClikShowRewardBtn);
		showDesBtn.onClick.AddListener(OnClikShowDesBtn);
		talentStrengthBtn.onClick.AddListener(OnClickTalentStrengthBtn);
		RedPointInfo();
	}

	private void RedPointInfo()
	{
		talentPointRed.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.TowerUpTalent).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).CanUpTalent)
			.Invoke();
	}

	private void OnClikShowRewardBtn()
	{
		rewardPart.SetActive(value: true);
		desPart.SetActive(value: false);
	}

	private void OnClikShowDesBtn()
	{
		rewardPart.SetActive(value: false);
		desPart.SetActive(value: true);
	}

	private async void OnClickTalentStrengthBtn()
	{
		TowerTalentStrengthViewModel userData = new TowerTalentStrengthViewModel();
		(await GameEntry.UI.LoadWindow<TowerTalentStrengthenWindow>("OperatingActivity/TownChallenge/TowerTalentStrengthenWindow", userData)).Show();
	}

	private void OnClickBack()
	{
		viewModel.Close();
	}

	private void OnClickChanllenge()
	{
		viewModel.EnterBattle();
	}

	private void OnSelectChange(object sender, InteractionEventArgs args)
	{
		towerCopyDetailView.RefreshData(viewModel.CopyDetailViewModel);
		for (int i = 0; i < towerAreaInfo.TowerCopyItemViews.Count; i++)
		{
			towerAreaInfo.TowerCopyItemViews[i].RefreshData(viewModel.CopyItemVms[i]);
		}
	}
}
