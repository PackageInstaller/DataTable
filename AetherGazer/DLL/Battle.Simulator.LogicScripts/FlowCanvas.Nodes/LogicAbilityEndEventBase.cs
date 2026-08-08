using System;
using System.Collections.Generic;

namespace FlowCanvas.Nodes;

public abstract class LogicAbilityEndEventBase : EventNode
{
	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	private int _EntityID;

	private int _OldAbilityID;

	private int _NewAbilityID;

	private FlowOutput _Out;

	private FlowOutput _Error;

	public override string name
	{
		get
		{
			if (_OldAbilityID != 0)
			{
				return base.name + "_" + _OldAbilityID;
			}
			return base.name;
		}
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAbilityFinishLogicEvent = (Action<int, int, int>)Delegate.Combine(simInterface.mAbilityFinishLogicEvent, new Action<int, int, int>(EventHandler));
	}

	private void EventHandler(int pEntityID, int pOldAbilityID, int pNewAbilityID)
	{
		_EntityID = pEntityID;
		_OldAbilityID = pOldAbilityID;
		_NewAbilityID = pNewAbilityID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		SimEntity simEntity = (SimEntity)(f.userData = base.mSimContext.GetEntityWithEntityID(pEntityID));
		if (simEntity == null)
		{
			_Error.Call(f);
		}
		else if (ConditionFunc(simEntity, pOldAbilityID, pNewAbilityID))
		{
			_Out.Call(f);
		}
	}

	protected abstract void AddCustomValueInput();

	protected abstract void AddCustomValueOutput();

	protected abstract bool OnHitCheck(SimEntity pSimEntity, int pOldAbilityID, int pNewAbilityID);

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
		_Out = AddFlowOutput("当技能结束时", "skillEnd");
		_Error = AddFlowOutput("Error", "error");
	}

	private void AddBaseValueOutput()
	{
		AddValueOutput("实体ID", "entityID", () => _EntityID);
		AddValueOutput("结束的技能ID", () => _OldAbilityID);
		AddValueOutput("新的技能ID", () => _NewAbilityID);
	}
}
