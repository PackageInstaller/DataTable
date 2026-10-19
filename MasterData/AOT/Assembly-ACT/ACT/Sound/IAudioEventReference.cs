namespace ACT.Sound;

public interface IAudioEventReference
{
	string GetEventPath();

	bool IsMultilingualEvent();

	bool IsNull();
}
