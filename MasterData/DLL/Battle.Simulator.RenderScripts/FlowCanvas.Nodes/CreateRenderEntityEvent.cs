using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("创建游戏实体（渲染）", 0)]
[Category("Render/事件")]
[Description("在游戏世界内创建游戏实体（角色、空气墙、npc等）")]
public class CreateRenderEntityEvent : EventNode
{
	private FlowOutput mOut;

	private ValueInput<int> mWantedSpawnType;

	private int mEntityID;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	private EntitySpawnedEvent mEvent;

	public override void OnGraphStarted()
	{
		AgentManager.SpawnHandler = (OnVoidHandler<EntitySpawnedEvent>)Delegate.Combine(AgentManager.SpawnHandler, new OnVoidHandler<EntitySpawnedEvent>(OnSpawnHandler));
	}

	protected override void RegisterPorts()
	{
		mOut = AddFlowOutput(" ");
		mWantedSpawnType = AddValueInput<int>("类型");
		AddValueOutput("实体ID", () => mEntityID);
		AddValueOutput("创建内容", () => mEvent);
	}

	private void OnSpawnHandler(EntitySpawnedEvent e)
	{
		if (e.mSpawnType == (E_SpawnType)mWantedSpawnType.GetValue())
		{
			mEntityID = e.NewEntity;
			mEvent = e;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			mOut.Call(f);
		}
	}
}
