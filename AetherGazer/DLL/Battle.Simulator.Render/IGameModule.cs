public interface IGameModule
{
	void Initialize();

	void FixedUpdate();

	void UpdateLogic(SimStateFrame stateFrame);

	void Update();

	void LateUpdate();

	void Reset();

	void Shutdown();
}
