using System;
using ACT.Battle.Configs;
using ACT.World.Asset;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinDamageRequireBreakableByBloodThunderPlatform : BaseAbilityMixin
{
	public AbilityMixinDamageRequireBreakableByBloodThunderPlatform(ConfigMixinDamageRequireBreakableByBloodThunderPlatform config, Ability ab, byte index)
		: base(ab, index)
	{
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility().AddListener(typeof(EvtAttackeeModifyDamage), this);
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (evt is EvtAttackeeModifyDamage { attackData: { } attackData } evtAttackeeModifyDamage && !IsAllowedDamageSource(owner, attackData, evtAttackeeModifyDamage.ability))
		{
			attackData.finalPhaseMul = 0f;
		}
	}

	internal override void OnRemove()
	{
		owner.GetCompAbility().RemoveListener(typeof(EvtAttackeeModifyDamage), this);
	}

	private static bool IsAllowedDamageSource(Entity owner, AttackData attackData, Ability ability)
	{
		if (!owner.TryGetCompStateObject(out CompStateObject component))
		{
			return false;
		}
		if (!(component.StateWorldAssetData is BreakableByBloodThunderPlatformData breakableByBloodThunderPlatformData))
		{
			return false;
		}
		if (IsBloodThunderTrapDamage(attackData))
		{
			return true;
		}
		return IsMonsterSpecialAbilityDamage(attackData, breakableByBloodThunderPlatformData.AbilityName, ability);
	}

	private static bool IsBloodThunderTrapDamage(AttackData attackData)
	{
		if (!HasBloodThunderTrapAssetData(attackData.attacker))
		{
			return HasBloodThunderTrapAssetData(attackData.directAttacker);
		}
		return true;
	}

	private static bool HasBloodThunderTrapAssetData(Entity entity)
	{
		if (entity.IsValid)
		{
			return entity.GetCompStateObject()?.StateWorldAssetData is BloodThunderTrapData;
		}
		return false;
	}

	private static bool IsMonsterSpecialAbilityDamage(AttackData attackData, string[] requiredAbilityName, Ability ability)
	{
		if (requiredAbilityName == null || requiredAbilityName.Length == 0)
		{
			return false;
		}
		Entity attacker = attackData.attacker;
		if (attacker.IsValid && attacker.IsMonster() && ability != null && ability.config != null)
		{
			return Array.IndexOf(requiredAbilityName, ability.config.name) >= 0;
		}
		return false;
	}
}
