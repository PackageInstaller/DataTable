using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("游戏对象初始化（渲染）", 0)]
[Category("Render/事件")]
[Description("游戏对象第一次出现在世界中会被触发（角色、空气墙、npc等）")]
public class SpawnRenderEntityEvent : EventNode
{
	private FlowOutput mOut;

	private ValueInput<int> mWantedSpawnType;

	private int mEntityID;

	private E_SpawnType mSpawnType;

	private bool mIsPlayer;

	private uint mAgentCamp;

	private int mConfigId;

	private Int3 mSpawnPoint;

	private Int3 mSpawnForward;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	public override void OnGraphStarted()
	{
		AgentManager.OnSpawnHandler = (OnVoidHandler<NAgent, EntitySpawnedEvent>)Delegate.Combine(AgentManager.OnSpawnHandler, new OnVoidHandler<NAgent, EntitySpawnedEvent>(OnDespawnHandler));
	}

	protected override void RegisterPorts()
	{
		mOut = AddFlowOutput(" ");
		mWantedSpawnType = AddValueInput<int>("类型");
		AddValueOutput("实体ID", () => mEntityID);
		AddValueOutput("实体类型", () => mSpawnType);
		AddValueOutput("实体阵营", () => mAgentCamp);
		AddValueOutput("实体配置ID", () => mConfigId);
		AddValueOutput("实体的出生位置", () => mSpawnPoint);
		AddValueOutput("实体的出生方向", () => mSpawnForward);
	}

	private void OnDespawnHandler(NAgent agent, EntitySpawnedEvent e)
	{
		mEntityID = e.NewEntity;
		mSpawnType = e.mSpawnType;
		mIsPlayer = e.mIsPlayer;
		mAgentCamp = e.mAgentCamp;
		mConfigId = e.mConfigId;
		mSpawnPoint = e.mSpawnPoint;
		mSpawnForward = e.mSpawnForward;
		Flow f = new Flow
		{
			returnData = mReturnData
		};
		mOut.Call(f);
	}
}
