using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置指定碰撞(类型)忽略移动碰撞", 0)]
[Category("Logic/Attribute")]
[Description("设置指定碰撞(类型)忽略移动碰撞")]
public class SetCollisionByShapeTypeIgnoreCollision : FlowNode
{
	private List<EntityShape> shapes = new List<EntityShape>();

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<ShapePartType> shapePartTypeInput = AddValueInput<ShapePartType>("部位类型");
		ValueInput<bool> valueInput = AddValueInput<bool>("忽略移动碰撞");
		FlowOutput output = AddFlowOutput("");
		FlowOutput notFound = AddFlowOutput("找不到");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else
			{
				ShapePartType value = shapePartTypeInput.value;
				shapes.Clear();
				SimShapeProcessor.GetAllShapeWithUnable(entityWithEntityID, shapes);
				bool flag = false;
				for (int i = 0; i < shapes.Count; i++)
				{
					if (shapes[i].mPartType == value)
					{
						shapes[i].mShape.IgnoreCollision = valueInput.value;
						flag = true;
					}
				}
				if (flag)
				{
					output.Call(f);
				}
				else
				{
					notFound.Call(f);
				}
			}
		});
	}
}
