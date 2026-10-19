using System;
using ACT.BluePrint;
using Unity.VisualScripting.Community;

namespace ACT.MissionSystem;

public class GlobalStringEventCondition : MissionCondition
{
	private bool m_Finished;

	private IDisposable m_Evt;

	public override bool AllowRepeat => true;

	protected override void OnInMissionWorld()
	{
		m_Finished = false;
		m_Evt = GlobalDefinedEventNode.RegisterListener<BPGlobalStringEvent>(OnTrigger);
	}

	protected override void OnOutMissionWorld()
	{
		m_Finished = false;
		m_Evt?.Dispose();
		m_Evt = null;
	}

	private void OnTrigger<T>(T obj)
	{
		if (!(obj is BPGlobalStringEvent bPGlobalStringEvent))
		{
			return;
		}
		GlobalStringEventConditionParam globalStringEventConditionParam = Param as GlobalStringEventConditionParam;
		if (!string.IsNullOrEmpty(globalStringEventConditionParam.eventId) && string.Equals(bPGlobalStringEvent.eventID, globalStringEventConditionParam.eventId))
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
