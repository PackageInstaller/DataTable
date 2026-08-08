using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物接触事件", 0)]
[Category("Common/事件")]
[Description("当抛掷物接触到实体后发出;\n抛掷物ID:Thrown ID;\n接触实体ID:EntityID;\n抛掷物TimelineID:抛掷物的TimelineID;\n第几次判定:第几个ThrownCollisionCheckInfo触发,现已存到ThrownState的mConllisionCheckIndex变量中;\n是否最后接触实体:一次碰撞可能接触到多个实体,每个接触实体都会发送消息,这里用以标记是否是本次接触发送消息的最后一个实体")]
public class ThrownCollidedEntityEvent : EventNode
{
	private int _thrownID;

	private int _collidedID;

	private int _timelineID;

	private int _index;

	private int _curCollidedCount;

	private int _curCollidedIndex;

	private int _targetPartID;

	private FlowOutput _output;

	private ValueInput<bool> _isRenderInput;

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
		AddValueOutput("命中部位", () => _targetPartID);
		_isRenderInput = AddValueInput<bool>("是否渲染");
	}

	public override void OnGraphStarted()
	{
		if (!_isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<ThrownCollidedEvent>(OnThrownCollidedEventHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<ThrownCollidedEvent>(OnThrownCollidedEventHandler);
		}
	}

	private void OnThrownCollidedEventHandler(ThrownCollidedEvent triggerEvent)
	{
		_thrownID = triggerEvent.mThrownID;
		_collidedID = triggerEvent.mColliedID;
		_timelineID = triggerEvent.mTimelineID;
		_index = triggerEvent.mIndex;
		_curCollidedCount = triggerEvent.mCurCollidedCount;
		_curCollidedIndex = triggerEvent.mCurCollidedIndex;
		_targetPartID = triggerEvent.mTargetPartID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		_output.Call(f);
	}
}
