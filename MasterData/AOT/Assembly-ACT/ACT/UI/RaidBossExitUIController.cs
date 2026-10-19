namespace ACT.UI;

public class RaidBossExitUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.Panel;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override UILifetimePolicy LifetimePolicy => UILifetimePolicy.Immediate;
}
