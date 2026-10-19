using ACT.Battle.Configs;
using ACT.MultiPlayer;
using Bamboo.ECS;

namespace ACT.Battle;

public class BaseAbilityMixin
{
	internal enum PoolState : byte
	{
		None,
		InUse,
		PendingRecycle,
		Available
	}

	protected int m_Priority;

	internal bool isActive;

	protected Ability ability;

	internal AbilityMixinPoolManager.PoolBucket poolBucket;

	internal PoolState poolState;

	protected Entity caster => ability.caster;

	public Entity owner => ability?.owner ?? default(Entity);

	public byte index { get; protected set; }

	public BaseAbilityMixin(Ability ab, byte index)
	{
		ability = ab;
		this.index = index;
		isActive = true;
	}

	internal virtual void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		ability = ab;
		index = newIndex;
		isActive = true;
	}

	internal virtual void ResetForPool()
	{
		ability = null;
		index = 0;
		isActive = false;
		m_Priority = 0;
	}

	internal virtual void OnAdd()
	{
	}

	internal virtual void OnRemove()
	{
	}

	internal virtual void OnAddStack(int add)
	{
	}

	internal virtual void OnRemoveStack(int remove)
	{
	}

	internal virtual void OnSilentRemove()
	{
	}

	internal virtual void TriggerAbility()
	{
	}

	internal virtual void OnEvt(BaseEvt evt)
	{
	}

	internal virtual void ListenEvt(BaseEvt evt)
	{
	}

	internal virtual void FixedUpdate()
	{
	}

	internal virtual void Update()
	{
	}

	internal virtual void LateUpdate()
	{
	}

	internal virtual void SyncFromServer(CmdMixinSync cmd)
	{
	}

	internal virtual void RequestFromClient(CmdMixinRequest cmd)
	{
	}

	internal virtual void OnInheritRemove()
	{
		OnRemove();
	}

	internal virtual void OnInheritAdd()
	{
		OnAdd();
	}

	protected void DoActions(Entity target, BaseEvt evt, ConfigAction[] actions)
	{
		SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(target), evt, ability, actions);
	}

	public virtual int GetPriority()
	{
		return m_Priority;
	}
}
