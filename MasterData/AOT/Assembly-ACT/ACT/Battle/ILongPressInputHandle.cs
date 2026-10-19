namespace ACT.Battle;

public interface ILongPressInputHandle
{
	float CurrentPressTime { get; }

	float TotalRequiredPressTime { get; }

	bool TimeIsReach();

	bool IsValid();
}
