using ACT.Event;
using Fundamental;

namespace ACT.MissionSystem;

public class OnReceiveClientEventCondition : MissionCondition
{
	private bool m_Finished;

	public override bool AllowRepeat => true;

	protected override void OnInMissionWorld()
	{
		m_Finished = false;
		OnReceiveClientEventConditionParam onReceiveClientEventConditionParam = Param as OnReceiveClientEventConditionParam;
		Singleton<EventManager>.instance.AddEventListener(onReceiveClientEventConditionParam.clientEvent, OnReceiveClientEvent);
	}

	protected override void OnOutMissionWorld()
	{
		m_Finished = false;
		OnReceiveClientEventConditionParam onReceiveClientEventConditionParam = Param as OnReceiveClientEventConditionParam;
		Singleton<EventManager>.instance.RemoveEventListener(onReceiveClientEventConditionParam.clientEvent, OnReceiveClientEvent);
	}

	private void OnReceiveClientEvent(BaseEventContent obj)
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
