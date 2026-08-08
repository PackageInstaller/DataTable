using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体销毁事件(渲染)", 0)]
[Category("Render/事件")]
[Description("在游戏世界内游戏实体被销毁前，最后一次调用（角色、空气墙、npc等）")]
public class DespawnRenderEntityEvent : EventNode
{
	private FlowOutput mOut;

	private int mEntityID;

	private int mKillingEntityID;

	private int mKillingAbilityID;

	private EntityDespawnedEvent mEvent;

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
		mOut = AddFlowOutput(" ");
		AddValueOutput("销毁对象ID", () => mEntityID);
		AddValueOutput("谁销毁的", () => mKillingEntityID);
		AddValueOutput("用什么销毁的", () => mKillingAbilityID);
		AddValueOutput("销毁消息", () => mEvent);
	}

	private void OnDespawnHandler(EntityDespawnedEvent e, NAgent agent)
	{
		mEntityID = e.DestroyedEntity;
		mKillingEntityID = e.KillingEntity;
		mKillingAbilityID = e.mAbilityID;
		mEvent = e;
		Flow f = new Flow
		{
			returnData = mReturnData
		};
		mOut.Call(f);
	}
}
