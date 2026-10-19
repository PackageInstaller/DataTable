using System;

namespace ACT.UI.Interface;

public interface ITabItem
{
	int TabIdentify { get; set; }

	ITabContent Content { get; set; }

	int TabName { get; set; }

	Func<bool> CanActive { get; set; }
}
