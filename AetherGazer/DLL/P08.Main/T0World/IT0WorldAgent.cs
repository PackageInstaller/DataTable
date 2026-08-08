namespace T0World;

public interface IT0WorldAgent
{
	void Initialize();

	void FixedUpdateAgent();

	void UpdateAgent();

	void LateUpdateAgent();

	void DisposeAgent();
}
