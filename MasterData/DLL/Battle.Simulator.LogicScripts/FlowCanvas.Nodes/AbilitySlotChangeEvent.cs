using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能槽切换事件", 0)]
[Category("Logic/事件")]
[Description("技能槽切换事件, 修改技能槽内容的时候触发, 修改普攻移动受击之类的不会触发")]
public class AbilitySlotChangeEvent : EventNode
{
	private FlowOutput output;

	private int entityID;

	private int abilityIndex;

	private int abilityIDOld;

	private int abilityIDNew;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		output = AddFlowOutput("");
		AddValueOutput("实体ID", () => entityID);
		AddValueOutput("SlotIndex", "技能下标", () => abilityIndex);
		AddValueOutput("旧的abilityID", () => abilityIDOld);
		AddValueOutput("新的abilityID", () => abilityIDNew);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAbilitySlotsChangeEvent = (Action<int, int, int, int>)Delegate.Combine(simInterface.mAbilitySlotsChangeEvent, new Action<int, int, int, int>(OnEventHandler));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAbilitySlotsChangeEvent = (Action<int, int, int, int>)Delegate.Remove(simInterface.mAbilitySlotsChangeEvent, new Action<int, int, int, int>(OnEventHandler));
	}

	private void OnEventHandler(int entityID, int abilityIndex, int abilityIDOld, int abilityIDNew)
	{
		this.entityID = entityID;
		this.abilityIndex = abilityIndex;
		this.abilityIDOld = abilityIDOld;
		this.abilityIDNew = abilityIDNew;
		Flow f = new Flow
		{
			returnData = returnData
		};
		output.Call(f);
	}
}
