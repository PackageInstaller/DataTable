namespace FlowCanvas.Nodes;

public class OnBattleButtonUICD : BattleButtonEvent
{
	protected void Invoke(int buttonID)
	{
		AgentManager agentManager = ((BattleScene)NScene.GetCurrentScene()).GetAgentManager();
		NAgent agent = agentManager.GetAgent(agentManager.mPlayerAgentID);
		if (null != agent && agent.AgentConfigID == _roleInput.value)
		{
			_buttonID = (ButtonType)buttonID;
			Call(_output);
		}
	}
}
