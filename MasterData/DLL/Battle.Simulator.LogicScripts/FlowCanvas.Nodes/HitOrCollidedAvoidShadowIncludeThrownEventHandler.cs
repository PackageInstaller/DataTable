using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("命中闪避残影事件(整合)", 0)]
[Category("Logic/事件")]
[Description("整合【命中闪避残影事件】、【命中闪避残影事件(抛掷物)】、【接触闪避残影事件(抛掷物)】")]
public class HitOrCollidedAvoidShadowIncludeThrownEventHandler : EventNode
{
	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	private int m_attackerID;

	private int m_targetID;

	private int m_abilityID;

	private int m_hitIndex;

	private Int3 m_position = Int3.zero;

	private int m_thrownID;

	private int m_thrownAbilityID;

	private FlowOutput m_entityHit;

	private FlowOutput m_thrownHit;

	private FlowOutput m_thrownCollided;

	private ValueInput<bool> _isRenderInput;

	protected override void RegisterPorts()
	{
		m_entityHit = AddFlowOutput("角色命中", "entityHit");
		m_thrownHit = AddFlowOutput("抛掷物命中", "thrownHit");
		m_thrownCollided = AddFlowOutput("抛掷物接触", "thrownCollided");
		_isRenderInput = AddValueInput<bool>("是否渲染");
		AddValueOutput("攻击者ID", "attackerID", () => m_attackerID);
		AddValueOutput("闪避方ID", "targetID", () => m_targetID);
		AddValueOutput("AbilitiID", "abilityID", () => m_abilityID);
		AddValueOutput("第几次判定", "hitIndex", () => m_hitIndex);
		AddValueOutput("命中位置", "position", () => m_position);
		AddValueOutput("抛掷物ID", "thrownID", () => m_thrownID);
		AddValueOutput("抛掷物AbilityID", () => m_thrownAbilityID);
		AddValueOutput("接触索引", "collisionIndex", () => m_hitIndex);
	}

	public override void OnGraphStarted()
	{
		if (!_isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<HitAvoidShadowEvent>(OnHitAvoidShadowEventHandler);
			base.mSimContext.SimEventSystem.AddHandler<HitAvoidShadowByThrownEvent>(OnHitAvoidShadowByThrownEventHandler);
			base.mSimContext.SimEventSystem.AddHandler<ThrownCollideToAvoidShadowEvent>(OnThrownCollideToAvoidShadowEventHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<HitAvoidShadowEvent>(OnHitAvoidShadowEventHandler);
			base.mSimContext.SimToPresentationEventSystem.AddHandler<HitAvoidShadowByThrownEvent>(OnHitAvoidShadowByThrownEventHandler);
			base.mSimContext.SimToPresentationEventSystem.AddHandler<ThrownCollideToAvoidShadowEvent>(OnThrownCollideToAvoidShadowEventHandler);
		}
	}

	private void OnHitAvoidShadowEventHandler(HitAvoidShadowEvent evt)
	{
		MerageEventData(evt.mAttackerID, evt.mTargetID, evt.mTimelineID, evt.mHitIndex, evt.mPosition);
	}

	private void OnHitAvoidShadowByThrownEventHandler(HitAvoidShadowByThrownEvent evt)
	{
		if (ThrownProcessor.TryGetThrown(base.mSimContext, evt.mThrownID, out var thrownState))
		{
			MerageEventData(thrownState.mCasterID, evt.mTargetID, thrownState.mCreatedRootTimelineID, evt.mHitIndex, evt.mPosition, thrownState.mCreationIndex, thrownState.mAbilityID);
		}
	}

	private void OnThrownCollideToAvoidShadowEventHandler(ThrownCollideToAvoidShadowEvent evt)
	{
		if (ThrownProcessor.TryGetThrown(base.mSimContext, evt.mThrownID, out var thrownState))
		{
			uint mCamp = thrownState.mCamp;
			if (CommonProcessor.TryGetAliveRole(base.mSimContext, thrownState.mTargetID, out var simEntity) && simEntity.hasEntityCamp && simEntity.entityCamp.mRoleTypeCamp != mCamp)
			{
				MerageEventData(thrownState.mCasterID, evt.mColliedID, thrownState.mCreatedRootTimelineID, evt.mIndex, evt.mPosition, thrownState.mCreationIndex, thrownState.mAbilityID, isCollision: true);
			}
		}
	}

	private void MerageEventData(int attackerID, int targetID, int abilityID, int hitIndex, Int3 position, int mThrownID = 0, int thrownAbilityID = 0, bool isCollision = false)
	{
		m_attackerID = attackerID;
		m_targetID = targetID;
		m_abilityID = abilityID;
		m_hitIndex = hitIndex;
		m_position = position;
		m_thrownID = mThrownID;
		m_thrownAbilityID = thrownAbilityID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		if (isCollision)
		{
			m_thrownCollided.Call(f);
		}
		else if (mThrownID != 0)
		{
			m_thrownHit.Call(f);
		}
		else
		{
			m_entityHit.Call(f);
		}
	}
}
