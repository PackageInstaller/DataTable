namespace ACT.UI;

[UIPreload(DeviceMemoryTier.Memory12GB)]
[UILifecyclePolicy(DeviceMemoryTier.Memory6GB, UILifetimePolicy.Immediate)]
public class BagPanelUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.Panel;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool RequireBlurBackGround => true;

	public override int SortingLayerCount => 4;
}
