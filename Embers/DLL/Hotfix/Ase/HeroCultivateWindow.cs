using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroCultivateWindow : UGuiWindow
{
	[SerializeField]
	private Button backBtn;

	[SerializeField]
	protected Transform tabGroup;

	[SerializeField]
	private HeroInfoView heroInfoView;

	[SerializeField]
	protected Transform childViewRoot;

	[SerializeField]
	protected Transform overlayViewRoot;

	protected HeroPropertyView propertyView;

	private HeroWeaponView weaponView;

	private HeroEquipView equipView;

	private HCTalentView talentView;

	private HeroGrowRarityView growRarityView;

	protected HeroGrowRarityInfoView growRarityInfoView;

	[SerializeField]
	private GameObject arrowPart;

	[SerializeField]
	private Button leftArrowBtn;

	[SerializeField]
	private Image leftHeroIcon;

	[SerializeField]
	private Button rightArrowBtn;

	[SerializeField]
	private Image rightHeroIcon;

	[SerializeField]
	private GameObject windowMask;

	[SerializeField]
	private TextMeshProUGUI windowMaskTips;

	[SerializeField]
	private float voiceDelayTime = 0.5f;

	[SerializeField]
	private HeroWeaponDescView _weaponDescView;

	protected List<TabToggle> _tabToggleList;

	protected HeroCultivateViewModel _viewModel;

	private bool uiVisible = true;

	private bool _viewLoading;

	private int voiceId;

	private void Update()
	{
		if (!(_viewModel.WindowMaskLeftTime <= 0f))
		{
			_viewModel.WindowMaskLeftTime -= Time.deltaTime;
		}
	}

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<HeroCultivateViewModel>();
		BindingSet<HeroCultivateWindow, HeroCultivateViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((HeroCultivateWindow v) => v.OpenUguiWindow).To((HeroCultivateViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((HeroCultivateWindow v) => v.SetChildViewVisibility).To((HeroCultivateViewModel vm) => vm.ShowViewRequest);
		bindingSet.Bind().For((HeroCultivateWindow v) => v.RefreshSelectionInfo).To((HeroCultivateViewModel vm) => vm.OnRefreshRequest);
		bindingSet.Bind().For((HeroCultivateWindow v) => v.PlayUiVisibleAnimation).To((HeroCultivateViewModel vm) => vm.PlayUiVisibleAnimation);
		bindingSet.Bind().For((HeroCultivateWindow v) => v.ShowDetailPropView).To((HeroCultivateViewModel vm) => vm.OnShowDetailPropViewRequest);
		bindingSet.Bind().For((HeroCultivateWindow v) => v.RefreshArmourRedPoint).To((HeroCultivateViewModel vm) => vm.OnRefreshEquipRequest);
		bindingSet.Bind().For((HeroCultivateWindow v) => v.PlayVoice).To((HeroCultivateViewModel vm) => vm.PlayVoiceRst);
		bindingSet.Bind(leftHeroIcon.gameObject).For((GameObject v) => v.activeSelf).To((HeroCultivateViewModel vm) => vm.ChangeHeroEnable);
		bindingSet.Bind(rightHeroIcon.gameObject).For((GameObject v) => v.activeSelf).To((HeroCultivateViewModel vm) => vm.ChangeHeroEnable);
		bindingSet.Bind(leftHeroIcon).For((Image v) => v.sprite).ToExpression((HeroCultivateViewModel vm) => HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.Upgrade, vm.LeftHero))
			.WithConversion("ItemIcon");
		bindingSet.Bind(rightHeroIcon).For((Image v) => v.sprite).ToExpression((HeroCultivateViewModel vm) => HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.Upgrade, vm.RightHero))
			.WithConversion("ItemIcon");
		bindingSet.Bind(backBtn).For((Button v) => v.onClick).To((HeroCultivateViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind().For((HeroCultivateWindow v) => v.OnDismissRequest).To((HeroCultivateViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((HeroCultivateWindow v) => v.SetGrowRarityInfoViewVisible).To((HeroCultivateViewModel vm) => vm.SetGrowRarityInfoViewVisible);
		bindingSet.Bind().For((HeroCultivateWindow v) => v.OnOpt).To((HeroCultivateViewModel vm) => vm.OptRequest);
		bindingSet.Bind(windowMask).For((GameObject v) => v.activeSelf).ToExpression((HeroCultivateViewModel vm) => vm.WindowMaskLeftTime > 0f);
		bindingSet.Bind<TextMeshProUGUI>(windowMaskTips).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroCultivateViewModel vm) => $"遮罩剩余时间：{vm.WindowMaskLeftTime}");
		bindingSet.Build();
		leftArrowBtn.onClick.AddListener(delegate
		{
			_viewModel.ChangeHeroModel(-1);
		});
		rightArrowBtn.onClick.AddListener(delegate
		{
			_viewModel.ChangeHeroModel(1);
		});
		heroInfoView.Init(_viewModel.HeroInfoViewModel, _viewModel.ChangeHeroEnable);
		InitTabToggles();
	}

	protected virtual void InitTabToggles()
	{
		_tabToggleList = new List<TabToggle>();
		for (int i = 0; i < tabGroup.childCount; i++)
		{
			TabToggle component = tabGroup.GetChild(i).GetComponent<TabToggle>();
			component.enumId = i + 1;
			component.AddSelectedAction(OnTabClick);
			_tabToggleList.Add(component);
			if (!_viewModel.IsSelf)
			{
				continue;
			}
			if (i == 3)
			{
				component.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.HeroTalentNewLayer).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).HeroTalent.IndexOf(_viewModel.HeroModel.Id) >= 0)
					.Invoke();
			}
			if (i == 4)
			{
				component.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.HeroDestinyEnabled).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).HeroSeats.Exists((DRHeroSeat p) => p.HeroId.Equals(_viewModel.HeroModel.Id)))
					.Invoke();
			}
			if (i == 2)
			{
				_tabToggleList[2].transform.Find("normal")?.transform.Find("RedPoint")?.gameObject.SetActive(_viewModel.ArmourRedPoint);
				_tabToggleList[2].transform.Find("selected")?.transform.Find("RedPoint")?.gameObject.SetActive(_viewModel.ArmourRedPoint);
			}
		}
		if (_tabToggleList.Count > _viewModel.CurTabType - 1)
		{
			_tabToggleList[_viewModel.CurTabType - 1].isOn = true;
		}
		else
		{
			_tabToggleList[0].isOn = true;
		}
	}

	private void RefreshSelectionInfo(object sender, InteractionEventArgs e)
	{
		if (_tabToggleList.Count > 4)
		{
			_tabToggleList[4].GetComponent<UIRedPoint>()?.Invoke();
			RefreshArmourRedPoint();
		}
		if (_tabToggleList.Count > 3)
		{
			_tabToggleList[3].GetComponent<UIRedPoint>()?.Invoke();
		}
	}

	private void RefreshArmourRedPoint(object sender = null, InteractionEventArgs e = null)
	{
		if (_tabToggleList.Count > 3)
		{
			_tabToggleList[2].transform.Find("normal")?.transform.Find("RedPoint")?.gameObject.SetActive(_viewModel.ArmourRedPoint);
			_tabToggleList[2].transform.Find("selected")?.transform.Find("RedPoint")?.gameObject.SetActive(_viewModel.ArmourRedPoint);
		}
	}

	protected async void OnTabClick(int enumId)
	{
		if (!_viewLoading)
		{
			_viewLoading = true;
			HeroCultivateView lastView = await GetViewByTypeEnum(_viewModel.CurTabType);
			_viewModel.CurTabType = enumId;
			HeroCultivateView heroCultivateView = await GetViewByTypeEnum(enumId);
			if (heroCultivateView != null)
			{
				heroCultivateView.Show();
				heroInfoView.ViewSetting(heroCultivateView.ShowHeroFimage ? 1f : 0.1f);
				arrowPart.SetActive(heroCultivateView.ShowArrowPart);
				weaponView?.HideEntryInfoView();
				equipView?.HideEntryInfoView();
			}
			if (lastView != null && heroCultivateView != lastView)
			{
				lastView.Hide();
			}
			_viewLoading = false;
		}
	}

	private async void ShowDetailPropView(object sender, InteractionEventArgs e)
	{
		PropertyDetailViewModel userData = (PropertyDetailViewModel)e.Context;
		await GameEntry.UI.OpenWindow<PropertyDetailWindow>("Property/PropertyDetailWindow", userData);
	}

	private async UniTask<HeroCultivateView> GetViewByTypeEnum(int tabEnumId)
	{
		return tabEnumId switch
		{
			1 => await GetPropertyView(), 
			2 => await GetWeaponView(), 
			3 => await GetEquipView(), 
			4 => await GetSkillView(), 
			5 => await GetGrowRarityView(), 
			_ => null, 
		};
	}

	protected virtual async UniTask<HeroCultivateView> GetPropertyView()
	{
		if (propertyView == null)
		{
			propertyView = await OpenView<HeroPropertyView>("Hero/HeroPropertyView", _viewModel, entrance);
			propertyView.transform.SetParent(childViewRoot);
		}
		propertyView.RefreshAllSkillData();
		return propertyView;
	}

	protected virtual async UniTask<HeroCultivateView> GetWeaponView()
	{
		if (weaponView == null)
		{
			weaponView = await OpenView<HeroWeaponView>("Hero/HeroWeaponView", _viewModel, entrance);
			weaponView.transform.SetParent(childViewRoot);
		}
		return weaponView;
	}

	private async UniTask<HeroCultivateView> GetEquipView()
	{
		if (equipView == null)
		{
			equipView = await OpenView<HeroEquipView>("Hero/HeroEquipView", _viewModel, entrance);
			equipView.transform.SetParent(childViewRoot);
		}
		return equipView;
	}

	protected virtual async UniTask<HeroCultivateView> GetSkillView()
	{
		if (talentView == null)
		{
			talentView = await OpenView<HCTalentView>("Hero/HCTalentView", _viewModel.HeroTalentViewModel, entrance);
			talentView.transform.SetParent(childViewRoot);
			talentView.OnInitAfter();
		}
		return talentView;
	}

	protected virtual async UniTask<HeroGrowRarityView> GetGrowRarityView()
	{
		if (growRarityView == null)
		{
			growRarityView = await OpenView<HeroGrowRarityView>("Hero/HeroGrowRarityView", _viewModel.GrowRarityViewModel, entrance);
			growRarityView.transform.SetParent(childViewRoot);
		}
		return growRarityView;
	}

	private async void SetGrowRarityInfoViewVisible(object sender, InteractionEventArgs e)
	{
		if ((bool)e.Context)
		{
			GetGrowRarityInfoView();
			if (growRarityInfoView != null)
			{
				growRarityInfoView.Visibility = true;
			}
		}
		else if (growRarityInfoView != null)
		{
			growRarityInfoView.Visibility = false;
		}
	}

	protected virtual async void GetGrowRarityInfoView()
	{
		if (growRarityInfoView == null)
		{
			growRarityInfoView = await OpenView<HeroGrowRarityInfoView>("Hero/HeroGrowRarityInfoView", _viewModel.GrowRarityInfoViewModel, entrance);
			growRarityInfoView.transform.SetParent(overlayViewRoot);
		}
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	protected virtual void SettleOpt(string optName)
	{
		if ("OpenWeaponDesc".Equals(optName))
		{
			_weaponDescView.Init(_viewModel.HeroWeaponDescViewModel);
			_weaponDescView.gameObject.SetActive(value: true);
		}
	}

	private void PlayUiVisibleAnimation(object sender, InteractionEventArgs e)
	{
		bool flag = (bool)e.Context;
		if (uiVisible != flag)
		{
			uiVisible = flag;
			Animator component = GetComponent<Animator>();
			if (component != null)
			{
				component.SetTrigger(flag ? "showUI" : "hideUI");
			}
			propertyView?.PlayVisibleAnimation(flag);
		}
	}

	private void PlayVoice(object sender, InteractionEventArgs e)
	{
		CancelInvoke("DoPlayVoice");
		_viewModel.VoiceGroup?.Stop();
		voiceId = (int)e.Context;
		Invoke("DoPlayVoice", voiceDelayTime);
	}

	private void DoPlayVoice()
	{
		_viewModel?.VoiceGroup.Play(voiceId);
	}

	protected override void OnShow()
	{
		base.OnShow();
		_viewModel.HeroModel = _viewModel.HeroModel;
	}

	protected override void OnDismiss()
	{
		heroInfoView.Clear();
		base.OnDismiss();
	}
}
