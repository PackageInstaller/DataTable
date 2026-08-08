using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("战斗按钮UI初始化事件(过时)", 0)]
[Category("Render/UI")]
[Description("战斗按钮UI初始化事件")]
public class OnBattleButtonUIInit : BattleButtonEvent
{
	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		AbilityButtonsUI component = base.graph.agent.gameObject.GetComponent<AbilityButtonsUI>();
		component.AbilityButtonsUIInit = (Action)Delegate.Combine(component.AbilityButtonsUIInit, new Action(AbilityButtonsUIInit));
	}

	protected void AbilityButtonsUIInit()
	{
		AgentManager agentManager = ((BattleScene)NScene.GetCurrentScene()).GetAgentManager();
		NAgent agent = agentManager.GetAgent(agentManager.mPlayerAgentID);
		if (null != agent && agent.AgentConfigID == _roleInput.value)
		{
			Call(_output);
		}
	}
}
