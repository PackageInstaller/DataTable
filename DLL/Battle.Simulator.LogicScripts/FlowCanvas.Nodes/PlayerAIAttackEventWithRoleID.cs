using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("玩家方AI攻击事件(实体类型ID)", 0)]
[Category("Logic/事件")]
[Description("玩家方AI攻击事件")]
public class PlayerAIAttackEventWithRoleID : EventNode
{
	private int entityID;

	private FlowOutput output;

	private ValueInput<int> roleIDInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		AddValueOutput("实体ID", () => entityID);
		roleIDInput = AddValueInput<int>("实体类型ID", "角色类型ID");
		output = AddFlowOutput("");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mPlayerAIAttackEvent = (Action<int>)Delegate.Combine(simInterface.mPlayerAIAttackEvent, new Action<int>(OnEventhandler));
	}

	private void OnEventhandler(int obj)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(obj);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard && entityWithEntityID.hasEntityConfig)
		{
			int value = roleIDInput.value;
			if (value == 0 || value == entityWithEntityID.entityConfig.mId)
			{
				entityID = obj;
				Flow f = new Flow
				{
					returnData = returnData
				};
				output.Call(f);
			}
		}
	}
}
