namespace ACT.UI;

[UIPreload(DeviceMemoryTier.Memory12GB)]
[UILifecyclePolicy(DeviceMemoryTier.Memory6GB, UILifetimePolicy.Immediate)]
public class CardDrawUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.Panel;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool RequireBlackScreenTransition => true;

	public override bool RequireCatchScreen => false;
}
