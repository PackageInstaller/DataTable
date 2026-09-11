using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到Buff剩余时长(渲染)", 0)]
[Category("Render/Buff/通用")]
[Description("得到实体身上指定类型BUFF的剩余调用时长,由于一个类型的buff可能有多个,故而需要用list来存放")]
public class GetBuffClassRuntimeSurplusRender : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput nullOut = AddFlowOutput("无BUFF");
		FlowOutput abnormalOut = AddFlowOutput("Error", "异常");
		ValueInput<int> agentIDVar = AddValueInput<int>("实体ID", "AgentID");
		ValueInput<int> buffClassVar = AddValueInput<int>("类型(处理逻辑)ID", "BUFF类型ID");
		ValueInput<List<int>> cdsVar = AddValueInput<List<int>>("存放cd数组", "存放cd百分比数组");
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
					nullOut.Call(f);
				}
				else
				{
					for (int i = 0; i < buffList.Count; i++)
					{
						if (buffList[i].mBuffClassID == buffClassVar.value)
						{
							cdsVar.value.Add(buffList[i].mBuffRuntime);
						}
					}
					output.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "AgentID", () => agentIDVar.value);
		AddValueOutput("存放cd数组", () => cdsVar.value);
	}
}
