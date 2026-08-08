using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体销毁事件(实体类型ID)(渲染)", 0)]
[Category("Render/事件")]
[Description("在游戏世界内渲染层 Agent 被销毁前，最后一次调用（角色、空气墙、npc等）")]
public class DespawnRenderAgentOfRoleIDEvent : EventNode
{
	private FlowOutput _out;

	private ValueInput<int> _roleIDInput;

	private int _agentID;

	private int _killingEntityID;

	private int _killingAbilityID;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	public override void OnGraphStarted()
	{
		AgentManager.OnDesSpawnHandler = (OnVoidHandler<EntityDespawnedEvent, NAgent>)Delegate.Combine(AgentManager.OnDesSpawnHandler, new OnVoidHandler<EntityDespawnedEvent, NAgent>(OnDespawnHandler));
	}

	public override void OnGraphStoped()
	{
		AgentManager.OnDesSpawnHandler = (OnVoidHandler<EntityDespawnedEvent, NAgent>)Delegate.Remove(AgentManager.OnDesSpawnHandler, new OnVoidHandler<EntityDespawnedEvent, NAgent>(OnDespawnHandler));
	}

	protected override void RegisterPorts()
	{
		_out = AddFlowOutput("Out");
		_roleIDInput = AddValueInput<int>("实体类型ID", "roleID");
		AddValueOutput("销毁对象ID", () => _agentID);
		AddValueOutput("谁销毁的", () => _killingEntityID);
		AddValueOutput("用什么销毁的", () => _killingAbilityID);
	}

	private void OnDespawnHandler(EntityDespawnedEvent e, NAgent agent)
	{
		if (agent.AgentConfigID == _roleIDInput.value)
		{
			_agentID = e.DestroyedEntity;
			_killingEntityID = e.KillingEntity;
			_killingAbilityID = e.mAbilityID;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			_out.Call(f);
		}
	}
}
