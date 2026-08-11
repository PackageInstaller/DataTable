using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class CampaignBuildingArea : CampaignAreaView
{
	[SerializeField]
	private GameObject upgradeEffect;

	private CampaignBuildingData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<CampaignBuildingData>(userData);
		BindingSet<CampaignBuildingArea, CampaignBuildingData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(upgradeEffect).For((GameObject v) => v.activeSelf).To((CampaignBuildingData vm) => vm.Upgrade);
		bindingSet.Build();
	}
}
