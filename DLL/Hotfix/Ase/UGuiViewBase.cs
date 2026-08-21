namespace Ase;

public class UGuiViewBase : UGuiView
{
	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		if (base.PageId == 0)
		{
			ViewConfig[] viewConfigs = ViewConfigSetting.GetViewConfigs((ViewConfig p) => p.ViewClass.Equals(GetType().FullName));
			if (viewConfigs != null && viewConfigs.Length != 0)
			{
				base.PageId = viewConfigs[0].Id;
				base.PageType = viewConfigs[0].PageType;
			}
		}
	}

	public override void AfterOpenView()
	{
		SendViewEvent(isOpen: true);
	}

	public override void AfterCloseView()
	{
		SendViewEvent(isOpen: false);
	}

	private void SendViewEvent(bool isOpen)
	{
		if (!string.IsNullOrEmpty(base.PageType))
		{
			if (isOpen)
			{
				TDAHandler.Instance.SendViewStart(base.PageId, (base.PageType == null) ? "" : base.PageType, (base.Entrance == null) ? "default" : base.Entrance);
			}
			else
			{
				TDAHandler.Instance.SendViewEnd(base.PageId, (base.PageType == null) ? "" : base.PageType, (base.Entrance == null) ? "default" : base.Entrance);
			}
		}
	}
}
