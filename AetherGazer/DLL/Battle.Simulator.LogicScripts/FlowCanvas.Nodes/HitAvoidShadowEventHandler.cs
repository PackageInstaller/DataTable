using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("命中闪避残影事件", 0)]
[Category("Logic/事件")]
[Description("实体命中闪避残影之后出发的事件")]
public class HitAvoidShadowEventHandler : EventNode
{
	private int m_attackerID;

	private int m_targetID;

	private int m_abilityID;

	private int m_hitIndex;

	private Int3 m_position = Int3.zero;

	private FlowOutput _output;

	private ValueInput<bool> _isRenderInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		_output = AddFlowOutput("Out");
		AddValueOutput("攻击者ID", "attackerID", () => m_attackerID);
		AddValueOutput("受击者ID", "targetID", () => m_targetID);
		AddValueOutput("TimelineID", "abilityID", () => m_abilityID);
		AddValueOutput("第几次判定", "hitIndex", () => m_hitIndex);
		AddValueOutput("命中位置", "position", () => m_position);
		_isRenderInput = AddValueInput<bool>("是否渲染");
	}

	public override void OnGraphStarted()
	{
		if (!_isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<HitAvoidShadowEvent>(OnHitAvoidShadowEventHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<HitAvoidShadowEvent>(OnHitAvoidShadowEventHandler);
		}
	}

	private void OnHitAvoidShadowEventHandler(HitAvoidShadowEvent evt)
	{
		m_attackerID = evt.mAttackerID;
		m_targetID = evt.mTargetID;
		m_abilityID = evt.mTimelineID;
		m_hitIndex = evt.mHitIndex;
		m_position = evt.mPosition;
		Flow f = new Flow
		{
			returnData = returnData
		};
		_output.Call(f);
	}
}
