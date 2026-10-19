namespace ACT.UI;

public class PopUpChangeNameSignatureUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.PopUp;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool RequireBlurBackGround => true;

	public override bool DisableInputOnTransition => true;
}
