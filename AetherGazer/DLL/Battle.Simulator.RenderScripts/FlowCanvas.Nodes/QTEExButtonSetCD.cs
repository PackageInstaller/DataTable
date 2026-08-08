using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置QTE额外按钮CD", 0)]
[Category("Render/UI")]
[Description("设置QTE按钮CD,通过读取buff的剩余时长来设置,没有就设置为0")]
public class QTEExButtonSetCD : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> buffIDInput = AddValueInput<int>("创建ID");
		ValueInput<int> agentIDInput = AddValueInput<int>("持有者实体");
		ValueInput<GameObject> go = AddValueInput<GameObject>("射击按钮预制体");
		FlowOutput outPut = AddFlowOutput("");
		FlowOutput errorOutput = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || go.value == null)
			{
				errorOutput.Call(f);
			}
			else
			{
				QteExButton component = go.value.GetComponent<QteExButton>();
				if (component == null)
				{
					errorOutput.Call(f);
				}
				else
				{
					int percectCD = 0;
					int maxCD = 1;
					if (battleScene.GetBuffManager().TryGetBuffByAgentIDAndBuffID(agentIDInput.value, buffIDInput.value, out var buffState))
					{
						percectCD = buffState.mDuring;
						maxCD = buffState.mBuffKeepTime;
					}
					component.SetCD(percectCD, maxCD);
					outPut.Call(f);
				}
			}
		});
	}
}
