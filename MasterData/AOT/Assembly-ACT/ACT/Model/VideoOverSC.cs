namespace ACT.Model;

public class VideoOverSC : IGuideStepSuccessCondition
{
	public bool IsSuccess(GuideSuccessEventData eventData)
	{
		return eventData is VideoSuccessEvent;
	}
}
