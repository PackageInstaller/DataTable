namespace ACT.UI;

public class AbyssPopUpRewardOneRowUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.PopUp;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool DisableInputOnTransition => true;

	public override bool RequireBlackScreenTransition => false;

	public override UITransitionStrategy TransitionStrategy => UITransitionStrategy.CrossFade;

	public override UIInstanceStrategy InstanceStrategy => UIInstanceStrategy.SingleInstance;
}
