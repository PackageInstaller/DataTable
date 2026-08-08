using System;
using System.Collections.Generic;

namespace Services;

public class FCBuffService : IFCBuffService, IService
{
	public List<Action<int, int, int, EBuffLife, bool>> mHandlers = new List<Action<int, int, int, EBuffLife, bool>>(16);

	private SimContext mSimContext;

	public FCBuffService(SimContext simContext)
	{
		mSimContext = simContext;
	}

	public void AddBuffEventHandler(Action<int, int, int, EBuffLife, bool> handler, bool isOnce)
	{
		if (!mHandlers.Contains(handler))
		{
			ISimulatorInferface simInterface = mSimContext.GetSimInterface();
			simInterface.mUpdateBuffLogicEvent = (Action<int, int, int, EBuffLife, bool>)Delegate.Combine(simInterface.mUpdateBuffLogicEvent, handler);
			mHandlers.Add(handler);
		}
		else if (!isOnce)
		{
			ISimulatorInferface simInterface2 = mSimContext.GetSimInterface();
			simInterface2.mUpdateBuffLogicEvent = (Action<int, int, int, EBuffLife, bool>)Delegate.Combine(simInterface2.mUpdateBuffLogicEvent, handler);
		}
	}

	public void RemoveBuffEventHandler(Action<int, int, int, EBuffLife, bool> handler)
	{
		ISimulatorInferface simInterface = mSimContext.GetSimInterface();
		simInterface.mUpdateBuffLogicEvent = (Action<int, int, int, EBuffLife, bool>)Delegate.Remove(simInterface.mUpdateBuffLogicEvent, handler);
		mHandlers.Remove(handler);
	}

	public void Shutdown()
	{
		for (int i = 0; i < mHandlers.Count; i++)
		{
			ISimulatorInferface simInterface = mSimContext.GetSimInterface();
			simInterface.mUpdateBuffLogicEvent = (Action<int, int, int, EBuffLife, bool>)Delegate.Remove(simInterface.mUpdateBuffLogicEvent, mHandlers[i]);
		}
	}
}
