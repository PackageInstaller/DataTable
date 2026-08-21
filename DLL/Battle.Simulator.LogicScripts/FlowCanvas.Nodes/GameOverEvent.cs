using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("游戏结束事件", 0)]
[Category("Common/事件")]
[Description("游戏结束事件")]
public class GameOverEvent : EventNode
{
	private ValueInput<bool> isRenderInput;

	private FlowOutput startOut;

	private FlowOutput tickOut;

	private FlowOutput endOut;

	private bool isVictory;

	private int timeScale;

	private int countDown;

	private E_BattleResult battleResult;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		isRenderInput = AddValueInput<bool>("是否渲染");
		startOut = AddFlowOutput("开始");
		tickOut = AddFlowOutput("Tick");
		endOut = AddFlowOutput("结束");
		AddValueOutput("是否胜利", () => isVictory);
		AddValueOutput("时间缩放", () => timeScale);
		AddValueOutput("倒计时", () => countDown);
		AddValueOutput("战斗结果", () => battleResult);
	}

	public override void OnGraphStarted()
	{
		if (!isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<SimGameOverEvent>(OnGameOverEvent);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<SimGameOverEvent>(OnGameOverEvent);
		}
	}

	private void OnGameOverEvent(SimGameOverEvent eventReceived)
	{
		Flow flow = new Flow
		{
			returnData = returnData
		};
		isVictory = eventReceived.isVectory == E_BattleResult.Win;
		timeScale = eventReceived.timeScale;
		countDown = eventReceived.countdown;
		battleResult = eventReceived.isVectory;
		switch (eventReceived.state)
		{
		case GameOverState.start:
			flow.Call(startOut);
			break;
		case GameOverState.tick:
			flow.Call(tickOut);
			break;
		case GameOverState.end:
			flow.Call(endOut);
			break;
		}
	}
}
