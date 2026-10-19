namespace ACT.UI;

public class OneTreatScrapingPrizeUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.PopUp;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool RequireBlurBackGround => true;
}
