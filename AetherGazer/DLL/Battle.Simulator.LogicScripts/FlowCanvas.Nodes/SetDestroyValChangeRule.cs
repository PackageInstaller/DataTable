using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置破坏值积累类型", 0)]
[Category("Logic/Attribute")]
[Description("设置破坏值积累类型")]
public class SetDestroyValChangeRule : FlowNode
{
	private List<EntityShape> shapes = new List<EntityShape>();

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> collectionInput = AddValueInput<int>("集合");
		ValueInput<int> valueInput = AddValueInput<int>("值");
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
				int value = collectionInput.value;
				shapes.Clear();
				SimShapeProcessor.GetAllShape(entityWithEntityID, shapes);
				bool flag = false;
				for (int i = 0; i < shapes.Count; i++)
				{
					if (shapes[i].mShapePartInfo.mCollection == value)
					{
						ShapePartInfo mShapePartInfo = shapes[i].mShapePartInfo;
						mShapePartInfo.destroyValChangeRule = valueInput.value;
						shapes[i].mShapePartInfo = mShapePartInfo;
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
