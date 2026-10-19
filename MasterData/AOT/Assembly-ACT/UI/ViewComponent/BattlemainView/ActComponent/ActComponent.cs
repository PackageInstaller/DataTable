using ACT.UI;

namespace UI.ViewComponent.BattlemainView.ActComponent;

public abstract class ActComponent : BaseUIComponent
{
	protected IBaseUIView m_UIView;

	public virtual void OnLoadComplete(IBaseUIView ui)
	{
		m_UIView = ui;
	}

	public virtual void BeforeDestroy()
	{
	}
}
