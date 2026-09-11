using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("执行终结动作的事件(实体类型ID)", 0)]
[Category("Logic/事件")]
[Description("执行终结动作时抛出的事件")]
public class DoFinalActionEventWithRoleID : EventNode
{
	private int _entityID;

	private int _deathAbilityID;

	private int _killAbilityID;

	private int _killerID;

	private int _thrownID;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	private ValueInput<int> _roleID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		_output = AddFlowOutput("Out", "output");
		_roleID = AddValueInput<int>("实体类型ID", "roleID");
		AddValueOutput("实体ID", () => _entityID);
		AddValueOutput("死亡行为ID", () => _deathAbilityID);
		AddValueOutput("击杀行为ID", () => _killAbilityID);
		AddValueOutput("击杀者实体ID", () => _killerID);
		AddValueOutput("击杀抛掷物ID", () => _thrownID);
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
		_entityID = 0;
		_deathAbilityID = 0;
		_killAbilityID = 0;
		_thrownID = 0;
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityConfig && entityWithEntityID.entityConfig.mId == _roleID.value)
		{
			_entityID = entityID;
			_deathAbilityID = abilityID;
			_killAbilityID = killAbilityID;
			_thrownID = thrownID;
			_killerID = killerID;
			Flow f = new Flow
			{
				returnData = returnData
			};
			_output.Call(f);
		}
	}
}
