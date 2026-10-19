using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinDamageRequireSystemUnlock : BaseAbilityMixin
{
	private ConfigMixinDamageRequireSystemUnlock _config;

	public AbilityMixinDamageRequireSystemUnlock(ConfigMixinDamageRequireSystemUnlock config, Ability ab, byte index)
		: base(ab, index)
	{
		_config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		_config = (ConfigMixinDamageRequireSystemUnlock)config;
	}

	internal override void ResetForPool()
	{
		_config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility().AddListener(typeof(EvtAttackeeModifyDamage), this);
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (!(evt is EvtAttackeeModifyDamage evtAttackeeModifyDamage))
		{
			return;
		}
		CheckSystemUnLock systemUnLockPredicate = _config.systemUnLockPredicate;
		bool flag = systemUnLockPredicate.Check(new ActionMemory(caster, owner, owner, evt, ability));
		if (evtAttackeeModifyDamage.GetAttackData().attacker.IsCharacter())
		{
			if (systemUnLockPredicate.Inverse ? (!flag) : flag)
			{
				evtAttackeeModifyDamage.attackData.finalPhaseMul = 0f;
			}
		}
		else
		{
			evtAttackeeModifyDamage.attackData.finalPhaseMul = 0f;
		}
	}

	internal override void OnRemove()
	{
		owner.GetCompAbility().RemoveListener(typeof(EvtAttackeeModifyDamage), this);
	}
}
