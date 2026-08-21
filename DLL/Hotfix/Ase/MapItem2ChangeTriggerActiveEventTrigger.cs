using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("交互物2事件触发器控制触发器")]
public class MapItem2ChangeTriggerActiveEventTrigger : MapItemEventTrigger
{
	public List<BaseEventTriggerNode> CloseTrigger;

	public List<BaseEventTriggerNode> OpneTrigger;

	public override string TriggerName => "交互物-事件触发器控制触发器";

	protected override async void DoExecute()
	{
		base.DoExecute();
		if (CloseTrigger != null && CloseTrigger.Count > 0)
		{
			foreach (BaseEventTriggerNode item in CloseTrigger)
			{
				if ((Object)(object)item != null)
				{
					item.Disable();
				}
			}
		}
		if (OpneTrigger == null || OpneTrigger.Count <= 0)
		{
			return;
		}
		foreach (BaseEventTriggerNode item2 in OpneTrigger)
		{
			if ((Object)(object)item2 != null)
			{
				item2.Active();
			}
		}
	}
}
