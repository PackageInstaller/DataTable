using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("破坏值达到上限事件", 0)]
[Category("Logic/事件")]
[Description("破坏值达到上限事件, 类型id为0表示不过滤, 集合为-1表示不过滤")]
public class DestroyValLimitEvent : EventNode
{
	private FlowOutput output;

	private ValueInput<int> roleIDInput;

	private ValueInput<int> collectionInput;

	private int entityID;

	private int collectionID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		roleIDInput = AddValueInput<int>("实体类型ID");
		collectionInput = AddValueInput<int>("集合").SetDefaultAndSerializedValue(-1);
		output = AddFlowOutput("");
		AddValueOutput("实体ID", () => entityID);
		AddValueOutput("集合ID", () => collectionID);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mDestroyValLimitEvent = (Action<int>)Delegate.Combine(simInterface.mDestroyValLimitEvent, new Action<int>(OnEventhandler));
	}

	private void OnEventhandler(int partID)
	{
		SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(partID);
		SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID);
		if (simEntityByMultiColliders == null || !simEntityByMultiColliders.hasEntityConfig || entityWithEntityID == null || !entityWithEntityID.hasEntityShape)
		{
			return;
		}
		int value = roleIDInput.value;
		if (value == 0 || value == simEntityByMultiColliders.entityConfig.mId)
		{
			collectionID = collectionInput.value;
			if (collectionID == -1 || entityWithEntityID.entityShape.mShapePartInfo.mCollection == collectionID)
			{
				collectionID = entityWithEntityID.entityShape.mShapePartInfo.mCollection;
				entityID = simEntityByMultiColliders.creationIndex;
				Flow f = new Flow
				{
					returnData = returnData
				};
				output.Call(f);
			}
		}
	}
}
