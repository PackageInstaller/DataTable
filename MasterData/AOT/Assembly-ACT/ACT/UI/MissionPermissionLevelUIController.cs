namespace ACT.UI;

public class MissionPermissionLevelUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.Panel;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool DisableInputOnTransition => true;

	public override bool RequireBlackScreenTransition => false;

	public override bool RequireBlurBackGround => true;

	public override UITransitionStrategy TransitionStrategy => UITransitionStrategy.CrossFade;

	public override UIInstanceStrategy InstanceStrategy => UIInstanceStrategy.SingleInstance;
}
