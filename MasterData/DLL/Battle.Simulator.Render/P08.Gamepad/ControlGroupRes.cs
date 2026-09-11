using System;
using System.Collections.Generic;
using UnityEngine;

namespace P08.Gamepad;

public class ControlGroupRes : ScriptableObject
{
	[Serializable]
	public struct ControlGroupData(EControlType controlType, int conflictGroup = 0)
	{
		public int conflictGroup = conflictGroup;

		public EControlType controlType = controlType;

		public List<En_ButtonType> keys = new List<En_ButtonType>();
	}

	public List<ControlGroupData> groups;
}
