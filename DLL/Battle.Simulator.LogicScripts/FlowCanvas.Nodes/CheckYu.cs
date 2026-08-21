using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[庚辰]鱼机制检查", 0)]
[Category("Logic/角色定制/庚辰")]
[Description("庚辰特殊机制的增加处理")]
public class CheckYu : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<bool> valueInput = AddValueInput<bool>("鱼(正阳负阴)", "value");
		ValueInput<int> numInput = AddValueInput<int>("数量", "num");
		FlowOutput enoughOut = AddFlowOutput("充足", "enough");
		FlowOutput lessOut = AddFlowOutput("不足", "less");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			long baseValue;
			long plusValue;
			long tempPlusValue;
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else if (!AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600220, out baseValue, out plusValue, out tempPlusValue) || baseValue < numInput.value)
			{
				lessOut.Call(f);
			}
			else
			{
				int num = 0;
				int num2 = 0;
				long baseValue2 = 0L;
				for (int i = 0; i < baseValue; i++)
				{
					switch (i)
					{
					case 0:
						AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600221, out baseValue2, out plusValue, out tempPlusValue);
						break;
					case 1:
						AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600222, out baseValue2, out plusValue, out tempPlusValue);
						break;
					case 2:
						AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600223, out baseValue2, out plusValue, out tempPlusValue);
						break;
					case 3:
						AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600224, out baseValue2, out plusValue, out tempPlusValue);
						break;
					}
					switch (baseValue2)
					{
					case 1L:
						num++;
						break;
					case -1L:
						num2++;
						break;
					}
				}
				bool flag = false;
				if ((!valueInput.value) ? (num2 >= numInput.value) : (num >= numInput.value))
				{
					enoughOut.Call(f);
				}
				else
				{
					lessOut.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
