using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("矩形触发区域(渲染)", 0)]
[Category("Render/PosAndRot")]
[Description("判断玩家是否进入到这个区域中")]
public class BoxTriggerAreaRender : FlowNode
{
	private List<int> collisions = new List<int>();

	protected override void RegisterPorts()
	{
		ValueInput<Int3> positionInput = AddValueInput<Int3>("位置");
		ValueInput<Int3> forwardInput = AddValueInput<Int3>("朝向");
		ValueInput<Int3> sizeInput = AddValueInput<Int3>("大小");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("In", delegate(Flow f)
		{
			collisions.Clear();
			collisions = OverlapBoxRender.GetAgentIDsInBox(positionInput.value, forwardInput.value, sizeInput.value, collisions);
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			for (int i = 0; i < collisions.Count; i++)
			{
				if (agentManager.GetAgent(collisions[i]).IsLocalPlayer)
				{
					trueOut.Call(f);
					return;
				}
			}
			falseOut.Call(f);
		});
	}
}
