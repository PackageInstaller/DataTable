using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取BUFF剩余时长百分比", 0)]
[Category("Render/Buff/通用")]
[Description("获取BUFF剩余时长百分比,得到实体身上指定类型BUFF的剩余调用时长,由于一个类型的buff可能有多个,故而需要用list来存放")]
public class GetBuffPercentOfSurplusKeepTime : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput nullOut = AddFlowOutput("无BUFF");
		FlowOutput abnormalOut = AddFlowOutput("Error", "异常");
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "AgentID");
		ValueInput<int> buffClassInput = AddValueInput<int>("类型(处理逻辑)ID", "BUFF类型ID");
		ValueInput<List<float>> percentInput = AddValueInput<List<float>>("存放百分比数组");
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
				if (!battleScene.GetBuffManager().TryGetBuffListByAgentID(agentIDInput.GetValue(), out buffList))
				{
					nullOut.Call(f);
				}
				else
				{
					for (int i = 0; i < buffList.Count; i++)
					{
						if (buffList[i].mBuffClassID == buffClassInput.value)
						{
							percentInput.value.Add((float)buffList[i].mDuring / (float)buffList[i].mBuffKeepTime);
						}
					}
					output.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "AgentID", () => agentIDInput.value);
		AddValueOutput("存放百分比数组", () => percentInput.value);
	}
}
