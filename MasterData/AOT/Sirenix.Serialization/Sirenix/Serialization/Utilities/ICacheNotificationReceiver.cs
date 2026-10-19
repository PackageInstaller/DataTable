namespace Sirenix.Serialization.Utilities;

public interface ICacheNotificationReceiver
{
	void OnFreed();

	void OnClaimed();
}
