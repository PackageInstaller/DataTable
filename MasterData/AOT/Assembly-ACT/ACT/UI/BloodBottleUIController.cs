namespace ACT.UI;

public class BloodBottleUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.Panel;

	public override bool IsConnectSystem => false;

	public override int SystemId => 1026;

	public override bool RequireCatchScreen => false;

	public override bool RequireBlurBackGround => (_data as BloodBottleViewData)?.needFuzzy ?? false;
}
