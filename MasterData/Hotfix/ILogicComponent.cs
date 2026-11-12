public interface ILogicComponent
{
	bool ActiveSelf { get; set; }

	void SetEntity(ILogicEntity entity);

	void Init();

	void OnActive();

	void OnDeactive();

	void Shutdown();
}
