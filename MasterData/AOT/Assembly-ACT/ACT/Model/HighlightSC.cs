using ACT.Battle;

namespace ACT.Model;

public class HighlightSC : IGuideStepSuccessCondition
{
	private InputKey _inputKey;

	public bool IsSuccess(GuideSuccessEventData eventData)
	{
		return eventData is HighlightSuccessEvent;
	}
}
