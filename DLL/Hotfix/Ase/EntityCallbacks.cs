using Ase.ECS;

namespace Ase;

public sealed class EntityCallbacks
{
	private readonly EntityReadyCallback m_EntityReadyCallback;

	private readonly EntityStartCallback m_EntityStartCallback;

	private readonly EntityDeadCallback m_EntityDeadCallback;

	private readonly EntityDeadReleaseCallback m_EntityReleaseCallback;

	public EntityReadyCallback EntityReadyCallback => m_EntityReadyCallback;

	public EntityStartCallback EntityStartCallback => m_EntityStartCallback;

	public EntityDeadCallback EntityDeadCallback => m_EntityDeadCallback;

	public EntityDeadReleaseCallback EntityDeadReleaseCallback => m_EntityReleaseCallback;

	public EntityCallbacks(EntityReadyCallback entityReadyCallback, EntityStartCallback entityStartCallback)
		: this(entityReadyCallback, entityStartCallback, null, null)
	{
	}

	public EntityCallbacks(EntityDeadCallback entityDeadCallback, EntityDeadReleaseCallback entityDeadReleaseCallback)
		: this(null, null, entityDeadCallback, entityDeadReleaseCallback)
	{
	}

	public EntityCallbacks(EntityReadyCallback entityReadyCallback, EntityStartCallback entityStartCallback, EntityDeadCallback entityDeadCallback, EntityDeadReleaseCallback entityDeadReleaseCallback)
	{
		m_EntityReadyCallback = entityReadyCallback;
		m_EntityStartCallback = entityStartCallback;
		m_EntityDeadCallback = entityDeadCallback;
		m_EntityReleaseCallback = entityDeadReleaseCallback;
	}

	public void OnAwake(BaseEntity entity)
	{
		m_EntityReadyCallback?.Invoke(entity);
	}

	public void OnStart(BaseEntity entity)
	{
		m_EntityStartCallback?.Invoke(entity);
	}
}
