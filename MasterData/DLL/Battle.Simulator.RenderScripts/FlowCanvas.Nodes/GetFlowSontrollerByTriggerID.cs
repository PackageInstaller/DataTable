using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取触发器(渲染)", 0)]
[Category("Render/Trigger")]
[Description("根据触发器id拿到对应的触发器组件对象")]
public class GetFlowSontrollerByTriggerID : PureFunctionNode<List<FlowScriptController>, int>
{
	public override List<FlowScriptController> Invoke(int triggerID)
	{
		return (NScene.GetCurrentScene() as BattleScene).GetTriggers(triggerID);
	}
}
