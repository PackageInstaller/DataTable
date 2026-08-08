using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("机制值变更事件", 0)]
[Category("Logic/事件")]
[Description("机制值变更事件，原能量变更事件")]
public class PowerUpdateEvent : EventNode
{
	protected int _entityID;

	protected int _power;

	protected int _OldValue;

	protected FlowOutput _out;

	protected FlowOutput _fullOut;

	protected FlowOutput _emptyOut;

	protected ValueInput<e_EnergyType> _energyType;

	protected Stack<Flow.ReturnData> _returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		_energyType = AddValueInput<e_EnergyType>("机制值类型", "energyType").SetDefaultAndSerializedValue(e_EnergyType.All);
		_out = AddFlowOutput("Out");
		_fullOut = AddFlowOutput("不满变为满");
		_emptyOut = AddFlowOutput("满变为不满");
		AddValueOutput("实体ID", () => _entityID);
		AddValueOutput("机制值", "能量", () => _power);
		AddValueOutput("原机制值", "oldValue", () => _OldValue);
		AddValueOutput("变化值", "delta", () => _power - _OldValue);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mOnPowerUpdate = (Action<int, int, int, int, int, EnergyType>)Delegate.Combine(simInterface.mOnPowerUpdate, new Action<int, int, int, int, int, EnergyType>(OnPowerUpdate));
	}

	protected virtual void OnPowerUpdate(int entityID, int newValue, int oldValue, int newMaxValue, int oldMaxValue, EnergyType energyType)
	{
		if (_energyType.value != e_EnergyType.All && _energyType.value != (e_EnergyType)energyType)
		{
			return;
		}
		_entityID = entityID;
		_power = newValue;
		_OldValue = oldValue;
		Flow f = new Flow
		{
			returnData = _returnData
		};
		_out.Call(f);
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null)
		{
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
}
