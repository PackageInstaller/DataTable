using ACT.Event;
using ACT.Model;
using Fundamental;

namespace ACT.MissionSystem;

public class StartGuideUntilCompletedCondition : MissionCondition
{
	private bool m_Finished;

	protected override void OnInMissionWorld()
	{
		m_Finished = false;
		if (CheckCondition())
		{
			MarkSuccess();
			return;
		}
		StartGuideUntilCompletedConditionParam startGuideUntilCompletedConditionParam = Param as StartGuideUntilCompletedConditionParam;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Guide_Finish, OnGuideFinish);
		Model<GuideModel>.Interface.StartGuide(startGuideUntilCompletedConditionParam.guideId);
	}

	protected override void OnOutMissionWorld()
	{
		m_Finished = false;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Guide_Finish, OnGuideFinish);
	}

	public override bool PreCheckCondition()
	{
		return CheckCondition();
	}

	private bool CheckCondition()
	{
		StartGuideUntilCompletedConditionParam startGuideUntilCompletedConditionParam = Param as StartGuideUntilCompletedConditionParam;
		if (Model<GuideModel>.Interface.GuideHasTriggeredAndFinsh(startGuideUntilCompletedConditionParam.guideId))
		{
			return true;
		}
		return false;
	}

	private void OnGuideFinish(BaseEventContent obj)
	{
		if (obj is GuideFinishEvt guideFinishEvt && (Param as StartGuideUntilCompletedConditionParam).guideId == guideFinishEvt.guideId)
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
