using Bamboo.ECS;

namespace ACT.Battle;

public abstract class EcsComponent : IComponent
{
	public Entity owner { get; private set; }

	public virtual bool NeedPrint => false;

	void IComponent.Init(Entity entity)
	{
		owner = entity;
	}

	public virtual string GetPrintLog()
	{
		return string.Empty;
	}

	void IComponent.OnGet()
	{
		OnGet();
	}

	protected abstract void OnGet();

	void IComponent.OnRelease()
	{
		OnRelease();
		owner = Entity.Invalid;
	}

	protected abstract void OnRelease();
}
