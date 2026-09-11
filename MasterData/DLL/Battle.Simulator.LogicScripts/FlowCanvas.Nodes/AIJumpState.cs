using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("AI状态跳转(过时)", 0)]
[Category("Logic/AI")]
[Description("AI状态跳转")]
public class AIJumpState : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueInput<int>("状态");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity simEntity = (SimEntity)f.userData;
			if (simEntity == null || !simEntity.hasEntityAIThink)
			{
				Debug.LogError("你在控制非AI实体!");
			}
		});
	}
}
