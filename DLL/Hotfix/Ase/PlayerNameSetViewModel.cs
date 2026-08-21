using System.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class PlayerNameSetViewModel : PlayerNameSetViewModelBase
{
	private InteractionRequest<Notification> toastRequest;

	private NameSetMode nameSetMode;

	private TabItemNormalData maleData;

	private TabItemNormalData femaleData;

	private InteractionRequest playNextAnimationRequest;

	private InteractionRequest playExitAnimationRequest;

	public int Result { get; set; }

	public NameSetMode NameSetMode
	{
		get
		{
			return nameSetMode;
		}
		private set
		{
			Set(ref nameSetMode, value, "NameSetMode");
		}
	}

	public TabItemNormalData MaleData
	{
		get
		{
			return maleData;
		}
		private set
		{
			Set(ref maleData, value, "MaleData");
		}
	}

	public TabItemNormalData FemaleData
	{
		get
		{
			return femaleData;
		}
		private set
		{
			Set(ref femaleData, value, "FemaleData");
		}
	}

	public IInteractionRequest ToastRequest => toastRequest;

	public InteractionRequest PlayNextAnimationRequest => playNextAnimationRequest;

	public InteractionRequest PlayExitAnimationRequest => playExitAnimationRequest;

	public PlayerNameSetViewModel(OptionBase parent, NameSetMode nameSetMode)
		: base(parent)
	{
		this.nameSetMode = nameSetMode;
		toastRequest = new InteractionRequest<Notification>(this);
		playNextAnimationRequest = new InteractionRequest();
		playExitAnimationRequest = new InteractionRequest();
		if (nameSetMode == NameSetMode.Create)
		{
			RandomName();
		}
		maleData = new TabItemNormalData(this, string.Empty);
		femaleData = new TabItemNormalData(this, string.Empty, 1);
		Result = 0;
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is TabItemNormalData { IsSelected: false } tabItemNormalData)
		{
			maleData.IsSelected = tabItemNormalData.ID == maleData.ID;
			femaleData.IsSelected = tabItemNormalData.ID == femaleData.ID;
		}
	}

	protected override async void Confirm()
	{
		if (!confirmCommand.Enabled)
		{
			return;
		}
		confirmCommand.Enabled = false;
		bool flag = true;
		Loading loading = await Loading.Show();
		if (ValidateName())
		{
			IAccountService.ChangeRoleResult changeRoleResult = null;
			if (nameSetMode == NameSetMode.Create)
			{
				int gender = (MaleData.IsSelected ? 1 : 2);
				changeRoleResult = await Singleton<ServiceSystem>.Instance.GetService<IAccountService>().CreateUser(nameInput, gender);
			}
			if (changeRoleResult != null && changeRoleResult.Code == 0)
			{
				base.ValidateTip = "<color=green>设置成功</color>";
				flag = false;
			}
		}
		confirmCommand.Enabled = flag;
		loading.Dispose();
		if (!flag)
		{
			playExitAnimationRequest.Raise();
			await Task.Delay(1500);
			Close();
		}
	}

	public void NextStepOnClick()
	{
		playNextAnimationRequest.Raise();
		ItemOnClick(MaleData);
	}

	public async void SetError()
	{
		Result = 999;
		await Task.Delay(1500);
		Close();
	}
}
