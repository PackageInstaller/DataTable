using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("禁用单个触发器", 0)]
[Category("Logic/Trigger")]
[Description("禁用触发器")]
public class DisableATrigger : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> triggerIDInput = AddValueInput<int>("触发器ID");
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(triggerIDInput.value);
			if (simEntityByTriggerID != null)
			{
				if (!simEntityByTriggerID.entityTrigger.mEnabled)
				{
					Debug.LogWarning(base.mSimContext.sEntityWorldState.status.mSceneMap.ID + " 禁用了已经禁用的触发器 " + triggerIDInput.value);
					output.Call(f);
					return;
				}
				simEntityByTriggerID.entityTrigger.mEnabled = false;
			}
			base.mSimContext.PostEvent(TriggerEnableEvent.Claim(triggerIDInput.value, enable: false));
			output.Call(f);
		});
	}
}
