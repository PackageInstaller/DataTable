using System;
using System.Collections.Generic;
using ACT.World.Behave;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class MachineEvent : EventActionBase
{
	[SerializeReference]
	private List<DoActionBase> enter = new List<DoActionBase>();

	[SerializeReference]
	private List<EventActionBase> handleDo = new List<EventActionBase>();

	[SerializeReference]
	private List<DoActionBase> exit = new List<DoActionBase>();

	public override void Enter(BehaveControlBaseBehaveEvent behave)
	{
		base.Enter(behave);
		foreach (DoActionBase item in enter)
		{
			item.Handle(behave);
		}
		foreach (EventActionBase item2 in handleDo)
		{
			item2.currState = EventState.WaitStart;
		}
	}

	public override bool Do(BehaveControlBaseBehaveEvent behave)
	{
		bool result = true;
		foreach (EventActionBase item in handleDo)
		{
			if (item.currState != EventState.Finish && !item.Handle(behave))
			{
				result = false;
			}
		}
		return result;
	}

	public override void Exit(BehaveControlBaseBehaveEvent behave)
	{
		base.Exit(behave);
		foreach (DoActionBase item in exit)
		{
			item.Handle(behave);
		}
	}
}
