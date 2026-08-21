using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[庚辰]鱼机制组合(位)", 0)]
[Category("Logic/角色定制/庚辰")]
[Description("庚辰特殊机制的组合卦象")]
public class GetYu : FlowControlNodeOfLogic
{
	private long _result;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_result = 0L;
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				uint num = 0u;
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600220, out var baseValue, out var _, out var _);
				long baseValue2 = 0L;
				long plusValue2 = 0L;
				long tempPlusValue2 = 0L;
				for (int i = 0; i < baseValue; i++)
				{
					switch (i)
					{
					case 0:
						AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600221, out baseValue2, out plusValue2, out tempPlusValue2);
						break;
					case 1:
						AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600222, out baseValue2, out plusValue2, out tempPlusValue2);
						break;
					case 2:
						AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600223, out baseValue2, out plusValue2, out tempPlusValue2);
						break;
					case 3:
						AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600224, out baseValue2, out plusValue2, out tempPlusValue2);
						break;
					}
					num = ((baseValue2 != 1) ? (num & (uint)(~(1 << i))) : (num | (uint)(1 << i)));
				}
				num |= (uint)((int)baseValue << 16);
				_result = num;
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("鱼(位)", "result", () => _result);
	}
}
