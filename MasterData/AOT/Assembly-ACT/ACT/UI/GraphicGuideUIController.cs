namespace ACT.UI;

public class GraphicGuideUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.Panel;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool RequireBlurBackGround => true;

	protected override void OnInit()
	{
		base.OnInit();
	}

	protected override void OnUnInit()
	{
		base.OnUnInit();
	}

	protected override void OnPopStack()
	{
		base.OnPopStack();
	}
}
