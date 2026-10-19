using System;
using ACT.BluePrint;
using Unity.VisualScripting.Community;

namespace ACT.MissionSystem;

public class GlobalEventCondition : MissionCondition
{
	private bool m_Finished;

	private IDisposable m_Evt;

	public override bool AllowRepeat => true;

	protected override void OnInMissionWorld()
	{
		m_Finished = false;
		m_Evt = GlobalDefinedEventNode.RegisterListener<BPGlobalEvent>(OnTrigger);
	}

	protected override void OnOutMissionWorld()
	{
		m_Finished = false;
		m_Evt?.Dispose();
		m_Evt = null;
	}

	private void OnTrigger<T>(T obj)
	{
		if (!(obj is BPGlobalEvent bPGlobalEvent))
		{
			return;
		}
		GlobalEventConditionParam globalEventConditionParam = Param as GlobalEventConditionParam;
		if (bPGlobalEvent.eventID == globalEventConditionParam.eventId)
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
