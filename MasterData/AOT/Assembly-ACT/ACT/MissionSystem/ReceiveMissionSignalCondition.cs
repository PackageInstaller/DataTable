using System;

namespace ACT.MissionSystem;

public class ReceiveMissionSignalCondition : MissionCondition
{
	private bool m_Finished;

	public override bool AllowRepeat => true;

	protected override void OnInMissionWorld()
	{
		m_Finished = false;
		Flow.AddSignalListener(OnSignalReceived);
	}

	protected override void OnOutMissionWorld()
	{
		m_Finished = false;
		Flow.RemoveSignalListener(OnSignalReceived);
	}

	private void OnSignalReceived(string signal)
	{
		ReceiveMissionSignalConditionParam receiveMissionSignalConditionParam = Param as ReceiveMissionSignalConditionParam;
		if (InMissionWorld && receiveMissionSignalConditionParam != null && !string.IsNullOrEmpty(receiveMissionSignalConditionParam.signal) && string.Equals(signal, receiveMissionSignalConditionParam.signal, StringComparison.Ordinal))
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
