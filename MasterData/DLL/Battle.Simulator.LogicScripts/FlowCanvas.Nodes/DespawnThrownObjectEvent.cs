using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("销毁抛掷物事件", 0)]
[Category("Common/事件")]
[Description("销毁抛掷物的事件")]
public class DespawnThrownObjectEvent : EventNode
{
	protected FlowOutput logicTickEventOutput;

	protected int _caster;

	protected int _timelineID;

	protected int _thrownID;

	protected ValueInput<bool> _isRenderInput;

	protected Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		logicTickEventOutput = AddFlowOutput("输出");
		AddValueOutput("施放者：", () => _caster);
		AddValueOutput("TimelineID：", () => _timelineID);
		AddValueOutput("抛掷物ID：", () => _thrownID);
		_isRenderInput = AddValueInput<bool>("是否渲染");
	}

	public override void OnGraphStarted()
	{
		if (!_isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<DespawnThrownEntityEvent>(OnDespawnThrownObjectEvent);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<DespawnThrownEntityEvent>(OnDespawnThrownObjectEvent);
		}
	}

	public virtual void OnDespawnThrownObjectEvent(DespawnThrownEntityEvent spawnEvent)
	{
		_caster = spawnEvent.Caster;
		_timelineID = spawnEvent.SpawnTimelineID;
		_thrownID = spawnEvent.ThrownID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		logicTickEventOutput.Call(f);
	}
}
