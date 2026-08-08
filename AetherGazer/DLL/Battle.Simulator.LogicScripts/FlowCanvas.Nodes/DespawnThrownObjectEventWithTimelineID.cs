using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("销毁抛掷物事件(TimelineID)", 0)]
[Category("Common/事件")]
[Description("销毁抛掷物的事件")]
public class DespawnThrownObjectEventWithTimelineID : DespawnThrownObjectEvent
{
	private ValueInput<int> _timelineIDInput;

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		_timelineIDInput = AddValueInput<int>("TimelineID");
	}

	public override void OnDespawnThrownObjectEvent(DespawnThrownEntityEvent spawnEvent)
	{
		if (spawnEvent.SpawnTimelineID == _timelineIDInput.value)
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
}
