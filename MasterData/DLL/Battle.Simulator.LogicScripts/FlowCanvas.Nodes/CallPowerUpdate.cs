using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("调用机制值变更事件", 0)]
[Category("Logic/事件")]
[Description("调用机制值变更事件，原调用能量变更事件")]
public class CallPowerUpdate : FlowControlNode
{
	private ValueInput<int> _entityIDInput;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> _deltaValueInput = AddValueInput<int>("变化值");
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("IN", delegate(Flow f)
		{
			int powerValue = AttributeProcessor.GetPowerValue(_entityIDInput.value);
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else
			{
				charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID);
				AttributeProcessor.TryGetEnergyMaxValue(base.mSimContext.GetEntityWithEntityID(_entityIDInput.value), out var maxValue);
				if (base.mSimContext.GetSimInterface().mOnPowerUpdate != null)
				{
					base.mSimContext.GetSimInterface().mOnPowerUpdate(_entityIDInput.value, powerValue, powerValue - _deltaValueInput.value, maxValue, maxValue, (EnergyType)config.EnergyType);
				}
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.GetValue());
	}
}
