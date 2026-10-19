using System;
using System.Collections.Generic;

namespace ACT.MissionSystem;

[Serializable]
public class SetInteractableStatesActionParam
{
	[Serializable]
	public struct InteractableStateData
	{
		public int interactableId;

		public int state;
	}

	public List<InteractableStateData> interactableStates = new List<InteractableStateData>();
}
