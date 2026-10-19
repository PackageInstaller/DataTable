using ACT.World;
using Unity.VisualScripting;

namespace ACT.BluePrint;

[UnitCategory("ACT")]
public class MissionPointUnit : Unit
{
	[DoNotSerialize]
	public ControlInput input;

	[DoNotSerialize]
	public ControlOutput exit;

	public ValueInput active;

	public ValueInput mapArea;

	public ValueInput mapLayer;

	public ValueInput use3DLogic;

	protected BPMission m_BpMission;

	protected MapLayer m_MapLayer;

	protected MapArea m_MapArea;

	protected bool m_Use3DLogic;

	protected override void Definition()
	{
		input = ControlInput("input", (Flow x) => Enter(x));
		exit = ControlOutput("exit");
		active = ValueInput("active", @default: true);
		mapArea = ValueInput("mapArea", MapArea.Arsenal);
		mapLayer = ValueInput("mapLayer", MapLayer.L0);
		use3DLogic = ValueInput("use3DLogic", @default: false);
		Succession(input, exit);
	}

	protected virtual ControlOutput Enter(Flow flow)
	{
		m_MapLayer = flow.GetValue<MapLayer>(mapLayer);
		m_MapArea = flow.GetValue<MapArea>(mapArea);
		m_Use3DLogic = flow.GetValue<bool>(use3DLogic);
		return exit;
	}

	public override void Instantiate(GraphReference instance)
	{
		base.Instantiate(instance);
		m_BpMission = instance.self.GetComponent<BPMission>();
	}
}
