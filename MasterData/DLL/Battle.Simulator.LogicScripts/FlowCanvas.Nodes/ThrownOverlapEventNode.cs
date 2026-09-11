using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物判定范围触发事件", 0)]
[Category("Common/事件")]
[Description("实体进入和退出抛掷物的判定范围时触发")]
public class ThrownOverlapEventNode : EventNode
{
	private int _thrownID;

	private int _collidedID;

	private int _timelineID;

	private int _index;

	private int _curCollidedCount;

	private int _curCollidedIndex;

	private ThrownOverlapEventState _state;

	private FlowOutput _output;

	private ValueInput<bool> _isRenderInput;

	private ValueInput<ThrownOverlapEventState> _stateInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		_output = AddFlowOutput("Out");
		AddValueOutput("抛掷物ID", () => _thrownID);
		AddValueOutput("接触实体ID", () => _collidedID);
		AddValueOutput("抛掷物TimelineID", () => _timelineID);
		AddValueOutput("第几次判定", () => _index);
		AddValueOutput("本次接触实体总数", () => _curCollidedCount);
		AddValueOutput("本次第几个接触实体", () => _curCollidedIndex);
		AddValueOutput("状态", () => _state);
		_isRenderInput = AddValueInput<bool>("是否渲染");
		_stateInput = AddValueInput<ThrownOverlapEventState>("状态");
	}

	public override void OnGraphStarted()
	{
		if (!_isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<ThrownOverlapEvent>(OnThrownCollidedEventHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<ThrownOverlapEvent>(OnThrownCollidedEventHandler);
		}
	}

	private void OnThrownCollidedEventHandler(ThrownOverlapEvent triggerEvent)
	{
		if (_stateInput.value == ThrownOverlapEventState.none || _stateInput.value == triggerEvent.mState)
		{
			_thrownID = triggerEvent.mThrownID;
			_collidedID = triggerEvent.mColliedID;
			_timelineID = triggerEvent.mTimelineID;
			_index = triggerEvent.mIndex;
			_curCollidedCount = triggerEvent.mCurCollidedCount;
			_curCollidedIndex = triggerEvent.mCurCollidedIndex;
			_state = triggerEvent.mState;
			Flow f = new Flow
			{
				returnData = returnData
			};
			_output.Call(f);
		}
	}
}
