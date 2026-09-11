using System;
using System.Collections.Generic;

namespace FlowCanvas.Nodes;

public abstract class LogicAbilityBeginEventBase : EventNode
{
	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	private int _entityID;

	private int _oldAbilityID;

	private int _newAbilityID;

	private FlowOutput _out;

	private FlowOutput _error;

	public override string name
	{
		get
		{
			if (_newAbilityID != 0)
			{
				return base.name + "_" + _newAbilityID;
			}
			return base.name;
		}
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAbilityAddedLogicEvent = (Action<int, int, int>)Delegate.Combine(simInterface.mAbilityAddedLogicEvent, new Action<int, int, int>(EventHandler));
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAbilityAddedLogicEvent = (Action<int, int, int>)Delegate.Remove(simInterface.mAbilityAddedLogicEvent, new Action<int, int, int>(EventHandler));
	}

	private void EventHandler(int pEntityID, int pOldAbilityID, int pNewAbilityID)
	{
		_entityID = pEntityID;
		_oldAbilityID = pOldAbilityID;
		_newAbilityID = pNewAbilityID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		SimEntity simEntity = (SimEntity)(f.userData = base.mSimContext.GetEntityWithEntityID(pEntityID));
		if (simEntity == null)
		{
			_error.Call(f);
		}
		else if (ConditionFunc(simEntity, pOldAbilityID, pNewAbilityID))
		{
			_out.Call(f);
		}
	}

	protected abstract void AddCustomValueInput();

	protected abstract void AddCustomValueOutput();

	protected abstract bool ConditionFunc(SimEntity pSimEntity, int pOldAbilityID, int pNewAbilityID);

	protected override void RegisterPorts()
	{
		AddBaseFlowOutput();
		AddCustomValueInput();
		AddBaseValueOutput();
		AddCustomValueOutput();
	}

	private void AddBaseFlowOutput()
	{
		_out = AddFlowOutput("当技能开始时", "skillBegin");
		_error = AddFlowOutput("Error", "error");
	}

	private void AddBaseValueOutput()
	{
		AddValueOutput("实体ID", "entityID", () => _entityID);
		AddValueOutput("结束的技能ID", () => _oldAbilityID);
		AddValueOutput("新的技能ID", () => _newAbilityID);
	}
}
