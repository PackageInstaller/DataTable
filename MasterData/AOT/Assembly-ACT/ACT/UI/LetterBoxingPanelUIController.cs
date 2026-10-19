namespace ACT.UI;

public class LetterBoxingPanelUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.Panel;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool RequirePauseGame => false;

	public override bool RequireCatchScreen => false;
}
