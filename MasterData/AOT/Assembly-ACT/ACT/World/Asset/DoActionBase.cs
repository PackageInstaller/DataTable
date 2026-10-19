using System;
using ACT.World.Behave;

namespace ACT.World.Asset;

[Serializable]
public abstract class DoActionBase : EventActionBase
{
	public sealed override void Enter(BehaveControlBaseBehaveEvent behave)
	{
	}

	public sealed override void Exit(BehaveControlBaseBehaveEvent behave)
	{
	}

	public sealed override bool Handle(BehaveControlBaseBehaveEvent behave)
	{
		Do(behave);
		currState = EventState.Finish;
		return true;
	}
}
