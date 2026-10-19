using Bamboo.ECS;

namespace ACT.Battle;

public abstract class ECSSystem : ISystem
{
	public abstract Filter MajorFilter { get; }

	public bool isPaused { get; private set; }

	public Bamboo.ECS.World World { get; set; }

	public bool Enabled { get; set; }

	public virtual void FixedUpdate()
	{
	}

	public virtual void LateFixedUpdate()
	{
	}

	public virtual void Update()
	{
	}

	public virtual void LateUpdate()
	{
	}

	internal void Pause()
	{
		if (!isPaused)
		{
			isPaused = true;
			OnPause();
		}
	}

	protected virtual void OnPause()
	{
	}

	internal void Resume()
	{
		if (isPaused)
		{
			isPaused = false;
			OnResume();
		}
	}

	protected virtual void OnResume()
	{
	}

	void ISystem.OnCreate()
	{
		OnCreate();
	}

	void ISystem.OnUpdate()
	{
		Update();
	}

	void ISystem.OnFixedUpdate()
	{
		FixedUpdate();
	}

	void ISystem.OnFixedLateUpdate()
	{
		LateFixedUpdate();
	}

	void ISystem.OnLateUpdate()
	{
		LateUpdate();
	}

	void ISystem.OnDestroy()
	{
		OnDestroy();
	}

	protected abstract void OnCreate();

	protected virtual void OnDestroy()
	{
	}
}
