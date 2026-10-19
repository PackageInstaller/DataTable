namespace ACT.UI;

public class TriggerTutorialTipUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.Toast;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;
}
