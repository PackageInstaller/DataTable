namespace ACT.UI;

[UIPreload(DeviceMemoryTier.Memory12GB)]
[UILifecyclePolicy(DeviceMemoryTier.Memory6GB, UILifetimePolicy.Immediate)]
public class DeparturePackageUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.PopUp;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool RequireBlurBackGround => true;
}
