using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取耐力组件", 0)]
[Category("Logic/Attribute")]
[Description("获取耐力组件")]
public class GetEnduranceComponent : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		FlowOutput falseOut = AddFlowOutput("失败");
		Int max = 0;
		Int current = 0;
		Int consume = 0;
		Int resume = 0;
		AddValueOutput("最大值", () => max);
		AddValueOutput("当前值", () => current);
		AddValueOutput("消耗值", () => consume);
		AddValueOutput("恢复值", () => resume);
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityEndurance)
			{
				f.Call(falseOut);
			}
			else
			{
				max = entityWithEntityID.entityEndurance.maxValue;
				current = entityWithEntityID.entityEndurance.currentValue;
				consume = entityWithEntityID.entityEndurance.consumeValue;
				resume = entityWithEntityID.entityEndurance.resumeSpeed;
				f.Call(output);
			}
		});
	}
}
