using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体销毁事件(触发器)", 0)]
[Category("Logic/事件")]
[Description("当对应的触发器处于激活状态且发生了销毁实体时触发,有输入作为过滤,如果输入ID为0则认为没有输入, 如果输入阵营为None则认为没有输入")]
public class DespawnEntityEventWithTriggerID : EventNode
{
	private FlowOutput despawnLogicOutput;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>(16);

	private int mDestroyedEntity;

	private int mKillingEntity;

	private UnitRemoveReason mRemoveReason;

	private bool mSkipDeathSequence;

	private uint mAgentCamp;

	private int mAbilityID;

	private ValueOutput<int> triggerIDOutput;

	private int triggerID;

	private ValueInput<RoleType> entityCampInput;

	private ValueInput<int> killerIDInput;

	private ValueInput<int> entityIDInput;

	protected override void RegisterPorts()
	{
		despawnLogicOutput = AddFlowOutput("输出");
		AddValueOutput("阵营", () => mAgentCamp);
		AddValueOutput("击杀者ID", () => mKillingEntity);
		AddValueOutput("实体ID", () => mDestroyedEntity);
		AddValueOutput("死亡原因：", () => mRemoveReason);
		AddValueOutput("是否跳过死亡动作：", () => mSkipDeathSequence);
		AddValueOutput("击杀手段：", () => mAbilityID);
		triggerIDOutput = AddValueOutput("触发器ID", () => triggerID);
		entityCampInput = AddValueInput<RoleType>("阵营");
		killerIDInput = AddValueInput<int>("击杀者ID");
		entityIDInput = AddValueInput<int>("实体ID");
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
		base.mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityTrigger)).DoAction(delegate(SimEntity triggerEntity)
		{
			if (triggerEntity.entityTrigger.mTriggerData.Type.Contains(base.graphName) && triggerEntity.entityTrigger.mEnabled)
			{
				triggerID = triggerEntity.entityTrigger.mTriggerID;
				if ((entityCampInput.value == RoleType.None || RoleCampProcessor.Is(triggerEvent.mAgentCamp, (uint)entityCampInput.value)) && (killerIDInput.value == 0 || killerIDInput.value == triggerEvent.KillingEntity) && (entityIDInput.value == 0 || triggerEvent.DestroyedEntity == entityIDInput.value))
				{
					SetData(triggerEvent);
					Flow f = new Flow
					{
						returnData = mReturnData
					};
					despawnLogicOutput.Call(f);
				}
			}
		});
	}
}
