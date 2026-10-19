namespace ACT.UI;

[UIPreload(DeviceMemoryTier.Always)]
[UILifecyclePolicy(DeviceMemoryTier.Memory4GB, UILifetimePolicy.Immediate)]
public class FullScreenVideoUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.Panel;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool DisableInputOnTransition => true;

	public override bool RequireBlackScreenTransition => true;

	public override UITransitionStrategy TransitionStrategy => UITransitionStrategy.CrossFade;

	public override UIInstanceStrategy InstanceStrategy => UIInstanceStrategy.SingleInstance;
}
