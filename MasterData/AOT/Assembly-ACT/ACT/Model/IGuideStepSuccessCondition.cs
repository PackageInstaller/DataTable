namespace ACT.Model;

public interface IGuideStepSuccessCondition
{
	bool IsSuccess(GuideSuccessEventData eventData);
}
