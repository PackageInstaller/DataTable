using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取破坏值积累类型", 0)]
[Category("Logic/Attribute")]
[Description("获取破坏值积累类型")]
public class GetDestroyValChangeRule : FlowNode
{
	private List<EntityShape> shapes = new List<EntityShape>();

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> collectionInput = AddValueInput<int>("集合");
		FlowOutput output = AddFlowOutput("");
		FlowOutput notFound = AddFlowOutput("找不到");
		FlowOutput errorOut = AddFlowOutput("error");
		int res = 0;
		AddValueOutput("破坏值累计类型", () => res);
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
				for (int i = 0; i < shapes.Count; i++)
				{
					if (shapes[i].mShapePartInfo.mCollection == value)
					{
						res = shapes[i].mShapePartInfo.destroyValChangeRule;
						output.Call(f);
						return;
					}
				}
				notFound.Call(f);
			}
		});
	}
}
