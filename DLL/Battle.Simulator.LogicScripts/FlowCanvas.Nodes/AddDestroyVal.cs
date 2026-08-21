using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("累计破坏值", 0)]
[Category("Logic/Attribute")]
[Description("修改破坏值")]
public class AddDestroyVal : FlowNode
{
	private List<EntityShape> shapes = new List<EntityShape>();

	protected override void RegisterPorts()
	{
		ValueInput<int> attackerIDInput = AddValueInput<int>("攻击者ID");
		ValueInput<int> entityIDInput = AddValueInput<int>("部位ID");
		ValueInput<long> deltaValueInput = AddValueInput<long>("变化量");
		ValueInput<bool> spInput = AddValueInput<bool>("手动设置原因");
		ValueInput<int> reasonInput = AddValueInput<int>("原因");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityShape)
			{
				errorOut.Call(f);
			}
			else
			{
				ShapePartInfo mShapePartInfo = entityWithEntityID.entityShape.mShapePartInfo;
				if (mShapePartInfo.destroyValChangeRule <= 0 || mShapePartInfo.destroyValLimit <= 0)
				{
					output.Call(f);
				}
				else
				{
					int mCollection = mShapePartInfo.mCollection;
					SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID);
					if (simEntityByMultiColliders == null)
					{
						errorOut.Call(f);
					}
					else
					{
						shapes.Clear();
						SimShapeProcessor.GetAllShape(simEntityByMultiColliders, shapes);
						int num = -1;
						SimEntity entityWithEntityID2 = base.graph.mSimContext.GetEntityWithEntityID(attackerIDInput.value);
						if (entityWithEntityID2 != null && entityWithEntityID2.hasEntityBlackboard)
						{
							SimEntity entityWithEntityID3 = base.graph.mSimContext.GetEntityWithEntityID(entityWithEntityID2.entityBlackboard.var.mAimTarget);
							if (entityWithEntityID3 != null && entityWithEntityID3.hasEntityShape)
							{
								num = entityWithEntityID3.entityShape.mShapePartInfo.mCollection;
							}
						}
						bool flag = false;
						for (int i = 0; i < shapes.Count; i++)
						{
							if (shapes[i].mShapePartInfo.mCollection == mCollection)
							{
								mShapePartInfo = shapes[i].mShapePartInfo;
								if (mShapePartInfo.destroyValChangeRule == 1)
								{
									mShapePartInfo.destroyVal += deltaValueInput.value;
									flag = true;
								}
								else if (mShapePartInfo.destroyValChangeRule == 2)
								{
									if (num == -1)
									{
										errorOut.Call(f);
										return;
									}
									if (num == mCollection)
									{
										mShapePartInfo.destroyVal += deltaValueInput.value;
										flag = true;
									}
								}
								shapes[i].mShapePartInfo = mShapePartInfo;
							}
						}
						if ((deltaValueInput.value != 0) & flag)
						{
							int arg = mShapePartInfo.destroyValChangeRule;
							if (spInput.value)
							{
								arg = reasonInput.value;
							}
							base.graph.mSimContext.GetSimInterface().mDestroyValChangeEvent?.Invoke(entityWithEntityID.creationIndex, arg, mShapePartInfo.destroyVal - deltaValueInput.value, mShapePartInfo.destroyVal);
							if (mShapePartInfo.destroyVal > mShapePartInfo.destroyValLimit * simEntityByMultiColliders.entityBlackboard.var.mMaxHP / 1000)
							{
								for (int j = 0; j < shapes.Count; j++)
								{
									if (shapes[j].mShapePartInfo.mCollection == mCollection)
									{
										mShapePartInfo = shapes[j].mShapePartInfo;
										mShapePartInfo.destroyVal = 0L;
										shapes[j].mShapePartInfo = mShapePartInfo;
									}
								}
								base.graph.mSimContext.GetSimInterface().mDestroyValLimitEvent?.Invoke(entityWithEntityID.creationIndex);
							}
						}
						output.Call(f);
					}
				}
			}
		});
	}
}
