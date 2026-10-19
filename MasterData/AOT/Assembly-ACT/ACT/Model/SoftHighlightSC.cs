namespace ACT.Model;

public class SoftHighlightSC : IGuideStepSuccessCondition
{
	public bool IsSuccess(GuideSuccessEventData eventData)
	{
		return eventData is HighlightSuccessEvent;
	}
}
