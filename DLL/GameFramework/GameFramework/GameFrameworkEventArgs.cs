using System;

namespace GameFramework;

public abstract class GameFrameworkEventArgs : EventArgs, IReference
{
	public GameFrameworkEventArgs()
	{
	}

	public abstract void Clear();
}
