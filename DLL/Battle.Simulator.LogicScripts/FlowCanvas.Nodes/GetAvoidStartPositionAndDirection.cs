using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[庚辰]得到闪避起点坐标", 0)]
[Category("Logic/角色定制/庚辰")]
[Description("庚辰闪避机制得到起点坐标")]
public class GetAvoidStartPositionAndDirection : FlowControlNodeOfLogic
{
	private int _direction;

	private Int3 _pos;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107630505, out var baseValue, out var plusValue, out var tempPlusValue);
				_direction = (int)baseValue;
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107630502, out var baseValue2, out plusValue, out tempPlusValue);
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107630503, out var baseValue3, out plusValue, out tempPlusValue);
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107630504, out var baseValue4, out plusValue, out tempPlusValue);
				_pos = new Int3((int)baseValue2, (int)baseValue3, (int)baseValue4);
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("朝向(1前-1后)", "direction", () => _direction);
		AddValueOutput("坐标", "pos", () => _pos);
	}
}
