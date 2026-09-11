using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("消耗耐力", 0)]
[Category("Logic/Attribute")]
[Description("消耗耐力")]
public class ConsumeEndurance : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<Int> factorInput = AddValueInput<Int>("千分比").SetDefaultAndSerializedValue(1000);
		FlowOutput trueOut = AddFlowOutput("成功");
		FlowOutput falseOut = AddFlowOutput("失败");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityEndurance)
			{
				Int obj = (entityWithEntityID.entityEndurance.consumeValue * factorInput.value).i / 1000;
				entityWithEntityID.entityEndurance.currentValue -= obj;
				if (entityWithEntityID.entityEndurance.currentValue < 0)
				{
					entityWithEntityID.entityEndurance.currentValue = 0;
					f.Call(falseOut);
				}
				else
				{
					f.Call(trueOut);
				}
			}
		});
	}
}
