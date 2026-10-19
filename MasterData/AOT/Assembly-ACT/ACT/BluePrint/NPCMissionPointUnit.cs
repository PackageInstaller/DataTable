using Unity.VisualScripting;

namespace ACT.BluePrint;

public class NPCMissionPointUnit : MissionPointUnit
{
	public ValueInput npcId;

	protected override void Definition()
	{
		base.Definition();
		npcId = ValueInput("npcId", 0);
	}

	protected override ControlOutput Enter(Flow flow)
	{
		base.Enter(flow);
		bool value = flow.GetValue<bool>(active);
		int value2 = flow.GetValue<int>(npcId);
		if (value)
		{
			m_BpMission.EnableNPCMissionPoint(value2, m_MapArea, (int)m_MapLayer, m_Use3DLogic);
		}
		else
		{
			m_BpMission.DisableNPCAreaMissionPoint(value2);
		}
		return exit;
	}
}
