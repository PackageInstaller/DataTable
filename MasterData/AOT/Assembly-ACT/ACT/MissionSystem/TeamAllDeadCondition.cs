using ACT.Event;
using Fundamental;

namespace ACT.MissionSystem;

public class TeamAllDeadCondition : MissionCondition
{
	private bool m_Finished;

	public override bool AllowRepeat => true;

	protected override void OnInMissionWorld()
	{
		m_Finished = false;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Team_RespawnCompelete, OnTeamDead);
	}

	protected override void OnOutMissionWorld()
	{
		m_Finished = false;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Team_RespawnCompelete, OnTeamDead);
	}

	private void OnTeamDead(BaseEventContent obj)
	{
		if (IsRepeat)
		{
			MarkSuccess();
		}
		else if (!m_Finished)
		{
			m_Finished = true;
			MarkSuccess();
		}
	}
}
