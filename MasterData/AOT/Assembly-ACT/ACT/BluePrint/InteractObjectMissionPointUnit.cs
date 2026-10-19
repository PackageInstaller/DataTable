using Unity.VisualScripting;

namespace ACT.BluePrint;

public class InteractObjectMissionPointUnit : MissionPointUnit
{
	public ValueInput uid;

	protected override void Definition()
	{
		base.Definition();
		uid = ValueInput("uid", 0);
	}

	protected override ControlOutput Enter(Flow flow)
	{
		base.Enter(flow);
		bool value = flow.GetValue<bool>(active);
		int value2 = flow.GetValue<int>(uid);
		if (value)
		{
			m_BpMission.EnableInteractObjectMissionPoint(value2, m_MapArea, (int)m_MapLayer, m_Use3DLogic);
		}
		else
		{
			m_BpMission.DisableInteractObjectAreaMissionPoint(value2);
		}
		return exit;
	}
}
