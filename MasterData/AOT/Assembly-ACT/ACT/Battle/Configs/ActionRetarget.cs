using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("重定向ActionRetarget", "Action", new string[] { "retarget", "target", "aim" })]
public class ActionRetarget : ConfigAction
{
	public ReTargetType ReTargetType;

	public ConfigAction action;

	public override void Do(ActionMemory memory)
	{
		if (GetRetargetMemory(memory, ReTargetType, out var result))
		{
			action.Do(result);
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, new ConfigAction[1] { action }, ab);
	}

	public static bool GetRetargetMemory(ActionMemory memory, ReTargetType reTargetType, out ActionMemory result)
	{
		result = memory;
		if (reTargetType == ReTargetType.MainEntity)
		{
			Entity mainEntity = MonoECS.instance.mainEntity;
			if (mainEntity != null)
			{
				result = new ActionMemory(memory.caster, memory.owner, mainEntity, memory.evt, memory.ability);
				return true;
			}
		}
		if (memory.evt is IGetAttackData getAttackData)
		{
			switch (reTargetType)
			{
			case ReTargetType.Attacker:
				result = new ActionMemory(memory.caster, memory.owner, getAttackData.GetAttackData().attacker, memory.evt, memory.ability);
				return true;
			case ReTargetType.Attackee:
				result = new ActionMemory(memory.caster, memory.owner, getAttackData.GetAttackData().attackee, memory.evt, memory.ability);
				return true;
			case ReTargetType.DirectAttacker:
				result = new ActionMemory(memory.caster, memory.owner, getAttackData.GetAttackData().directAttacker, memory.evt, memory.ability);
				return true;
			}
		}
		else if (memory.evt is EvtBattleChange evtBattleChange)
		{
			switch (reTargetType)
			{
			case ReTargetType.PreviousCharacter:
				result = new ActionMemory(memory.caster, memory.owner, evtBattleChange.last, memory.evt, memory.ability);
				return true;
			case ReTargetType.NextCharacter:
				result = new ActionMemory(memory.caster, memory.owner, evtBattleChange.next, memory.evt, memory.ability);
				return true;
			}
		}
		else if (memory.evt is BaseAddAbilityEvt baseAddAbilityEvt)
		{
			switch (reTargetType)
			{
			case ReTargetType.AddAbilityCaster:
				result = new ActionMemory(memory.caster, memory.owner, baseAddAbilityEvt.casterEntity, memory.evt, memory.ability);
				return true;
			case ReTargetType.AddAbilityOwner:
				result = new ActionMemory(memory.caster, memory.owner, baseAddAbilityEvt.targetEntity, memory.evt, memory.ability);
				return true;
			}
		}
		else if (memory.evt is IBulletEvt bulletEvt)
		{
			if (reTargetType == ReTargetType.Bullet)
			{
				result = new ActionMemory(memory.caster, memory.owner, bulletEvt.Bullet, memory.evt, memory.ability);
				return true;
			}
		}
		else
		{
			if (memory.evt is ISummonMonster summonMonster)
			{
				result = new ActionMemory(memory.caster, memory.owner, summonMonster.GetSummonMonster(), memory.evt, memory.ability);
				return true;
			}
			if (memory.evt is EvtOnSpawnProduct evtOnSpawnProduct)
			{
				result = new ActionMemory(memory.caster, memory.owner, evtOnSpawnProduct.product, memory.evt, memory.ability);
				return true;
			}
			if (memory.evt is EvtParrySuccess evtParrySuccess)
			{
				switch (reTargetType)
				{
				case ReTargetType.Attacker:
					result = new ActionMemory(memory.caster, memory.owner, evtParrySuccess.attacker, memory.evt, memory.ability);
					return true;
				case ReTargetType.Attackee:
					result = new ActionMemory(memory.caster, memory.owner, evtParrySuccess.attackee, memory.evt, memory.ability);
					return true;
				case ReTargetType.DirectAttacker:
					result = new ActionMemory(memory.caster, memory.owner, evtParrySuccess.directAttacker, memory.evt, memory.ability);
					return true;
				}
			}
			else if (memory.evt is EvtEnterWeak evtEnterWeak)
			{
				switch (reTargetType)
				{
				case ReTargetType.EnterWeakEntity:
					result = new ActionMemory(memory.caster, memory.owner, evtEnterWeak.mainEntity, memory.evt, memory.ability);
					return true;
				case ReTargetType.AddAbilityOwner:
					result = new ActionMemory(memory.caster, memory.owner, memory.owner, memory.evt, memory.ability);
					return true;
				case ReTargetType.AddAbilityCaster:
					result = new ActionMemory(memory.caster, memory.owner, memory.caster, memory.evt, memory.ability);
					return true;
				}
			}
			else if (memory.evt is EvtDeflectSuccess evtDeflectSuccess)
			{
				switch (reTargetType)
				{
				case ReTargetType.Attacker:
					result = new ActionMemory(memory.caster, memory.owner, evtDeflectSuccess.attacker, memory.evt, memory.ability);
					return true;
				case ReTargetType.Attackee:
					result = new ActionMemory(memory.caster, memory.owner, evtDeflectSuccess.attackee, memory.evt, memory.ability);
					return true;
				}
			}
			else
			{
				switch (reTargetType)
				{
				case ReTargetType.ProductOwner:
				{
					CompProduct compProduct2 = memory.target.entity.GetCompProduct();
					if (compProduct2 != null && compProduct2.owner.IsValid)
					{
						result = new ActionMemory(memory.caster, memory.owner, FindTargetResult.EntityOnly(compProduct2.productOwner), memory.evt, memory.ability);
					}
					return true;
				}
				case ReTargetType.ProductCaster:
				{
					CompProduct compProduct = memory.target.entity.GetCompProduct();
					if (compProduct != null && compProduct.owner.IsValid)
					{
						result = new ActionMemory(memory.caster, memory.owner, FindTargetResult.EntityOnly(compProduct.caster), memory.evt, memory.ability);
					}
					return true;
				}
				case ReTargetType.CurAbilityCaster:
					result = new ActionMemory(memory.caster, memory.owner, memory.ability.caster, memory.evt, memory.ability);
					return true;
				case ReTargetType.CurAbilityOwner:
					result = new ActionMemory(memory.caster, memory.owner, memory.ability.owner, memory.evt, memory.ability);
					return true;
				case ReTargetType.MemoryCaster:
					result = new ActionMemory(memory.owner, memory.owner, memory.caster, memory.evt, memory.ability);
					return true;
				}
			}
		}
		return false;
	}
}
