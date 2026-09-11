using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("命中事件前", 0)]
[Category("Logic/事件")]
[Description("命中事件前")]
public class BeforeHitTargetEvent : EventNode
{
	private int target;

	private int attacker;

	private int targetPart;

	private FlowOutput hitTarget;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		AddValueOutput("攻击者", () => attacker);
		AddValueOutput("受击目标", () => target);
		AddValueOutput("受击部位ID", () => targetPart);
		hitTarget = AddFlowOutput("输出");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mBeforeHitTargetEvent = (Action<int, int, int>)Delegate.Combine(simInterface.mBeforeHitTargetEvent, new Action<int, int, int>(OnBeforeHitTargetEventHandler));
	}

	private void OnBeforeHitTargetEventHandler(int attacker, int target, int targetPartID)
	{
		this.attacker = attacker;
		this.target = target;
		targetPart = targetPartID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		hitTarget.Call(f);
	}
}
