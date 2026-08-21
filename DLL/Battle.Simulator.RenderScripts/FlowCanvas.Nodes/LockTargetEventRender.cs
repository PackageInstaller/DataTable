using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("手动锁定目标的事件(渲染)", 0)]
[Category("Render/事件")]
[Description("手动锁定目标的事件")]
public class LockTargetEventRender : EventNode
{
	private FlowOutput output;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	private int targetID;

	protected override void RegisterPorts()
	{
		output = AddFlowOutput("");
		AddValueOutput("目标ID", () => targetID);
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		if (worldStateManager != null)
		{
			worldStateManager.lockTargetEvent = (Action<int>)Delegate.Combine(worldStateManager.lockTargetEvent, new Action<int>(OnLockTarget));
		}
	}

	public void OnLockTarget(int targetID)
	{
		this.targetID = targetID;
		Flow f = new Flow
		{
			returnData = mReturnData
		};
		output.Call(f);
	}
}
