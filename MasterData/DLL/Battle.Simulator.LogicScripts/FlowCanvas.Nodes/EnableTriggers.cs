using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("激活触发器", 0)]
[Category("Logic/Trigger")]
[Description("激活触发器")]
public class EnableTriggers : CallableActionNode<List<int>>
{
	public override void Invoke(List<int> triggerIDs)
	{
		for (int i = 0; i < triggerIDs.Count; i++)
		{
			SimEntity simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(triggerIDs[i]);
			if (simEntityByTriggerID != null)
			{
				if (simEntityByTriggerID.entityTrigger.mEnabled)
				{
					Debug.LogWarning(base.parentNode.mSimContext.sEntityWorldState.status.mSceneMap.ID + " 激活了已经激活的触发器" + triggerIDs[i]);
					continue;
				}
				simEntityByTriggerID.entityTrigger.mEnabled = true;
			}
			base.parentNode.mSimContext.PostEvent(TriggerEnableEvent.Claim(triggerIDs[i], enable: true));
		}
	}
}
