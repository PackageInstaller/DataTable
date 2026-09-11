using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("AI条件失败", 0)]
[Category("Logic/AI")]
[Description("AI指令前置条件失败，如果不接这个节点，默认系统认为条件成立")]
public class AIConditionFailureAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityID = AddValueInput<int>("实体ID");
		ValueInput<int> actionID = AddValueInput<int>("指令集ID");
		AddValueOutput("实体ID", () => entityID.value);
		AddValueOutput("指令集ID", () => actionID.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int value = actionID.value;
			SimEntity obj = (SimEntity)f.userData;
			Debug.Log(value + "==========>>条件失败！");
			obj.entityAIThink.mReevalute = true;
			f.Call(output);
		});
	}
}
