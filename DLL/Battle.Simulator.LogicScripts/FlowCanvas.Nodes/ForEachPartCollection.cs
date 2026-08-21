using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历处理指定碰撞集合", 0)]
[Category("Logic/Attribute")]
[Description("遍历处理指定碰撞集合")]
public class ForEachPartCollection : FlowNode
{
	private List<EntityShape> shapes = new List<EntityShape>();

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> collectionInput = AddValueInput<int>("集合");
		FlowOutput doOut = AddFlowOutput("Do");
		FlowOutput doneOut = AddFlowOutput("Done");
		FlowOutput errorOut = AddFlowOutput("error");
		int partID = 0;
		AddValueOutput("部位ID", () => partID);
		ShapePartType partType = ShapePartType.Body;
		AddValueOutput("部位类型", () => partType);
		int res = 0;
		AddValueOutput("破坏值累计类型", () => res);
		long current = 0L;
		AddValueOutput("当前破坏值", () => current);
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
						ShapePartInfo mShapePartInfo = shapes[i].mShapePartInfo;
						partID = shapes[i].mShape.OwnerID;
						partType = shapes[i].mPartType;
						res = mShapePartInfo.destroyValChangeRule;
						current = mShapePartInfo.destroyVal;
						doOut.Call(f);
					}
				}
				doneOut.Call(f);
			}
		});
	}
}
