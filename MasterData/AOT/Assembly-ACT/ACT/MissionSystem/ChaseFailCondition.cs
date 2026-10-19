using ACT.Event;
using Fundamental;

namespace ACT.MissionSystem;

public class ChaseFailCondition : MissionCondition
{
	private bool m_Finished;

	public override bool AllowRepeat => true;

	protected override void OnActivate()
	{
		m_Finished = false;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Chase_Fail, OnReceiveClientEvent);
	}

	protected override void OnDeactivate()
	{
		m_Finished = false;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Chase_Fail, OnReceiveClientEvent);
	}

	private void OnReceiveClientEvent(BaseEventContent obj)
	{
		if (InMissionWorld)
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
}
