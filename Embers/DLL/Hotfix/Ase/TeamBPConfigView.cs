using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class TeamBPConfigView : UGuiView
{
	[SerializeField]
	private BPCarryItemView v1;

	[SerializeField]
	private BPCarryItemView v2;

	private TeamBPConfigViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (userData != null)
		{
			viewModel = GetUserData<TeamBPConfigViewModel>(userData);
			BindingSet<TeamBPConfigView, TeamBPConfigViewModel> bindingSet = this.CreateBindingSet(viewModel);
			bindingSet.Bind(this).For((TeamBPConfigView v) => v.RefreshView).To((TeamBPConfigViewModel vm) => vm.RefreshDataRequest);
			bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).To((TeamBPConfigViewModel vm) => vm.ShowConfigView);
			bindingSet.Build();
			v1.Init(viewModel.Vm1);
			v2.Init(viewModel.Vm2);
			base.gameObject.AddComponent<ViewSOControl>().AddOpenAction(delegate
			{
				viewModel.CheckOpen();
			});
		}
	}

	private void RefreshView(object sender, InteractionEventArgs e)
	{
		v1.Init(viewModel.Vm1);
		v2.Init(viewModel.Vm2);
	}

	public override void RefreshData(object userData)
	{
		if (viewModel == null)
		{
			OnInit(userData);
			return;
		}
		viewModel = GetUserData<TeamBPConfigViewModel>(userData);
		this.SetDataContext(viewModel);
		v1.Init(viewModel.Vm1);
		v2.Init(viewModel.Vm2);
		base.gameObject.AddComponent<ViewSOControl>().AddOpenAction(delegate
		{
			viewModel.CheckOpen();
		});
	}
}
