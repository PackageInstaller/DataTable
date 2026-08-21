using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CampaignTaskArea : CampaignAreaView
{
	[SerializeField]
	private Image finishedIcon;

	private CampaignTaskData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<CampaignTaskData>(userData);
		BindingSet<CampaignTaskArea, CampaignTaskData> bindingSet = this.CreateBindingSet(_viewModel);
		if (finishedIcon != null)
		{
			bindingSet.Bind(finishedIcon.gameObject).For((GameObject v) => v.activeSelf).To((CampaignTaskData vm) => vm.Finished);
		}
		bindingSet.Build();
	}
}
