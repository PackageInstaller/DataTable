namespace ACT.UI;

public class MailboxPanelUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.Panel;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool RequireCatchScreen => true;

	public override bool RequireBlurBackGround => true;

	public override bool RequirePauseGame => true;
}
