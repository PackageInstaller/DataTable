namespace ACT.UI;

public class MineTrainOperateMobileUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.Panel;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool RequirePauseGame => false;

	public override bool RequireCatchScreen => false;
}
