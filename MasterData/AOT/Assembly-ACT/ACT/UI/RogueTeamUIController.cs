namespace ACT.UI;

public class RogueTeamUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.Panel;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool RequireBlackScreenTransition => true;

	public override bool RequireCatchScreen => false;
}
