using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("隐藏全部角色(包括影子)", 0)]
[Category("Render/Agent")]
[Description("隐藏全部角色,包括影子")]
public class DisableAllAgentRenders : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<bool> enableInput = AddValueInput<bool>("是否隐藏");
		AddFlowInput("", delegate(Flow f)
		{
			ChangeAgentVisibleState(enableInput.value);
			output.Call(f);
		});
	}

	private AgentManager GetAgentManager()
	{
		if (SceneDirector.Instance == null)
		{
			return null;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return null;
		}
		if (battleScene.GetBattleSimulatorSystem() == null)
		{
			return null;
		}
		return battleScene.GetAgentManager();
	}

	private void ChangeAgentVisibleState(bool flag)
	{
		AgentManager agentManager = GetAgentManager();
		if (agentManager == null)
		{
			return;
		}
		List<NAgent> entities = agentManager.Entities;
		for (int i = 0; i < entities.Count; i++)
		{
			ComponentTimeline componentTimeline = entities[i].ComponentTimeline;
			if (flag)
			{
				componentTimeline.DisableRenders();
			}
			else
			{
				componentTimeline.EnableRenders();
			}
		}
	}
}
