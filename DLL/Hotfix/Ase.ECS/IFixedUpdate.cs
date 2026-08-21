namespace Ase.ECS;

public interface IFixedUpdate
{
	void OnFixedUpdateBefore(WorldUpdateType updateType);

	void OnFixedUpdate(WorldUpdateType updateType, float deltaTime);

	void OnFixedUpdateAfter(WorldUpdateType updateType);
}
