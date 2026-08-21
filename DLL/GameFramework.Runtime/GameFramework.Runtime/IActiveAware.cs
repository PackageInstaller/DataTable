using System;

namespace GameFramework.Runtime;

public interface IActiveAware
{
	bool IsActive { get; set; }

	event EventHandler IsActiveChanged;
}
