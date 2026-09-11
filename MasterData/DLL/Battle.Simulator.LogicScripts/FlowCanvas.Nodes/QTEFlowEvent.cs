using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("拼刀事件", 0)]
[Category("Common/QTE")]
[Description("拼刀事件")]
public class QTEFlowEvent : EventNode
{
	private FlowOutput outputStart;

	private FlowOutput outputSuccess;

	private FlowOutput outputFailed;

	private FlowOutput outputStop;

	private FlowOutput outputTimeout;

	private ValueInput<bool> isRenderInput;

	private ValueInput<int> idInput;

	private int curTime;

	private int maxTime;

	private int QTEID;

	private int entityID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		if (isRenderInput.GetValue())
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<QTEEvent>(OnQTEEvent);
		}
		else
		{
			base.mSimContext.SimEventSystem.AddHandler<QTEEvent>(OnQTEEvent);
		}
	}

	private void OnQTEEvent(QTEEvent eventReceived)
	{
		int value = idInput.value;
		if (value == 0 || eventReceived.ID == value)
		{
			curTime = eventReceived.curTime;
			maxTime = eventReceived.maxTime;
			QTEID = eventReceived.ID;
			entityID = eventReceived.entityID;
			Flow f = new Flow
			{
				returnData = returnData
			};
			switch (eventReceived.mStatus)
			{
			case QTEStatusType.Start:
				outputStart.Call(f);
				break;
			case QTEStatusType.Success:
				outputSuccess.Call(f);
				break;
			case QTEStatusType.Failed:
				outputFailed.Call(f);
				break;
			case QTEStatusType.Stop:
				outputStop.Call(f);
				break;
			case QTEStatusType.Timeout:
				outputTimeout.Call(f);
				break;
			}
		}
	}

	protected override void RegisterPorts()
	{
		isRenderInput = AddValueInput<bool>("是否渲染");
		idInput = AddValueInput<int>("拼刀ID");
		outputStart = AddFlowOutput("拼刀开始");
		outputSuccess = AddFlowOutput("玩家成功");
		outputFailed = AddFlowOutput("玩家失败");
		outputStop = AddFlowOutput("意外中止");
		outputTimeout = AddFlowOutput("超时");
		AddValueOutput("拼刀ID", () => QTEID);
		AddValueOutput("当前时间", () => curTime);
		AddValueOutput("最大持续时间", () => maxTime);
		AddValueOutput("实体ID", () => entityID);
	}
}
