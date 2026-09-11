using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("接触闪避残影事件(抛掷物)(过时)", 0)]
[Category("Logic/事件")]
[Description("实体接触闪避残影之后出发的事件")]
public class ThrownCollideToAvoidShadowEventHandler : EventNode
{
	private int m_thrownID;

	private int m_targetID;

	private int m_timelineID;

	private int m_hitIndex;

	private Int3 m_position = Int3.zero;

	private FlowOutput _output;

	private ValueInput<bool> _isRenderInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		_output = AddFlowOutput("Out");
		AddValueOutput("抛掷物ID", "attackerID", () => m_thrownID);
		AddValueOutput("受击者ID", "targetID", () => m_targetID);
		AddValueOutput("TimelineID", "abilityID", () => m_timelineID);
		AddValueOutput("第几次判定", "hitIndex", () => m_hitIndex);
		AddValueOutput("命中位置", "position", () => m_position);
		_isRenderInput = AddValueInput<bool>("是否渲染");
	}

	public override void OnGraphStarted()
	{
		if (!_isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<ThrownCollideToAvoidShadowEvent>(OnThrownCollideToAvoidShadowEventHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<ThrownCollideToAvoidShadowEvent>(OnThrownCollideToAvoidShadowEventHandler);
		}
	}

	private void OnThrownCollideToAvoidShadowEventHandler(ThrownCollideToAvoidShadowEvent evt)
	{
		if (!ThrownProcessor.TryGetThrown(base.mSimContext, evt.mThrownID, out var thrownState))
		{
			return;
		}
		uint mCamp = thrownState.mCamp;
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(evt.mColliedID);
		if (entityWithEntityID.hasEntityCamp)
		{
			uint mRoleTypeCamp = entityWithEntityID.entityCamp.mRoleTypeCamp;
			if (mCamp != mRoleTypeCamp)
			{
				m_thrownID = evt.mThrownID;
				m_targetID = evt.mColliedID;
				m_timelineID = evt.mTimelineID;
				m_hitIndex = evt.mIndex;
				m_position = evt.mPosition;
				Flow f = new Flow
				{
					returnData = returnData
				};
				_output.Call(f);
			}
		}
	}
}
