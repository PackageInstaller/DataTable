using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否有Buff(类型(处理逻辑)ID)(渲染)", 0)]
[Category("Render/Buff/通用")]
[Description("检查EntityID对应的实体身上是否存在指定类型的buff数据")]
public class HasBuffOfSpecifiedBuffClassRender : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOutput = AddFlowOutput("有", "存在");
		FlowOutput falseOutput = AddFlowOutput("无", "不存在");
		FlowOutput abnormalOut = AddFlowOutput("Error", "无效AgentID");
		ValueInput<int> agentIDVar = AddValueInput<int>("实体ID", "AgentID");
		ValueInput<int> buffClassVar = AddValueInput<int>("类型(处理逻辑)ID", "BUFF类型ID");
		AddFlowInput("In", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				abnormalOut.Call(f);
			}
			else
			{
				List<BuffState> buffList = null;
				if (!battleScene.GetBuffManager().TryGetBuffListByAgentID(agentIDVar.GetValue(), out buffList))
				{
					falseOutput.Call(f);
				}
				else
				{
					for (int i = 0; i < buffList.Count; i++)
					{
						if (buffList[i].mBuffClassID == buffClassVar.value)
						{
							trueOutput.Call(f);
							return;
						}
					}
					falseOutput.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "AgentID", () => agentIDVar.value);
	}
}
