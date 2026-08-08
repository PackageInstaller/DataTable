public interface IQWAgent
{
	QWAgentLayer GetAgentLayer();

	void Spawn(EntitySpawnedEvent data);

	void Initialize();

	void ActiveAgent();

	void FixedUpdateAgent();

	void UpdateAgent();

	void LateUpdateAgent();

	void ResetAgent();

	void Despawn(EntityDespawnedEvent data);

	void DisposeAgent();
}
