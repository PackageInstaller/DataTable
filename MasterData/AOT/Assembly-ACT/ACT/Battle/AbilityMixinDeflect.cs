using ACT.Battle.Configs;
using Bamboo.ECS;
using Battle.Configs;
using Fundamental;

namespace ACT.Battle;

public class AbilityMixinDeflect : BaseAbilityMixin
{
	private ConfigMixinDeflect m_Config;

	public AbilityMixinDeflect(ConfigMixinDeflect config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinDeflect)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility().AddListener(typeof(EvtModifyDamage), this);
	}

	internal override void OnRemove()
	{
		owner.GetCompAbility().RemoveListener(typeof(EvtModifyDamage), this);
	}

	internal override void OnSilentRemove()
	{
		OnRemove();
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (evt is EvtModifyDamage evtModifyDamage)
		{
			Entity attackee = evtModifyDamage.attackData.attackee;
			if (attackee.GetAlliance() == Alliance.Enemy && attackee.InTag(MotionTag_backUp.CanBeDeflect))
			{
				SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
				EvtDeflectSuccess evt2 = systemAbility.GetEvt<EvtDeflectSuccess>(owner, ability);
				systemAbility.FireEvt(evt2);
				systemAbility.ReleaseEvt(evt2);
				SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(owner), null, ability, m_Config.deflectSuccessActions);
			}
		}
	}
}
