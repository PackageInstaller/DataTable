using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改怪物名称(渲染)", 0)]
[Category("Render/UI")]
[Description("修改怪物在UI上面显示的名称")]
public class ChangeAgentName : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentInput = AddValueInput<int>("agentID");
		ValueInput<string> nameInput = AddValueInput<string>("名称");
		FlowOutput output = AddFlowOutput("out");
		AddFlowInput("in", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentInput.value);
			if (agent != null)
			{
				agent.HasNickName = true;
				agent.NickName = nameInput.value;
				BossInfoUI bossInfoUI = BattleUI.GetBattleUI().BossInfoUI;
				if (bossInfoUI != null)
				{
					bossInfoUI.UpdateUIName();
				}
			}
			output.Call(f);
		});
	}
}
