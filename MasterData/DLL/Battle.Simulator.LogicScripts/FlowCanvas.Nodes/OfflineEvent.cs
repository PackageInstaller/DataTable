using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("掉线事件", 0)]
[Category("Common/事件")]
[Description("掉线事件")]
public class OfflineEvent : EventNode
{
	private ValueInput<bool> isRenderInput;

	private FlowOutput output;

	private int entityID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		isRenderInput = AddValueInput<bool>("是否渲染");
		output = AddFlowOutput("out");
		AddValueOutput("EntityID", () => entityID);
	}

	public override void OnGraphStarted()
	{
		if (!isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<OnlinePlayerOfflineEvent>(OnOfflineEvent);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<OnlinePlayerOfflineEvent>(OnOfflineEvent);
		}
	}

	private void OnOfflineEvent(OnlinePlayerOfflineEvent offlineEvent)
	{
		Flow flow = new Flow
		{
			returnData = returnData
		};
		entityID = offlineEvent.entityID;
		flow.Call(output);
	}
}
