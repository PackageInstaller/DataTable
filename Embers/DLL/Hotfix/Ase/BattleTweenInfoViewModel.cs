namespace Ase;

public class BattleTweenInfoViewModel : OptionBase
{
	private BattleExpUpViewModel expUpViewModel;

	private BattleDropInfoViewModel dropInfoViewModel;

	public BattleExpUpViewModel ExpUpViewModel => expUpViewModel;

	public BattleDropInfoViewModel DropInfoViewModel => dropInfoViewModel;

	public BattleTweenInfoViewModel()
	{
	}

	public BattleTweenInfoViewModel(OptionBase parent)
	{
		base.parent = parent;
		if (Singleton<OuterSystem>.Instance != null && Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().GetGameProcess() == GameProcessType.Story && Singleton<ServiceSystem>.Instance.GetService<IRoleService>() != null)
		{
			expUpViewModel = new BattleExpUpViewModel(this);
		}
		dropInfoViewModel = new BattleDropInfoViewModel(this);
	}

	public void OnUpdate(float deltaTime)
	{
		expUpViewModel?.OnUpdate(deltaTime);
		dropInfoViewModel?.OnUpdate(deltaTime);
	}

	protected override void Dispose(bool disposing)
	{
		base.Dispose(disposing);
		if (expUpViewModel != null)
		{
			expUpViewModel.Dispose();
			expUpViewModel = null;
		}
		if (dropInfoViewModel != null)
		{
			dropInfoViewModel.Dispose();
			dropInfoViewModel = null;
		}
	}
}
