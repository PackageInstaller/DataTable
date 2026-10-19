namespace ACT.UI;

public class NetworkFluctuationUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.Toast;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;
}
