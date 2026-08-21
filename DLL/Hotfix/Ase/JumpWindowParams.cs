using System;
using System.Collections.Generic;

namespace Ase;

[Serializable]
public struct JumpWindowParams
{
	public string WindowName;

	public List<object> Args;

	public JumpWindowParams(string windowName)
	{
		WindowName = windowName;
		Args = new List<object>();
	}

	public JumpWindowParams(string windowName, List<object> args)
	{
		WindowName = windowName;
		Args = args;
	}

	public JumpWindowParams(string windowName, List<int> args)
	{
		WindowName = windowName;
		Args = new List<object>();
		if (args == null)
		{
			return;
		}
		foreach (int arg in args)
		{
			Args.Add(arg);
		}
	}
}
