using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体将被命中事件(目标实体类型ID)", 0)]
[Category("Logic/事件")]
[Description("实体将被命中事件")]
public class WillBeHitEventWithTargetRoleID : EventNode
{
	private FlowOutput output;

	private int _attacker;

	private int _target;

	private int _abilityID;

	private ValueInput<int> roleIDInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		AddValueOutput("攻击者ID", () => _attacker);
		AddValueOutput("目标ID", () => _target);
		AddValueOutput("技能ID", () => _abilityID);
		roleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
		output = AddFlowOutput("");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mWillBeHitEvent = (Action<int, int, int>)Delegate.Combine(simInterface.mWillBeHitEvent, new Action<int, int, int>(EventHandle));
	}

	private void EventHandle(int attacker, int abilityID, int target)
	{
		int value = roleIDInput.value;
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(target);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityConfig && (value == 0 || value == entityWithEntityID.entityConfig.mId))
		{
			_attacker = attacker;
			_target = target;
			_abilityID = abilityID;
			Flow flow = default(Flow);
			flow.returnData = returnData;
			flow.Call(output);
		}
	}
}
