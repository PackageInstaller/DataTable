using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("激活单个触发器", 0)]
[Category("Logic/Trigger")]
[Description("激活单个触发器")]
public class EnableATrigger : CallableActionNode<int>
{
	public override void Invoke(int triggerID)
	{
		SimEntity simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(triggerID);
		if (simEntityByTriggerID != null)
		{
			if (simEntityByTriggerID.entityTrigger.mEnabled)
			{
				Debug.LogWarning(base.parentNode.mSimContext.sEntityWorldState.status.mSceneMap.ID + " 激活了已经激活的触发器" + triggerID);
				return;
			}
			simEntityByTriggerID.entityTrigger.mEnabled = true;
		}
		base.parentNode.mSimContext.PostEvent(TriggerEnableEvent.Claim(triggerID, enable: true));
	}
}
