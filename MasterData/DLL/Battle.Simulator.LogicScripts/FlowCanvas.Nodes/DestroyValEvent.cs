using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("破坏值变化事件", 0)]
[Category("Logic/事件")]
[Description("破坏值变化事件, 类型id为0表示不过滤, 集合为-1表示不过滤")]
public class DestroyValEvent : EventNode
{
	private FlowOutput output;

	private ValueInput<int> roleIDInput;

	private ValueInput<int> collectionInput;

	private int reason;

	private long oldValue;

	private long newValue;

	private int entityID;

	private int collectionID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		roleIDInput = AddValueInput<int>("实体类型ID");
		collectionInput = AddValueInput<int>("集合").SetDefaultAndSerializedValue(-1);
		output = AddFlowOutput("");
		AddValueOutput("实体ID", () => entityID);
		AddValueOutput("变化原因", () => reason);
		AddValueOutput("集合ID", () => collectionID);
		AddValueOutput("变化前的值", () => oldValue);
		AddValueOutput("变化后的值", () => newValue);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mDestroyValChangeEvent = (Action<int, int, long, long>)Delegate.Combine(simInterface.mDestroyValChangeEvent, new Action<int, int, long, long>(OnEventhandler));
	}

	private void OnEventhandler(int partID, int reason, long oldValue, long newValue)
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
				this.reason = reason;
				this.oldValue = oldValue;
				this.newValue = newValue;
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
