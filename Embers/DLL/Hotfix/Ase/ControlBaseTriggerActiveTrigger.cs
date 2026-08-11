using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("触发区域控制触发区域激活状态触发器")]
public class ControlBaseTriggerActiveTrigger : BaseTrigger
{
	public List<BaseTrigger> CloseTrigger;

	public List<BaseTrigger> OpneTrigger;

	public override string TriggerName => "触发区域控制触发区域激活状态触发器";

	protected override void DoExecute()
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
