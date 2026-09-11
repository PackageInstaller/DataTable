using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("CD返还事件", 0)]
[Category("Logic/事件")]
[Description("技能被自我打断时的事件(本事件会在CD返还后触发)")]
public class OnAbilityInterruptBySelf : EventNode
{
	private FlowOutput _output;

	private int _simEntityID;

	private int _abilityID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mOnAbilityInterruptBySelf = (Action<int, int>)Delegate.Combine(simInterface.mOnAbilityInterruptBySelf, new Action<int, int>(OnTriggerAbilityInterruptBySelf));
	}

	protected virtual void OnTriggerAbilityInterruptBySelf(int simEntityID, int abilityID)
	{
		_simEntityID = simEntityID;
		_abilityID = abilityID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		_output.Call(f);
	}

	protected override void RegisterPorts()
	{
		_output = AddFlowOutput("OUT", "out");
		AddValueOutput("实体ID", "entityID", () => _simEntityID);
		AddValueOutput("技能ID", "abilityID", () => _abilityID);
		AddValueOutput("技能ID(后三位)", "abilityID_suffix", () => _abilityID % 1000);
	}
}
