using Fundamental;

namespace ACT;

public abstract class GameSubManager : IUpdateableManager
{
	ContextState IUpdateableManager.State { get; set; } = ContextState.Reset;

	GizmosDrawType IUpdateableManager.GizmosDrawType => GetGizmosDrawType();

	public abstract ContextType ContextType { get; }

	protected virtual GizmosDrawType GetGizmosDrawType()
	{
		return GizmosDrawType.None;
	}

	void IUpdateableManager.DrawGizmos()
	{
		DrawGizmos();
	}

	protected virtual void DrawGizmos()
	{
	}

	void IUpdateableManager.Update()
	{
		Update();
	}

	protected virtual void Update()
	{
	}

	void IUpdateableManager.LateUpdate()
	{
		LateUpdate();
	}

	protected virtual void LateUpdate()
	{
	}

	void IUpdateableManager.FixedUpdate()
	{
		FixedUpdate();
	}

	protected virtual void FixedUpdate()
	{
	}

	void IUpdateableManager.FixedLateUpdate()
	{
		FixedLateUpdate();
	}

	protected virtual void FixedLateUpdate()
	{
	}

	void IUpdateableManager.Reset()
	{
		if (((IUpdateableManager)this).State == ContextState.Loaded)
		{
			UnInit();
			((IUpdateableManager)this).State = ContextState.Reset;
		}
	}

	void IUpdateableManager.Initialize()
	{
		if (((IUpdateableManager)this).State != ContextState.Loaded)
		{
			((IUpdateableManager)this).State = ContextState.Loaded;
			Init();
		}
	}

	protected abstract void Init();

	protected abstract void UnInit();
}
