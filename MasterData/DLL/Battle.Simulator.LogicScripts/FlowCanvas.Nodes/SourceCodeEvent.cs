using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修正模式事件", 0)]
[Category("Common/事件")]
[Description("修正模式进入或退出时的事件")]
public class SourceCodeEvent : EventNode, IUpdatable
{
	private FlowOutput _out;

	private ValueInput<bool> _isRenderInput;

	private ValueInput<SourceSpaceEvent.E_SourceSpaceState> _listenState;

	private Stack<Flow.ReturnData> _returnData = new Stack<Flow.ReturnData>(16);

	private int m_keepTime = -1;

	private int m_raceID = -1;

	private int m_breakEntityID;

	private bool isStart;

	private int frameCount;

	protected override void RegisterPorts()
	{
		_isRenderInput = AddValueInput<bool>("是否渲染");
		_listenState = AddValueInput<SourceSpaceEvent.E_SourceSpaceState>("监听状态");
		AddValueOutput("持续时长", "keepTime", () => m_keepTime);
		AddValueOutput("阵营ID", "raceID", () => m_raceID);
		AddValueOutput("Break实体ID", "breakEntityID", () => m_breakEntityID);
		_out = AddFlowOutput("输出");
	}

	public override void OnGraphStarted()
	{
		if (!_isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<SourceSpaceEvent>(OnSourceCodeEventHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<SourceSpaceEvent>(OnSourceCodeEventHandler2);
		}
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		isStart = false;
		frameCount = 0;
	}

	private void OnSourceCodeEventHandler(SourceSpaceEvent sourceSpaceEvent)
	{
		if (_listenState.value == sourceSpaceEvent.mState)
		{
			Flow f = new Flow
			{
				returnData = _returnData
			};
			m_keepTime = sourceSpaceEvent.mKeepTime;
			m_raceID = sourceSpaceEvent.mRaceID;
			m_breakEntityID = sourceSpaceEvent.mTargetEntityID;
			_out.Call(f);
		}
	}

	private void OnSourceCodeEventHandler2(SourceSpaceEvent sourceSpaceEvent)
	{
		if (_listenState.value == sourceSpaceEvent.mState)
		{
			Flow flow = new Flow
			{
				returnData = _returnData
			};
			m_keepTime = sourceSpaceEvent.mKeepTime;
			m_raceID = sourceSpaceEvent.mRaceID;
			m_breakEntityID = sourceSpaceEvent.mTargetEntityID;
			isStart = true;
			frameCount = 0;
		}
	}

	public void Update()
	{
		if (isStart)
		{
			frameCount++;
		}
		if (frameCount == 2)
		{
			isStart = false;
			frameCount = 0;
			Flow f = new Flow
			{
				returnData = _returnData
			};
			_out.Call(f);
		}
	}
}
