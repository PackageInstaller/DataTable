using System;
using System.Collections.Generic;
using ACT.Battle;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class TriggerCondition
{
	public BattleTriggerType triggerType;

	public BoxColliderParameters battleTriggerField;

	[HideInInspector]
	public Dictionary<int, int> interactsUidStatesListen = new Dictionary<int, int>();

	public bool Check(bool isStay)
	{
		switch (triggerType)
		{
		case BattleTriggerType.PlayerEnter:
			return isStay;
		case BattleTriggerType.ListenOtherInteracts:
		{
			bool result = true;
			foreach (KeyValuePair<int, int> item in interactsUidStatesListen)
			{
				if (MonoECS.instance.ruleManager.SharedGetState(item.Key) != item.Value)
				{
					result = false;
					break;
				}
			}
			return result;
		}
		default:
			return false;
		}
	}
}
