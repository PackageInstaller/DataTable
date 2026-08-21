using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("变身事件(渲染)", 0)]
[Category("Render/事件")]
[Description("变身事件")]
public class TransfigurationEventRender : EventNode
{
	private FlowOutput output;

	private int entityID;

	private int oldRoleID;

	private int newRoleID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		output = AddFlowOutput("");
		AddValueOutput("实体ID", () => entityID);
		AddValueOutput("旧的实体类型ID", "旧的角色ID", () => oldRoleID);
		AddValueOutput("新的实体类型ID", "新的角色ID", () => newRoleID);
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
		if (agentManager != null)
		{
			agentManager.TransfigurationRenderEvent = (Action<int, int, int>)Delegate.Combine(agentManager.TransfigurationRenderEvent, new Action<int, int, int>(FuncHandler));
		}
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
		if (agentManager != null)
		{
			agentManager.TransfigurationRenderEvent = (Action<int, int, int>)Delegate.Remove(agentManager.TransfigurationRenderEvent, new Action<int, int, int>(FuncHandler));
		}
	}

	private void FuncHandler(int entityID, int oldRoleID, int newRoleID)
	{
		this.entityID = entityID;
		this.oldRoleID = oldRoleID;
		this.newRoleID = newRoleID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		output.Call(f);
	}
}
