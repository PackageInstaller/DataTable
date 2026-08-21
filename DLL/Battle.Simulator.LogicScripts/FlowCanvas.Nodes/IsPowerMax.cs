using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("机制值是否已满", 0)]
[Category("Logic/Attribute")]
[Description("机制值是否已满，原能量是否已满")]
public class IsPowerMax : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		FlowOutput noneOut = AddFlowOutput("无机制类型", "none");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				falseOut.Call(f);
			}
			else if (entityWithEntityID.entityBlackboard.var.mEnergyType == EnergyType.None)
			{
				noneOut.Call(f);
			}
			else
			{
				int powerValue = AttributeProcessor.GetPowerValue(entityWithEntityID.creationIndex);
				AttributeProcessor.TryGetEnergyMaxValue(entityWithEntityID, out var maxValue);
				if (powerValue >= maxValue)
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
	}
}
