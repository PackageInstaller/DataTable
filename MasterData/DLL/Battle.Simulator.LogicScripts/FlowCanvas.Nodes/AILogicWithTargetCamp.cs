using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI逻辑(指定阵营)", 0)]
[Category("Logic/事件")]
[Description("逻辑tick AI的固定频率,例如,当玩家方的AI tick 的时候, 如果输入阵营为none, 则不进行判断")]
public class AILogicWithTargetCamp : EventNode
{
	private FlowOutput output;

	private FlowOutput dieOutput;

	private int entityID;

	private ValueInput<RoleType> roleTypeInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public void LogicAIUpdate(int creationIndex, int aiID)
	{
		entityID = creationIndex;
		if (aiID == 0)
		{
			return;
		}
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(creationIndex);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityCamp && (entityWithEntityID.entityCamp.mRoleTypeCamp == 0 || entityWithEntityID.entityCamp.mRoleTypeCamp == (uint)roleTypeInput.value))
		{
			Flow f = new Flow
			{
				returnData = returnData
			};
			if (entityWithEntityID.entityBlackboard.var.mHP <= 0)
			{
				f.Call(dieOutput);
			}
			else
			{
				output.Call(f);
			}
		}
	}

	protected override void RegisterPorts()
	{
		output = AddFlowOutput("每帧输出");
		AddValueOutput("实体ID:", () => entityID);
		dieOutput = AddFlowOutput("血量小于等于0");
		roleTypeInput = AddValueInput<RoleType>("角色阵营");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUpdateAILogicEvent = (Action<int, int>)Delegate.Combine(simInterface.mUpdateAILogicEvent, new Action<int, int>(LogicAIUpdate));
	}
}
