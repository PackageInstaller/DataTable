using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("QTE完成事件(渲染)", 0)]
[Category("Common/事件")]
[Description("QTE完成事件")]
public class QTEFinshEvent : EventNode
{
	private FlowOutput outputSuccess;

	private FlowOutput outputFailed;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		outputSuccess = AddFlowOutput("成功");
		outputFailed = AddFlowOutput("失败");
	}

	public override void OnGraphStarted()
	{
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		worldStateManager.mQteFinshEvent = (Action<bool>)Delegate.Combine(worldStateManager.mQteFinshEvent, new Action<bool>(OnQteFinshEvent));
	}

	public override void OnGraphStoped()
	{
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		worldStateManager.mQteFinshEvent = (Action<bool>)Delegate.Remove(worldStateManager.mQteFinshEvent, new Action<bool>(OnQteFinshEvent));
	}

	private void OnQteFinshEvent(bool IsSucees)
	{
		Flow f = new Flow
		{
			returnData = returnData
		};
		if (IsSucees)
		{
			outputSuccess.Call(f);
		}
		else
		{
			outputFailed.Call(f);
		}
	}
}
