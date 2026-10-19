using ACT.Event;
using ACT.Model;
using Fundamental;

namespace ACT.Config;

public class RuntimeImageVideoConditon : RuntimeStepCondition
{
	private ImageVideoConditonConfig _config;

	private bool isFinsh;

	public RuntimeImageVideoConditon(ImageVideoConditonConfig config)
		: base(config)
	{
		_config = config;
	}

	public override void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TutorialUnlock, OnTutorialUnlock);
		if (!Model<TutorialModel>.Interface.CanTriggerTutorial(_config.tutorialId))
		{
			isFinsh = true;
		}
	}

	public override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TutorialUnlock, OnTutorialUnlock);
	}

	private void OnTutorialUnlock(BaseEventContent obj)
	{
		if (obj is TutorialUnLockEvent tutorialUnLockEvent && _config.tutorialId == tutorialUnLockEvent.TutorialId)
		{
			isFinsh = true;
		}
	}

	public override bool CheckCondition()
	{
		return isFinsh;
	}
}
