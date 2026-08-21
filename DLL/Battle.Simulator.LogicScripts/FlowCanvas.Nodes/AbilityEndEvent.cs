using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能结束事件", 0)]
[Category("Logic/事件")]
[Description("当技能结束事件时触发,被Ability中断也会触发,且此时已经完成了打断事件;\n如果不是被技能中断,或者衔接的行为是移动、待机、受击等渲染层行为,新的abilityID就输出0;")]
public class AbilityEndEvent : EventNode
{
	private int _entityID;

	private int _oldAbilityID;

	private int _newAbilityID;

	private FlowOutput _output;

	private FlowOutput m_error;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name
	{
		get
		{
			if (_oldAbilityID != 0)
			{
				return base.name + "_" + _oldAbilityID;
			}
			return base.name;
		}
	}

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
		_entityID = entityID;
		_oldAbilityID = oldAbilityID;
		_newAbilityID = newAbilityID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		if (base.mSimContext.GetEntityWithEntityID(entityID) == null)
		{
			m_error.Call(f);
		}
		else
		{
			_output.Call(f);
		}
	}

	protected override void RegisterPorts()
	{
		_output = AddFlowOutput("当技能结束时");
		m_error = AddFlowOutput("Error", "error");
		AddValueOutput("实体ID", () => _entityID);
		AddValueOutput("结束的技能ID", () => _oldAbilityID);
		AddValueOutput("新的技能ID", () => _newAbilityID);
	}
}
