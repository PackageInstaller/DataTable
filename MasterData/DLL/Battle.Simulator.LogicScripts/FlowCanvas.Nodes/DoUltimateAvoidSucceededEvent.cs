using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("闪避效果触发事件", 0)]
[Category("Logic/事件")]
[Description("需要考虑极限闪避是否CD，词缀是否关闭了极限闪避等，都满足的情况下闪成功了就会触发，和触发的什么效果没有关系")]
public class DoUltimateAvoidSucceededEvent : EventNode
{
	private Stack<Flow.ReturnData> _returnData = new Stack<Flow.ReturnData>(16);

	private ValueInput<bool> _IsRenderInput;

	private FlowOutput _Out;

	private int m_AvoiderID;

	private int m_AttackerID;

	protected override void RegisterPorts()
	{
		_IsRenderInput = AddValueInput<bool>("是否渲染");
		_Out = AddFlowOutput("Out", "output");
		AddValueOutput("闪避者ID", "avoiderID", () => m_AvoiderID);
		AddValueOutput("攻击者ID", "attackerID", () => m_AttackerID);
	}

	public override void OnGraphStarted()
	{
		if (!_IsRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<UltimateAvoidSucceededEvent>(EvtHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<UltimateAvoidSucceededEvent>(EvtHandler);
		}
	}

	private void EvtHandler(UltimateAvoidSucceededEvent evt)
	{
		Flow f = new Flow
		{
			returnData = _returnData
		};
		m_AvoiderID = evt.mAvoiderID;
		m_AttackerID = evt.mAttackerID;
		_Out.Call(f);
	}
}
