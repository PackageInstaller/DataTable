using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine.UI;

namespace Ase;

public class HeroCultivatePreviewWindow : HeroCultivateWindow
{
	private HCTalentPreviewView talentView;

	public SelectItemView oriBtn;

	public SelectItemView maxBtn;

	private HeroCultivatePreviewViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<HeroCultivatePreviewViewModel>();
		BindingSet<HeroCultivatePreviewWindow, HeroCultivatePreviewViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(oriBtn.btn).For((Button v) => v.onClick).To((HeroCultivatePreviewViewModel vm) => vm.OptCmd)
			.CommandParameter("PreviewOri");
		bindingSet.Bind(maxBtn.btn).For((Button v) => v.onClick).To((HeroCultivatePreviewViewModel vm) => vm.OptCmd)
			.CommandParameter("PreviewMax");
		bindingSet.Build();
		InitBtns();
	}

	protected override void InitTabToggles()
	{
		_tabToggleList = new List<TabToggle>();
		for (int i = 0; i < tabGroup.childCount; i++)
		{
			TabToggle component = tabGroup.GetChild(i).GetComponent<TabToggle>();
			component.enumId = i + 1;
			component.AddSelectedAction(base.OnTabClick);
			_tabToggleList.Add(component);
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

	private void InitBtns()
	{
		oriBtn.Init(viewModel.OriItem);
		maxBtn.Init(viewModel.MaxItem);
	}

	protected override void SettleOpt(string optName)
	{
		base.SettleOpt(optName);
		if (optName.Equals("ShowPreviewConfig"))
		{
			ShowPreviewBtn(isShow: true);
		}
		else if (optName.Equals("HidePreviewConfig"))
		{
			ShowPreviewBtn(isShow: false);
		}
	}

	protected override async UniTask<HeroCultivateView> GetPropertyView()
	{
		if (propertyView == null)
		{
			propertyView = await OpenView<HeroPropertyView>("Hero/HeroPropertyView", viewModel, entrance);
			propertyView.transform.SetParent(childViewRoot);
		}
		propertyView.previewConfig.gameObject.SetActive(value: false);
		ShowPreviewBtn(isShow: true);
		propertyView.RefreshAllSkillData();
		return propertyView;
	}

	protected override async UniTask<HeroCultivateView> GetSkillView()
	{
		if (talentView == null)
		{
			talentView = await OpenView<HCTalentPreviewView>("Hero/HCTalentPreviewView", viewModel.HeroTalentViewModel, entrance);
			talentView.transform.SetParent(childViewRoot);
			talentView.OnInitAfter();
		}
		ShowPreviewBtn(isShow: true);
		return talentView;
	}

	protected override async UniTask<HeroGrowRarityView> GetGrowRarityView()
	{
		ShowPreviewBtn(isShow: false);
		HeroGrowRarityView obj = await base.GetGrowRarityView();
		obj.SetInPreviewMode(inPreview: true);
		return obj;
	}

	protected override async void GetGrowRarityInfoView()
	{
		if (growRarityInfoView == null)
		{
			growRarityInfoView = await OpenView<HeroGrowRarityInfoView>("Hero/HeroGrowRarityInfoView", _viewModel.GrowRarityInfoViewModel, entrance);
			growRarityInfoView.transform.SetParent(overlayViewRoot);
			growRarityInfoView.SetInPreviewMode(inPreview: true);
		}
	}

	protected override UniTask<HeroCultivateView> GetWeaponView()
	{
		ShowPreviewBtn(isShow: false);
		return base.GetWeaponView();
	}

	private void ShowPreviewBtn(bool isShow)
	{
		oriBtn.gameObject.SetActive(isShow);
		maxBtn.gameObject.SetActive(isShow);
	}
}
