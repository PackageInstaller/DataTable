using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("计算连乘属性", 0)]
[Category("Logic/Attribute")]
[Description("计算连乘属性,\n flag 为 true 时: (1000 + 原值) * (1000 + 连乘值) / 1000 - 1000 \n flag 为 false时: 1000 - (1000 - 原值) * (1000 - 连乘值) / 1000 ")]
public class CalculateAttribute : FlowNode
{
	public bool flag = true;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		long res = 0L;
		AddValueOutput("变化值", () => res);
		ValueInput<int> attrIDInput = AddValueInput<int>("属性ID");
		ValueInput<int> valueInput = AddValueInput<int>("连乘值");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID != null)
			{
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, attrIDInput.value, out var _, out var plusValue, out var _);
				if (flag)
				{
					res = (1000 + plusValue) * (1000 + valueInput.value) / 1000 - 1000 - plusValue;
				}
				else
				{
					res = 1000 - plusValue - (1000 - plusValue) * (1000 - valueInput.value) / 1000;
				}
			}
			f.Call(output);
		});
	}
}
