using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("计时器事件(编号)", 0)]
[Category("Logic/事件")]
[Description("当实体身上的计时器添加、触发、或移除时，输出对应事件\n内置CD也会输出，但只会输出移除事件")]
public class TimerEventWithName : EventNode
{
	private int entityID;

	private bool isTimeout;

	private ValueInput<int> nameInput;

	private FlowOutput bind;

	private FlowOutput leave;

	private FlowOutput tick;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		AddValueOutput("实体ID", () => entityID);
		AddValueOutput("是否超时移除", () => isTimeout);
		nameInput = AddValueInput<int>("编号");
		bind = AddFlowOutput("添加");
		tick = AddFlowOutput("触发");
		leave = AddFlowOutput("移除");
	}

	public override void OnGraphStarted()
	{
		base.mSimContext.SimEventSystem.AddHandler<EntityTimerEvent>(OnEntityTimerEventHandler);
	}

	private void OnEntityTimerEventHandler(EntityTimerEvent e)
	{
		if (e.timerStruct.name == nameInput.value)
		{
			entityID = e.entityID;
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
