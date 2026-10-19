using ACT.Event;
using Fundamental;

namespace ACT.Config;

public class RuntimeGuideTypeFinishCondition : RuntimeStepCondition
{
	private GuideTypeFinishConditionConfig _config;

	private bool isFinsh;

	public RuntimeGuideTypeFinishCondition(GuideStepFinishConditionConfig config)
		: base(config)
	{
		_config = config as GuideTypeFinishConditionConfig;
	}

	public override void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Guide_StepFinish, OnStepFinish);
	}

	private void OnStepFinish(BaseEventContent obj)
	{
		if (obj is GuideStepFinishEvt guideStepFinishEvt && guideStepFinishEvt.type == _config.GuideType)
		{
			isFinsh = true;
		}
	}

	public override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Guide_StepFinish, OnStepFinish);
	}

	public override bool CheckCondition()
	{
		return isFinsh;
	}
}
