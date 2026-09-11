using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI逻辑(指定实体类型)", 0)]
[Category("Logic/事件")]
[Description("逻辑tick AI的固定频率,例如,当1050的AI tick 的时候")]
public class AILogicWithTargetRoleID : EventNode
{
	private FlowOutput enemyOutput;

	private FlowOutput playerOutput;

	private FlowOutput otherOutput;

	private FlowOutput dieOutput;

	private int entityID;

	private ValueInput<int> roleIDInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public void LogicAIUpdate(int creationIndex, int aiID)
	{
		entityID = creationIndex;
		if (aiID == 0)
		{
			return;
		}
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(creationIndex);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityConfig && entityWithEntityID.entityConfig.mId == roleIDInput.value)
		{
			Flow f = new Flow
			{
				returnData = returnData
			};
			if (entityWithEntityID.entityBlackboard.var.mHP <= 0)
			{
				f.Call(dieOutput);
			}
			else if (RoleCampProcessor.IsEnemy(entityWithEntityID.entityCamp.mRoleTypeCamp))
			{
				enemyOutput.Call(f);
			}
			else if (RoleCampProcessor.IsPlayer(entityWithEntityID.entityCamp.mRoleTypeCamp))
			{
				playerOutput.Call(f);
			}
			else
			{
				otherOutput.Call(f);
			}
		}
	}

	protected override void RegisterPorts()
	{
		enemyOutput = AddFlowOutput("敌人");
		playerOutput = AddFlowOutput("玩家");
		otherOutput = AddFlowOutput("其他");
		dieOutput = AddFlowOutput("血量小于等于0");
		AddValueOutput("实体ID:", () => entityID);
		roleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUpdateAILogicEvent = (Action<int, int>)Delegate.Combine(simInterface.mUpdateAILogicEvent, new Action<int, int>(LogicAIUpdate));
	}
}
