using ACT.Battle.Configs;
using ACT.Event;
using ACT.Sound;
using Bamboo.ECS;
using Battle.Configs;
using Fundamental;

namespace ACT.Battle;

public class AbilityMixinParry : BaseAbilityMixin
{
	private ConfigMixinParry m_Config;

	public AbilityMixinParry(ConfigMixinParry config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinParry)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		CompAbility? compAbility = owner.GetCompAbility();
		compAbility.AddListener(typeof(EvtAttackeeModifyDamage), this);
		compAbility.AddListener(typeof(EvtAttackeeParryCheck), this);
	}

	internal override void OnRemove()
	{
		CompAbility? compAbility = owner.GetCompAbility();
		compAbility.RemoveListener(typeof(EvtAttackeeModifyDamage), this);
		compAbility.RemoveListener(typeof(EvtAttackeeParryCheck), this);
	}

	internal override void OnSilentRemove()
	{
		OnRemove();
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (!(evt is EvtAttackeeModifyDamage evtAttackeeModifyDamage))
		{
			return;
		}
		Adjust1AttackTypeTag adjust1AttackType = evtAttackeeModifyDamage.attackData.adjust1AttackType;
		if (evtAttackeeModifyDamage.attackData.hitTag.HasFlag(HitTag.NoParry) || adjust1AttackType == Adjust1AttackTypeTag.Trap)
		{
			return;
		}
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtParrySuccess evt2 = systemAbility.GetEvt<EvtParrySuccess>(owner, ability);
		evt2.mainEntity = owner;
		evt2.ownerEntity = owner;
		evt2.attackee = evtAttackeeModifyDamage.attackData.attackee;
		evt2.attacker = evtAttackeeModifyDamage.attackData.attacker;
		evt2.directAttacker = evtAttackeeModifyDamage.attackData.directAttacker;
		systemAbility.FireEvt(evt2);
		systemAbility.ReleaseEvt(evt2);
		SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(owner), evt, ability, m_Config.parrySuccessActions);
		if (!GameLoader.meta.parrySoundEvent.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(GameLoader.meta.parrySoundEvent, new AudioPlayOptions
			{
				attachTarget = owner.GetRootTransform()
			});
		}
		TriggerBlockEvt evt3 = Singleton<EventManager>.instance.GetEvt<TriggerBlockEvt>();
		if (owner.IsCharacter())
		{
			CompCharacter compCharacter = owner.GetCompCharacter();
			if (compCharacter != null && compCharacter.characterSource != null)
			{
				evt3.characterId = compCharacter.characterSource.Id();
			}
		}
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TriggerBlock, evt3);
		Singleton<EventManager>.instance.ReleaseEvt(evt3);
	}
}
