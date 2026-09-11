using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("战斗按钮UI技能变更事件(过时)", 0)]
[Category("Render/UI")]
[Description("战斗UI技能变更事件")]
public class OnBattleButtonUIAbilityChange : BattleButtonEvent
{
	private int _oldAbilityID;

	private int _newAbilityID;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		AbilityButtonsUI component = base.graph.agent.gameObject.GetComponent<AbilityButtonsUI>();
		component.OnAbilityChange = (Action<int, int, int>)Delegate.Combine(component.OnAbilityChange, new Action<int, int, int>(OnChangeAbility));
	}

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		AddValueOutput("旧技能ID", () => _oldAbilityID);
		AddValueOutput("新技能ID", () => _newAbilityID);
	}

	protected void OnChangeAbility(int buttonID, int oldAbility, int newAbility)
	{
		AgentManager agentManager = ((BattleScene)NScene.GetCurrentScene()).GetAgentManager();
		NAgent agent = agentManager.GetAgent(agentManager.mPlayerAgentID);
		if (null != agent && agent.AgentConfigID == _roleInput.value)
		{
			_buttonID = (ButtonType)buttonID;
			_oldAbilityID = oldAbility;
			_newAbilityID = newAbility;
			Call(_output);
		}
	}
}
