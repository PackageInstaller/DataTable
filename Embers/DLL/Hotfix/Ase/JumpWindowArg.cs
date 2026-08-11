using System;
using System.Collections.Generic;

namespace Ase;

[Serializable]
public struct JumpWindowArg
{
	public string WindowName;

	public List<int> Args;

	public JumpWindowParams ConvertToParams()
	{
		List<object> args = new List<object>();
		Args?.ForEach(delegate(int p)
		{
			args.Add(p);
		});
		return new JumpWindowParams
		{
			WindowName = WindowName,
			Args = args
		};
	}
}
