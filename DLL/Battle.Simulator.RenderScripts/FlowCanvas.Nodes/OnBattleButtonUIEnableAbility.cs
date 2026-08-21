using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("战斗按钮UI技能启用事件(过时)", 0)]
[Category("Render/UI")]
[Description("战斗UI技能启用结束事件")]
public class OnBattleButtonUIEnableAbility : BattleButtonEvent
{
	protected bool _enable;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		AbilityButtonsUI component = base.graph.agent.gameObject.GetComponent<AbilityButtonsUI>();
		component.OnAbilityEnable = (Action<int, bool>)Delegate.Combine(component.OnAbilityEnable, new Action<int, bool>(OnAbilityEnable));
	}

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		AddValueOutput("是否启用", () => _enable);
	}

	protected void OnAbilityEnable(int buttonID, bool enable)
	{
		AgentManager agentManager = ((BattleScene)NScene.GetCurrentScene()).GetAgentManager();
		NAgent agent = agentManager.GetAgent(agentManager.mPlayerAgentID);
		if (null != agent && agent.AgentConfigID == _roleInput.value)
		{
			_buttonID = (ButtonType)buttonID;
			_enable = enable;
			Call(_output);
		}
	}
}
