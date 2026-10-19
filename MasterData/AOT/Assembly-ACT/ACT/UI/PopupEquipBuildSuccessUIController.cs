namespace ACT.UI;

public class PopupEquipBuildSuccessUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.PopUp;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool RequirePauseGame => false;

	public override bool RequireBlurBackGround => true;
}
