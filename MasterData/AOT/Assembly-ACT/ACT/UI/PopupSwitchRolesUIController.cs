namespace ACT.UI;

public class PopupSwitchRolesUIController : BaseUIController
{
	private PopupSwitchRolesView _popupSwitchRolesView;

	public override UIPanelType PanelType => UIPanelType.PopUp;

	public override bool RequireBlurBackGround => true;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	protected override void OnInit()
	{
		base.OnInit();
	}

	protected override void OnUnInit()
	{
		base.OnUnInit();
	}
}
