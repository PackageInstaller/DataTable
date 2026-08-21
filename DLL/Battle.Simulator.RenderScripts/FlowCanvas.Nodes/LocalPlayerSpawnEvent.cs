using System;
using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("本地玩家创建事件(渲染)", 0)]
[Category("Render/事件")]
[Description("本地玩家创建事件的下一帧触发")]
public class LocalPlayerSpawnEvent : EventNode, IUpdatable
{
	private FlowOutput output;

	private bool isStart;

	private int frameCount;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	public override void OnGraphStarted()
	{
		AgentManager.SpawnHandler = (OnVoidHandler<EntitySpawnedEvent>)Delegate.Combine(AgentManager.SpawnHandler, new OnVoidHandler<EntitySpawnedEvent>(OnSpawnHandler));
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		isStart = false;
		frameCount = 0;
	}

	private void OnSpawnHandler(EntitySpawnedEvent ev)
	{
		if (ev.mIsPlayer)
		{
			isStart = true;
			frameCount = 0;
		}
	}

	protected override void RegisterPorts()
	{
		output = AddFlowOutput("");
	}

	public void Update()
	{
		if (isStart)
		{
			frameCount++;
		}
		if (frameCount == 2)
		{
			isStart = false;
			frameCount = 0;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			output.Call(f);
		}
	}
}
