using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体销毁事件(实体ID)", 0)]
[Category("Logic/事件")]
[Description("销毁实体事件")]
public class DespawnEntityEventWithEntityID : EventNode
{
	private FlowOutput despawnLogicOutput;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>(16);

	private int mDestroyedEntity;

	private int mKillingEntity;

	private UnitRemoveReason mRemoveReason;

	private bool mSkipDeathSequence;

	private uint mAgentCamp;

	private int mAbilityID;

	private ValueInput<int> mID;

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		despawnLogicOutput = AddFlowOutput("输出");
		AddValueOutput("实体阵营：", () => mAgentCamp);
		AddValueOutput("击杀者：", () => mKillingEntity);
		AddValueOutput("实体ID：", () => mDestroyedEntity);
		AddValueOutput("死亡原因：", () => mRemoveReason);
		AddValueOutput("是否跳过死亡动作：", () => mSkipDeathSequence);
		AddValueOutput("击杀手段：", () => mAbilityID);
		mID = AddValueInput<int>("实体ID");
	}

	public override void OnGraphStarted()
	{
		base.mSimContext.SimEventSystem.AddHandler<EntityDespawnedEvent>(OnDeSpawnUnitEventHandler);
	}

	private void SetData(EntityDespawnedEvent triggerEvent)
	{
		mAgentCamp = triggerEvent.mAgentCamp;
		mDestroyedEntity = triggerEvent.DestroyedEntity;
		mKillingEntity = triggerEvent.KillingEntity;
		mRemoveReason = triggerEvent.RemoveReason;
		mSkipDeathSequence = triggerEvent.SkipDeathSequence;
		mAgentCamp = triggerEvent.mAgentCamp;
		mAbilityID = triggerEvent.mAbilityID;
	}

	private void OnDeSpawnUnitEventHandler(EntityDespawnedEvent triggerEvent)
	{
		if (mID.value == triggerEvent.DestroyedEntity)
		{
			SetData(triggerEvent);
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			despawnLogicOutput.Call(f);
		}
	}
}
