using System;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

public struct ActionMemory : IEquatable<ActionMemory>
{
	public Entity caster { get; private set; }

	public Entity owner { get; private set; }

	public FindTargetResult target { get; private set; }

	public BaseEvt evt { get; private set; }

	public Ability ability { get; private set; }

	public ActionMemory(Entity caster, Entity owner, FindTargetResult target, BaseEvt evt = null, Ability ability = null)
	{
		this.caster = caster;
		this.owner = owner;
		this.target = target;
		this.evt = evt;
		this.ability = ability;
	}

	public ActionMemory(Entity caster, Entity owner, Entity target, BaseEvt evt = null, Ability ability = null)
	{
		this.caster = caster;
		this.owner = owner;
		this.target = FindTargetResult.EntityOnly(target);
		this.evt = evt;
		this.ability = ability;
	}

	public Entity GetEntityReference(MemoryEntityRef memoryEntityRef)
	{
		return memoryEntityRef switch
		{
			MemoryEntityRef.Caster => caster, 
			MemoryEntityRef.Owner => owner, 
			MemoryEntityRef.Target => target.entity, 
			_ => throw new NotImplementedException(), 
		};
	}

	public BattleBlackboard GetBlackboard(BlackboardScope scope)
	{
		CompAbility component;
		return scope switch
		{
			BlackboardScope.Ability => (BattleBlackboard)(ability?.Blackboard), 
			BlackboardScope.OwnerEntity => owner.TryGetCompAbility(out component) ? component.EntityBlackboard : null, 
			_ => null, 
		};
	}

	public BattleBlackboard GetOrCreateBlackboard(BlackboardScope scope)
	{
		CompAbility component;
		return scope switch
		{
			BlackboardScope.Ability => (BattleBlackboard)(ability?.GetOrCreateBlackboard()), 
			BlackboardScope.OwnerEntity => owner.TryGetCompAbility(out component) ? component.GetOrCreateEntityBlackboard() : null, 
			_ => null, 
		};
	}

	public bool Equals(ActionMemory other)
	{
		if (caster.Equals(other.caster) && owner.Equals(other.owner) && target.Equals(other.target) && evt == other.evt)
		{
			return ability == other.ability;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is ActionMemory other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return HashCode.Combine(caster, owner, target, evt, ability);
	}
}
