using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取BUFF时长(创建ID)(渲染)", 0)]
[Category("Render/Buff/通用")]
[Description("返回创建ID对应的BUFF剩余时间和总时长")]
public class GetFirstBuffRenderTimeByConfigID : FlowControlNodeOfRender
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput nullOut = AddFlowOutput("无BUFF");
		FlowOutput abnormalOut = AddFlowOutput("Error", "异常");
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "AgentID");
		ValueInput<int> buffIDInput = AddValueInput<int>("创建ID", "buffID");
		int resTime = 0;
		AddValueOutput("剩余时长", () => resTime);
		int maxTime = int.MaxValue;
		AddValueOutput("总时长", () => maxTime);
		AddFlowInput("In", delegate(Flow f)
		{
			resTime = 0;
			maxTime = 0;
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
					bool flag = false;
					for (int i = 0; i < buffList.Count; i++)
					{
						if (buffList[i].mBuffID == buffIDInput.value)
						{
							resTime = buffList[i].mDuring;
							maxTime = buffList[i].mBuffKeepTime;
							flag = true;
							break;
						}
					}
					if (flag)
					{
						output.Call(f);
					}
					else
					{
						nullOut.Call(f);
					}
				}
			}
		});
	}
}
