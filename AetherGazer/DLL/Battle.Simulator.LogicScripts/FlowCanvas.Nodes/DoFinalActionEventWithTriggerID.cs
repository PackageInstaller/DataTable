using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("执行终结动作的事件(触发器)", 0)]
[Category("Logic/事件")]
[Description("执行终结动作时抛出的事件")]
public class DoFinalActionEventWithTriggerID : EventNode
{
	private int entityID;

	private int deathAbilityID;

	private int killAbilityID;

	private int triggerID;

	private int killerID;

	private int thrownID;

	private FlowOutput output;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		output = AddFlowOutput("");
		AddValueOutput("实体ID", () => entityID);
		AddValueOutput("死亡行为ID", () => deathAbilityID);
		AddValueOutput("击杀行为ID", () => killAbilityID);
		AddValueOutput("触发器ID", () => triggerID);
		AddValueOutput("击杀者实体ID", () => killerID);
		AddValueOutput("击杀抛掷物ID", () => thrownID);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mDoFinalActionEvent = (Action<int, int, int, int, int>)Delegate.Combine(simInterface.mDoFinalActionEvent, new Action<int, int, int, int, int>(OnDoFinalActionEventHandler));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mDoFinalActionEvent = (Action<int, int, int, int, int>)Delegate.Remove(simInterface.mDoFinalActionEvent, new Action<int, int, int, int, int>(OnDoFinalActionEventHandler));
	}

	private void OnDoFinalActionEventHandler(int entityID, int abilityID, int killAbilityID, int killerID, int thrownID)
	{
		base.mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityTrigger)).DoAction(delegate(SimEntity triggerEntity)
		{
			if (triggerEntity.entityTrigger.mTriggerData.Type.Contains(base.graphName) && triggerEntity.entityTrigger.mEnabled)
			{
				this.entityID = entityID;
				deathAbilityID = abilityID;
				this.killAbilityID = killAbilityID;
				this.killerID = killerID;
				this.thrownID = thrownID;
				triggerID = triggerEntity.entityTrigger.mTriggerID;
				Flow f = new Flow
				{
					returnData = returnData
				};
				output.Call(f);
			}
		});
	}
}
