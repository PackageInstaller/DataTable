using System;
using ACT.World.Behave;

namespace ACT.World.Asset;

[Serializable]
public abstract class EventActionBase : IEventAction, IDataToBake
{
	[NonSerialized]
	public EventState currState;

	public virtual void Enter(BehaveControlBaseBehaveEvent behave)
	{
		currState = EventState.Handling;
	}

	public virtual bool Handle(BehaveControlBaseBehaveEvent behave)
	{
		if (currState != EventState.Handling)
		{
			Enter(behave);
		}
		if (!Do(behave))
		{
			return false;
		}
		Exit(behave);
		return true;
	}

	public abstract bool Do(BehaveControlBaseBehaveEvent behave);

	public virtual void Exit(BehaveControlBaseBehaveEvent behave)
	{
		currState = EventState.Finish;
	}

	public virtual void ReSet(BehaveControlBaseBehaveEvent behave)
	{
		if (currState != EventState.WaitStart)
		{
			if (currState == EventState.Handling)
			{
				Exit(behave);
			}
			currState = EventState.WaitStart;
		}
	}
}
