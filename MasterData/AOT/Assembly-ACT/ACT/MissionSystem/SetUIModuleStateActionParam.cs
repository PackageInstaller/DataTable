using System;
using ACT.UI;

namespace ACT.MissionSystem;

[Serializable]
public class SetUIModuleStateActionParam
{
	public UIMode uiModule;

	public bool state;
}
