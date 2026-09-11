using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("根据部位ID获取类型", 0)]
[Category("Logic/Attribute")]
[Description("根据部位ID获取类型")]
public class GetShapeTypeByPartID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> idInput = AddValueInput<int>("部位ID");
		AddValueOutput("部位类型", delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(idInput.value);
			return (entityWithEntityID != null && entityWithEntityID.hasEntityShape) ? entityWithEntityID.entityShape.mPartType : ShapePartType.Body;
		});
	}
}
