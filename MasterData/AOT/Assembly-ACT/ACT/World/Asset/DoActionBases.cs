using System;
using System.Collections.Generic;
using ACT.World.Behave;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class DoActionBases : DoActionBase
{
	[SerializeReference]
	public List<DoActionBase> doActions = new List<DoActionBase>();

	public sealed override bool Do(BehaveControlBaseBehaveEvent behave)
	{
		foreach (DoActionBase doAction in doActions)
		{
			doAction.Handle(behave);
		}
		return true;
	}
}
