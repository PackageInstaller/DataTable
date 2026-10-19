namespace ACT.UI;

public class ShareUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.PopUp;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override UILifetimePolicy LifetimePolicy => UILifetimePolicy.Immediate;

	public override bool RequireBlurBackGround => true;
}
