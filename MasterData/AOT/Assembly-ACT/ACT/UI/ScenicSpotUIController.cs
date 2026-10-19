using ACT.Drama;

namespace ACT.UI;

public class ScenicSpotUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.PopUp;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool RequireBlurBackGround => true;

	protected override void OnOpen()
	{
		base.OnOpen();
		AsideManager.instance.PushPlaybackBlock(this);
	}

	protected override void OnClosed()
	{
		try
		{
			base.OnClosed();
		}
		finally
		{
			AsideManager.instance.PopPlaybackBlock(this);
		}
	}

	protected override void OnUnInit()
	{
		try
		{
			base.OnUnInit();
		}
		finally
		{
			AsideManager.instance.PopPlaybackBlock(this);
		}
	}
}
