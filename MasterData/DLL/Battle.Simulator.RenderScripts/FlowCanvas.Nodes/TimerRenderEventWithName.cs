using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体计时器事件(编号)(渲染)", 0)]
[Category("Render/事件")]
[Description("实体计时器事件")]
public class TimerRenderEventWithName : EventNode
{
	private ValueInput<int> m_timerNameInput;

	private int m_entityID;

	private int m_entityTimerName;

	private int m_creationIndex;

	private bool isTimeout;

	private FlowOutput bind;

	private FlowOutput leave;

	private FlowOutput tick;

	private EntityTimerStruct m_entityTimerStruct;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		m_timerNameInput = AddValueInput<int>("编号", "name");
		AddValueOutput("实体ID", "entityID", () => m_entityID);
		AddValueOutput("编号", () => m_entityTimerName);
		AddValueOutput("唯一ID", () => m_creationIndex);
		AddValueOutput("计时器", () => m_entityTimerStruct);
		AddValueOutput("是否超时移除", () => isTimeout);
		bind = AddFlowOutput("添加");
		tick = AddFlowOutput("触发");
		leave = AddFlowOutput("移除");
	}

	public override void OnGraphStarted()
	{
		base.mSimContext.SimToPresentationEventSystem.AddHandler<EntityTimerEvent>(OnEntityTimerEventHandler);
	}

	private void OnEntityTimerEventHandler(EntityTimerEvent e)
	{
		if (e.timerStruct.name == m_timerNameInput.GetValue())
		{
			m_entityID = e.entityID;
			m_entityTimerName = e.timerStruct.name;
			m_creationIndex = e.timerStruct.id;
			m_entityTimerStruct = e.timerStruct;
			isTimeout = e.isTimeoutLeft;
			Flow f = new Flow
			{
				returnData = returnData
			};
			switch (e.life)
			{
			case EBuffLife.Bind:
				bind.Call(f);
				break;
			case EBuffLife.Tick:
				tick.Call(f);
				break;
			case EBuffLife.Leave:
				leave.Call(f);
				break;
			}
		}
	}
}
