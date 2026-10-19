namespace ACT.UI;

public class WebViewForWindowsUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.PopUp;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override int? ForceSortingLayer => 51;
}
