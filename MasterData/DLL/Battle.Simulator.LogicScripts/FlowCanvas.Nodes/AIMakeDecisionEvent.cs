using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI决策事件", 0)]
[Category("Logic/事件")]
[Description("AI决策事件")]
public class AIMakeDecisionEvent : EventNode
{
	private FlowOutput AICommandMakeDecisionOutput;

	private FlowOutput deathOutput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	private int mEntityID;

	private ValueInput<int> mRoleIDInput;

	protected override void RegisterPorts()
	{
		AICommandMakeDecisionOutput = AddFlowOutput("开始决策");
		deathOutput = AddFlowOutput("血量小于0");
		AddValueOutput("AI实体ID:", () => mEntityID);
		mRoleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAICommandMakeDecision = (Action<int, AIProcessor.AICommandStatus>)Delegate.Combine(simInterface.mAICommandMakeDecision, new Action<int, AIProcessor.AICommandStatus>(OnAICommandMakeDecisionEventHandler));
	}

	private void OnAICommandMakeDecisionEventHandler(int entityID, AIProcessor.AICommandStatus status)
	{
		mEntityID = entityID;
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(mEntityID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig || !entityWithEntityID.hasEntityAIThink)
		{
			return;
		}
		int value = mRoleIDInput.value;
		if (value == 0 || value == entityWithEntityID.entityConfig.mId)
		{
			Flow f = new Flow
			{
				returnData = returnData,
				userData = entityWithEntityID
			};
			if (entityWithEntityID.entityBlackboard.var.mHP <= 0)
			{
				deathOutput.Call(f);
			}
			else
			{
				AICommandMakeDecisionOutput.Call(f);
			}
		}
	}
}
