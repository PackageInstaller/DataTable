using System.Collections.Generic;

namespace Ase;

public struct HomeComeTaskJumpConfig(string windowName, List<int> args)
{
	public string WindowName = windowName;

	public List<int> Args = args ?? new List<int>();
}
