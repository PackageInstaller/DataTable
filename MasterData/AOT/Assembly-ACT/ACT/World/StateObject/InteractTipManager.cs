using System.Collections.Generic;
using Fundamental;

namespace ACT.World.StateObject;

public class InteractTipManager : Singleton<InteractTipManager>
{
	private readonly List<IShowInteractTip> _activeEntries = new List<IShowInteractTip>();

	public void Register(IShowInteractTip entry)
	{
		if (entry != null)
		{
			_activeEntries.Add(entry);
			entry.EvaluateTipConditions();
		}
	}

	public void Unregister(IShowInteractTip entry)
	{
		if (entry != null)
		{
			_activeEntries.Remove(entry);
		}
	}

	public void FixedUpdate()
	{
		for (int i = 0; i < _activeEntries.Count; i++)
		{
			_activeEntries[i].EvaluateTipConditions();
		}
	}

	public override void UnInit()
	{
		_activeEntries.Clear();
	}
}
