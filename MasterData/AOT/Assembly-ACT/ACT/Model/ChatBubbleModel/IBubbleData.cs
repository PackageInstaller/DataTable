using ACT.Condition.Interface;

namespace ACT.Model.ChatBubbleModel;

public interface IBubbleData
{
	bool IsLoop => true;

	float DistanceToShow => 10f;

	float DistanceToHide => 50f;

	int BubbleGroupId { get; }

	IValueChangeNotify Condition { get; }
}
