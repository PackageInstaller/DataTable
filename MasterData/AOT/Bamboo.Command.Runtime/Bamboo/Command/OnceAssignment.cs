using System;

namespace Bamboo.Command;

public abstract class OnceAssignment : BaseAssignment
{
	internal override void Execute()
	{
		base.Execute();
		OnExecute();
		Release();
	}

	internal sealed override void Update(int delta)
	{
		throw new Exception("Don't call Update in OnceAssignment");
	}

	protected abstract void OnExecute();
}
