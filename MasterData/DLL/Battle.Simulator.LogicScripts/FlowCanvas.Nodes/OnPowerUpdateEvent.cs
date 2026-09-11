using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("角色机制值变更事件", 0)]
[Category("Logic/事件")]
[Description("傀儡Update的更新事件")]
public class OnPowerUpdateEvent : EventNode
{
	private FlowOutput _out;

	private FlowOutput _fullOut;

	private FlowOutput _emptyOut;

	private ValueInput<int> _roleIDInput;

	private int _entityID;

	private int _newPower;

	private int _oldPower;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mOnPowerUpdate = (Action<int, int, int, int, int, EnergyType>)Delegate.Combine(simInterface.mOnPowerUpdate, new Action<int, int, int, int, int, EnergyType>(OnUpdate));
	}

	public void OnUpdate(int entityID, int newValue, int oldValue, int newMaxValue, int oldMaxValue, EnergyType energyType)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && _roleIDInput.value == entityWithEntityID.entityConfig.mId)
		{
			_entityID = entityID;
			_newPower = newValue;
			_oldPower = oldValue;
			Flow f = new Flow
			{
				returnData = returnData
			};
			_out.Call(f);
			if (oldValue < oldMaxValue && newValue >= newMaxValue)
			{
				_fullOut.Call(f);
			}
			else if (oldValue >= oldMaxValue && newValue < newMaxValue)
			{
				_emptyOut.Call(f);
			}
		}
	}

	protected override void RegisterPorts()
	{
		_out = AddFlowOutput("输出");
		_fullOut = AddFlowOutput("不满变为满");
		_emptyOut = AddFlowOutput("满变为不满");
		AddValueOutput("实体ID", () => _entityID);
		AddValueOutput("新机制值", () => _newPower);
		AddValueOutput("旧机制值", () => _oldPower);
		AddValueOutput("变化值", "delta", () => _newPower - _oldPower);
		_roleIDInput = AddValueInput<int>("实体类型ID", "RoleID");
	}
}
