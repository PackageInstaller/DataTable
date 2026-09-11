using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("服务器战斗结果事件(渲染)", 0)]
[Category("Render/事件")]
[Description("是否胜利")]
public class VictoryEvent : EventNode
{
	private int result;

	private FlowOutput mOut;

	private BattleResultForLua battleResult;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	private void OnGameOverEventHandler(int result)
	{
		if (battleResult == null)
		{
			battleResult = SendBattleResult.CalcStatisticsData(result).dataForLua;
		}
		this.result = result;
		LuaHelper.CallFunction("SendQuitBattle", battleResult, result == 3);
		Flow f = new Flow
		{
			returnData = mReturnData
		};
		mOut.Call(f);
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		base.mSimContext.GetSimInterface().mGSRecvBattleResultFinishEvent = null;
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mGSRecvBattleResultFinishEvent = (Action<int>)Delegate.Combine(simInterface.mGSRecvBattleResultFinishEvent, new Action<int>(OnGameOverEventHandler));
	}

	protected override void RegisterPorts()
	{
		AddValueOutput("结果", () => result);
		mOut = AddFlowOutput("");
	}
}
