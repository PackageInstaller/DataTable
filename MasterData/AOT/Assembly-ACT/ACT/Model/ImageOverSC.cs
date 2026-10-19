namespace ACT.Model;

public class ImageOverSC : IGuideStepSuccessCondition
{
	public bool IsSuccess(GuideSuccessEventData eventData)
	{
		return eventData is ImageSuccessEvent;
	}
}
