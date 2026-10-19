namespace ACT.UI;

public class PopupDownloadProcessUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.PopUp;

	public override bool RequireBlurBackGround => true;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;
}
