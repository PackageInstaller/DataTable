using GameFramework.Runtime;

namespace Ase;

public class LevelFailWindow : UGuiWindow
{
	private LevelFailViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<LevelFailViewModel>();
		if (viewModel == null)
		{
			Close();
			return;
		}
		BindingSet<LevelFailWindow, LevelFailViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((LevelFailWindow v) => v.OnCloseRequest).To((LevelFailViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
	}

	private void OnCloseRequest(object sender, InteractionEventArgs e)
	{
		Close();
	}

	public override bool CloseInversion()
	{
		if (viewModel != null && !viewModel.IsCloseView)
		{
			viewModel.Close();
			return true;
		}
		return base.CloseInversion();
	}
}
