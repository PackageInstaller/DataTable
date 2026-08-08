using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能结束事件(实体类型ID)", 0)]
[Category("Logic/事件")]
[Description("当技能结束事件时触发,被Ability中断也会触发,且此时已经完成了打断事件;\n如果不是被技能中断,或者衔接的行为是移动、待机、受击等渲染层行为,新的abilityID就输出0;")]
public class AbilityEndEventWithRoleID : EventNode
{
	private int _entityID;

	private int _oldAbilityID;

	private int _oldActionID;

	private int _newAbilityID;

	private int _newActionID;

	private FlowOutput _output;

	private FlowOutput m_error;

	private ValueInput<int> _roleIDInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAbilityFinishLogicEvent = (Action<int, int, int>)Delegate.Combine(simInterface.mAbilityFinishLogicEvent, new Action<int, int, int>(OnAbilityFinishEventHandler));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAbilityFinishLogicEvent = (Action<int, int, int>)Delegate.Remove(simInterface.mAbilityFinishLogicEvent, new Action<int, int, int>(OnAbilityFinishEventHandler));
	}

	private void OnAbilityFinishEventHandler(int entityID, int oldAbilityID, int newAbilityID)
	{
		Flow f = new Flow
		{
			returnData = returnData
		};
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || entityWithEntityID.ENTITY_CONFIG_ID != _roleIDInput.value)
		{
			m_error.Call(f);
			return;
		}
		_entityID = entityID;
		_oldAbilityID = oldAbilityID;
		_oldActionID = oldAbilityID % 1000;
		_newAbilityID = newAbilityID;
		_newActionID = newAbilityID % 1000;
		_output.Call(f);
	}

	protected override void RegisterPorts()
	{
		_roleIDInput = AddValueInput<int>("实体类型ID", "角色类型ID");
		_output = AddFlowOutput("当技能结束时");
		m_error = AddFlowOutput("Error", "error");
		AddValueOutput("实体ID", () => _entityID);
		AddValueOutput("结束的技能ID", () => _oldAbilityID);
		AddValueOutput("结束的后三位", "oldActionID", () => _oldActionID);
		AddValueOutput("新的技能ID", () => _newAbilityID);
		AddValueOutput("进入的后三位", "newActionID", () => _newActionID);
	}
}
