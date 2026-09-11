using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能添加事件(技能ID)", 0)]
[Category("Logic/事件")]
[Description("技能添加事件, 技能组件被添加上去的那一瞬间触发")]
public class AbilityAddedEventAbilityID : EventNode
{
	private FlowOutput output;

	private ValueInput<int> abilityIDInput;

	private int entityID;

	private int abilityID;

	private int actionID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAbilityAddedLogicEvent = (Action<int, int, int>)Delegate.Combine(simInterface.mAbilityAddedLogicEvent, new Action<int, int, int>(OnAbilityAddedEventHandler));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAbilityAddedLogicEvent = (Action<int, int, int>)Delegate.Remove(simInterface.mAbilityAddedLogicEvent, new Action<int, int, int>(OnAbilityAddedEventHandler));
	}

	private void OnAbilityAddedEventHandler(int entityID, int pOldAbilityID, int pNewAbilityID)
	{
		Flow f = new Flow
		{
			returnData = returnData
		};
		this.entityID = entityID;
		abilityID = pNewAbilityID;
		actionID = abilityID % 1000;
		int value = abilityIDInput.value;
		if (value == 0 || value == abilityID)
		{
			output.Call(f);
		}
	}

	protected override void RegisterPorts()
	{
		AddValueOutput("实体ID", () => entityID);
		AddValueOutput("AbilityID", () => abilityID);
		AddValueOutput("后三位", () => actionID);
		abilityIDInput = AddValueInput<int>("技能ID");
		output = AddFlowOutput("");
	}
}
