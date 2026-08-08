using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("收到消息事件(渲染)", 0)]
[Category("Render/事件")]
[Description("当触发器激活,更新,禁用的时候触发")]
public class ReceivedEventRender : EventNode
{
	private ValueInput<string> nameInput;

	private int triggerID;

	private string param;

	private FlowOutput flowOutput;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	protected override void RegisterPorts()
	{
		nameInput = AddValueInput<string>("事件名");
		AddValueOutput("触发器ID", () => triggerID);
		AddValueOutput("参数", () => param);
		flowOutput = AddFlowOutput("输出");
	}

	public override void OnGraphStarted()
	{
		MapTriggerManager mapTriggerManager = (NScene.GetCurrentScene() as BattleScene).GetMapTriggerManager();
		mapTriggerManager.onTriggerSendEvent = (OnVoidHandler<int, string, string>)Delegate.Combine(mapTriggerManager.onTriggerSendEvent, new OnVoidHandler<int, string, string>(OnReceivedEventHandler));
	}

	private void OnReceivedEventHandler(int triggerID, string eventName, string param)
	{
		if ((NScene.GetCurrentScene() as BattleScene).GetTriggerTypes(triggerID).Contains(base.graph.name) && eventName == nameInput.value)
		{
			this.triggerID = triggerID;
			this.param = param;
			this.triggerID = triggerID;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			flowOutput.Call(f);
		}
	}
}
