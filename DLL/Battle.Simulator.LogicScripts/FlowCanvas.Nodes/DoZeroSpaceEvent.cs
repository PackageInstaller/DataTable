using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("零时空间事件", 0)]
[Category("Common/事件")]
[Description("不论零时空间的触发条件，该事件都会触发；包括进入和退出两个阶段事件，当零时空间覆盖时，上一个零时空间不会触发退出事件")]
public class DoZeroSpaceEvent : EventNode
{
	private Stack<Flow.ReturnData> _returnData = new Stack<Flow.ReturnData>(16);

	private ValueInput<bool> _IsRenderInput;

	private ValueInput<EnZeroSpaceStep> _ListenState;

	private int _AvoiderID;

	private int _AttackerID;

	private int _Param;

	private FlowOutput _Out;

	protected override void RegisterPorts()
	{
		_IsRenderInput = AddValueInput<bool>("是否渲染");
		_ListenState = AddValueInput<EnZeroSpaceStep>("监听状态", "listenState");
		AddValueOutput("闪避者ID", "avoiderID", () => _AvoiderID);
		AddValueOutput("攻击者ID", "attackerID", () => _AttackerID);
		AddValueOutput("参数", "param", () => _Param);
		_Out = AddFlowOutput("输出");
	}

	public override void OnGraphStarted()
	{
		if (!_IsRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<ZeroSpaceEvent>(EvtHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<ZeroSpaceEvent>(EvtHandler);
		}
	}

	private void EvtHandler(ZeroSpaceEvent evt)
	{
		if (_ListenState.GetValue() == evt.mEnZeroSpaceStep)
		{
			Flow f = new Flow
			{
				returnData = _returnData
			};
			_AvoiderID = evt.mAvoiderID;
			_AttackerID = evt.mAttackerID;
			_Param = evt.mParam;
			_Out.Call(f);
		}
	}
}
