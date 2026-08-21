using GameFramework.Runtime;

namespace Ase;

public class UGuiWindowBase : UGuiWindow
{
	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
	}

	protected override void AfterOpenView()
	{
		SendViewEvent(isOpen: true);
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		SendViewEvent(isOpen: false);
	}

	private void SendViewEvent(bool isOpen)
	{
		if (!string.IsNullOrEmpty(pageType))
		{
			if (isOpen)
			{
				TDAHandler.Instance.SendViewStart(pageId, (pageType == null) ? "" : pageType, (entrance == null) ? "default" : entrance);
			}
			else
			{
				TDAHandler.Instance.SendViewEnd(pageId, (pageType == null) ? "" : pageType, (entrance == null) ? "default" : entrance);
			}
		}
	}
}
