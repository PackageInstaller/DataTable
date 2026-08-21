using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("交互物2控制触发区域激活状态触发器")]
public class MapItem2ChangeBaseTriggerActiveEventTrigger : MapItemEventTrigger
{
	public List<BaseTrigger> CloseTrigger;

	public List<BaseTrigger> OpneTrigger;

	public override string TriggerName => "交互物-控制触发区域激活状态触发器";

	protected override async void DoExecute()
	{
		base.DoExecute();
		if (CloseTrigger != null && CloseTrigger.Count > 0)
		{
			foreach (BaseTrigger item in CloseTrigger)
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
		foreach (BaseTrigger item2 in OpneTrigger)
		{
			if ((Object)(object)item2 != null)
			{
				item2.Active();
			}
		}
	}
}
