namespace ACT.UI;

[UIPreload(DeviceMemoryTier.Always)]
[UILifecyclePolicy(DeviceMemoryTier.Memory4GB, UILifetimePolicy.Immediate)]
public class EscUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.Panel;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool RequireBlurBackGround => true;
}
