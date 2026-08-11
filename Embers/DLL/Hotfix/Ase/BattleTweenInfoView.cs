using UnityEngine;

namespace Ase;

public class BattleTweenInfoView : UGuiView
{
	[SerializeField]
	private BattleExpUpView battleExpUpView;

	[SerializeField]
	private BattleDropInfoView battleDropInfoView;

	private BattleTweenInfoViewModel _viewModel;

	public void Init(BattleTweenInfoViewModel viewModel)
	{
		_viewModel = viewModel;
		OnInit();
	}

	private void OnInit()
	{
		if (_viewModel.ExpUpViewModel != null)
		{
			battleExpUpView.Init(_viewModel.ExpUpViewModel);
		}
		if (_viewModel.DropInfoViewModel != null)
		{
			battleDropInfoView.Init(_viewModel.DropInfoViewModel);
		}
	}
}
