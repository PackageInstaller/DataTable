namespace Sirenix.Utilities;

public interface IGlobalConfigEvents
{
	void OnConfigAutoCreated();

	void OnConfigInstanceFirstAccessed();
}
