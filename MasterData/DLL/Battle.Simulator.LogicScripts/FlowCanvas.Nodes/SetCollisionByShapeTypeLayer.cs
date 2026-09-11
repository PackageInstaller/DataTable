using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置指定碰撞(类型)层级", 0)]
[Category("Logic/Attribute")]
[Description("设置指定碰撞(类型)层级, 设置成空气墙就不能被锁定了")]
public class SetCollisionByShapeTypeLayer : FlowNode
{
	private List<EntityShape> shapes = new List<EntityShape>();

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<ShapePartType> shapePartTypeInput = AddValueInput<ShapePartType>("部位类型");
		ValueInput<RoleType> valueInput = AddValueInput<RoleType>("层级");
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
						shapes[i].mLayer = (uint)valueInput.value;
						shapes[i].mShape.Layer = valueInput.value;
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
