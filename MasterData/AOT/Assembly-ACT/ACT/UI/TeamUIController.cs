namespace ACT.UI;

[UIPreload(DeviceMemoryTier.Memory12GB)]
[UILifecyclePolicy(DeviceMemoryTier.Memory6GB, UILifetimePolicy.Immediate)]
public class TeamUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.Panel;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool RequireBlackScreenTransition => true;

	public override bool RequireCatchScreen => false;

	protected override void OnPopStack()
	{
		if (_uiView is TeamView { BloodBottleBar: { IsNormal: not false } } teamView)
		{
			teamView.BloodBottleBar.Refresh();
		}
	}
}
