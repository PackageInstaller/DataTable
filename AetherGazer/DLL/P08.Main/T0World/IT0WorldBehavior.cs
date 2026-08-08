namespace T0World;

public interface IT0WorldBehavior
{
	void Initialize();

	void FixedUpdateBehavior();

	void UpdateBehavior();

	void LateUpdateBehavior();

	void DestroyBehavior();

	void OnLowMemory();
}
