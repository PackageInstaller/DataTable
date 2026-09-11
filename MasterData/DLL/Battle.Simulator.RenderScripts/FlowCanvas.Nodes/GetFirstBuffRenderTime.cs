using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取BUFF时长(渲染)", 0)]
[Category("Render/Buff/通用")]
[Description("获取BUFF时长, 返回第一个找到的数据")]
public class GetFirstBuffRenderTime : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput nullOut = AddFlowOutput("无BUFF");
		FlowOutput abnormalOut = AddFlowOutput("Error", "异常");
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "AgentID");
		ValueInput<int> buffClassInput = AddValueInput<int>("类型(处理逻辑)ID", "BUFF类型ID");
		int resTime = 0;
		AddValueOutput("剩余时长", () => resTime);
		int maxTime = int.MaxValue;
		AddValueOutput("总时长", () => maxTime);
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
							resTime = buffList[i].mDuring;
							maxTime = buffList[i].mBuffKeepTime;
							break;
						}
					}
					output.Call(f);
				}
			}
		});
	}
}
