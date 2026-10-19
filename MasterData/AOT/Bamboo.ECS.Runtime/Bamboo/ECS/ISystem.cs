namespace Bamboo.ECS;

public interface ISystem
{
	World World { get; set; }

	bool Enabled { get; set; }

	void OnCreate();

	void OnUpdate()
	{
	}

	void OnFixedUpdate()
	{
	}

	void OnFixedLateUpdate()
	{
	}

	void OnLateUpdate()
	{
	}

	void OnDestroy();
}
