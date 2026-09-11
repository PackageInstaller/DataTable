public interface INAgent
{
	void Spawn(EntitySpawnedEvent data);

	void Initialize();

	void ActiveAgent();

	void StartUpdateAgentLogic();

	void UpdateAgentLogic(SimPersistentState state);

	void LateUpdateAgentLogic(SimPersistentState state);

	void EndUpdateAgentLogic();

	void FixedUpdateAgent();

	void UpdateAgent();

	void LateUpdateAgent();

	void ResetAgent();

	void Despawn(EntityDespawnedEvent data);
}
