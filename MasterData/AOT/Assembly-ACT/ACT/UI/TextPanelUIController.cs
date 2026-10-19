namespace ACT.UI;

[UIPreload(DeviceMemoryTier.Always)]
[UILifecyclePolicy(DeviceMemoryTier.Memory6GB, UILifetimePolicy.Immediate)]
public class TextPanelUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.PopUp;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool RequireBlurBackGround => true;

	public override bool RequireCatchScreen => true;
}
