using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取部位坐标", 0)]
[Category("Logic/Attribute")]
[Description("获取部位坐标")]
public class GetShapePosByByPartID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> idInput = AddValueInput<int>("部位ID");
		AddValueOutput("位置", delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(idInput.value);
			return (entityWithEntityID == null || !entityWithEntityID.hasEntityShape) ? Int3.zero : entityWithEntityID.entityShape.mShape.WorldPos;
		});
	}
}
