using System;

namespace ACT.UI;

public class UIData
{
	public string mobilePath;

	public string pcPath;

	public UI_LAYER layer;

	public Type UIController;

	public UIPanelType PanelType;

	public bool IsConnectSystem;

	public int SystemId;

	public bool DisableInputOnTransition;

	public bool RequireBlackScreenTransition;

	public UITransitionStrategy TransitionStrategy;

	public UIInstanceStrategy InstanceStrategy;

	public UILifetimePolicy? RuntimeLifetimePolicy;

	public string GetPcPath()
	{
		if (string.IsNullOrEmpty(pcPath))
		{
			return mobilePath;
		}
		return pcPath;
	}
}
