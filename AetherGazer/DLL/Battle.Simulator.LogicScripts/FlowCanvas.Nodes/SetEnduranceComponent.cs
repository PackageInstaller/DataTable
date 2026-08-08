using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置耐力组件", 0)]
[Category("Logic/Attribute")]
[Description("设置耐力组件")]
public class SetEnduranceComponent : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		FlowOutput falseOut = AddFlowOutput("失败");
		ValueInput<Int> maxInput = AddValueInput<Int>("最大值");
		ValueInput<Int> currentInput = AddValueInput<Int>("当前值");
		ValueInput<Int> consumeInput = AddValueInput<Int>("消耗值");
		ValueInput<Int> resumeInput = AddValueInput<Int>("回复值");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityEndurance)
			{
				f.Call(falseOut);
			}
			else
			{
				entityWithEntityID.entityEndurance.maxValue = maxInput.value;
				entityWithEntityID.entityEndurance.resumeSpeed = resumeInput.value;
				entityWithEntityID.entityEndurance.consumeValue = consumeInput.value;
				Int obj = currentInput.value;
				if (obj < 0)
				{
					obj = 0;
				}
				else if (obj > entityWithEntityID.entityEndurance.maxValue)
				{
					obj = entityWithEntityID.entityEndurance.maxValue;
				}
				entityWithEntityID.entityEndurance.currentValue = obj;
				f.Call(output);
			}
		});
	}
}
