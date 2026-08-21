using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体销毁事件(阵营)", 0)]
[Category("Logic/事件")]
[Description("销毁实体事件")]
public class DespawnEntityEventWithCamp : EventNode
{
	private FlowOutput despawnLogicOutput;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>(16);

	private int mDestroyedEntity;

	private int mKillingEntity;

	private UnitRemoveReason mRemoveReason;

	private bool mSkipDeathSequence;

	private uint mAgentCamp;

	private int mAbilityID;

	private ValueInput<RoleType> mRoleType;

	private ValueInput<bool> _isRenderInput;

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
		mRoleType = AddValueInput<RoleType>("阵营类型");
		_isRenderInput = AddValueInput<bool>("是否渲染");
	}

	public override void OnGraphStarted()
	{
		if (_isRenderInput.GetValue())
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<EntityDespawnedEvent>(OnDeSpawnUnitEventHandler);
		}
		else
		{
			base.mSimContext.SimEventSystem.AddHandler<EntityDespawnedEvent>(OnDeSpawnUnitEventHandler);
		}
	}

	private void SetData(EntityDespawnedEvent triggerEvent)
	{
		mAgentCamp = triggerEvent.mAgentCamp;
		mDestroyedEntity = triggerEvent.DestroyedEntity;
		mKillingEntity = triggerEvent.KillingEntity;
		mRemoveReason = triggerEvent.RemoveReason;
		mSkipDeathSequence = triggerEvent.SkipDeathSequence;
		mAbilityID = triggerEvent.mAbilityID;
	}

	private void OnDeSpawnUnitEventHandler(EntityDespawnedEvent triggerEvent)
	{
		base.mSimContext.GetEntityWithEntityID(triggerEvent.DestroyedEntity);
		if ((_isRenderInput.GetValue() || RoleCampProcessor.Is(triggerEvent.mAgentCamp, (uint)mRoleType.value)) && (!_isRenderInput.value || RoleCampProcessor.Is(triggerEvent.mAgentCamp, (uint)mRoleType.value)))
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
