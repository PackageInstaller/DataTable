using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加修正值(最大值千分比)", 0)]
[Category("Logic/Attribute")]
[Description("修改某个实体的修正值")]
public class AddExposedValueWithPermill : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> permillInput = AddValueInput<int>("千分之", "permill").SetDefaultAndSerializedValue(1000);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput noneOut = AddFlowOutput("无修正值", "none");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityExposedValue)
			{
				noneOut.Call(f);
			}
			else
			{
				entityWithEntityID.entityExposedValue.mValue += IntMath.Divide(entityWithEntityID.entityExposedValue.mMaxValue * permillInput.value, 1000L);
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", () => entityIDInput.value);
	}
}
